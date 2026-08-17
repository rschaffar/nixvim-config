# shellcheck shell=bash

usage() {
  echo "Usage: java-import-sbt [--check] [PATH]" >&2
  exit 64
}

mode=import
if [[ ${1:-} == "--check" ]]; then
  mode=check
  shift
fi
[[ $# -le 1 ]] || usage

start=${1:-$PWD}
if [[ ! -d $start ]]; then
  start=$(dirname "$start")
fi
if [[ ! -d $start ]]; then
  echo "Not a directory: $start" >&2
  exit 2
fi
start=$(realpath "$start")

find_sbt_root() {
  local current=$1
  while true; do
    if [[ -f $current/project/build.properties || -f $current/build.sbt ]]; then
      printf '%s\n' "$current"
      return 0
    fi
    [[ $current == "/" ]] && return 1
    current=$(dirname "$current")
  done
}

root=$(find_sbt_root "$start") || {
  echo "No SBT build found above $start" >&2
  exit 2
}

metadata_state() {
  local classpath=$root/.classpath
  local project=$root/.project
  local input

  if [[ ! -f $classpath || ! -f $project ]]; then
    echo missing
    return
  fi

  for input in "$root/build.sbt" "$root/project/build.properties"; do
    if [[ -f $input && $input -nt $classpath ]]; then
      echo stale
      return
    fi
  done

  if [[ -d $root/project ]]; then
    while IFS= read -r -d '' input; do
      if [[ $input -nt $classpath ]]; then
        echo stale
        return
      fi
    done < <(
      find "$root/project" -maxdepth 1 -type f \
        \( \( -name '*.sbt' ! -name metals.sbt \) -o -name '*.scala' \) \
        -print0
    )
  fi

  echo current
}

if [[ $mode == "check" ]]; then
  state=$(metadata_state)
  echo "$state"
  case $state in
    current) exit 0 ;;
    missing) exit 10 ;;
    stale) exit 11 ;;
    *) exit 2 ;;
  esac
fi

: "${SBT_ECLIPSE_PLUGIN:?SBT_ECLIPSE_PLUGIN is not configured}"

if [[ -x $root/sbt ]]; then
  sbt_command=("$root/sbt")
elif [[ -x $root/sbtw ]]; then
  sbt_command=("$root/sbtw")
else
  sbt_command=(sbt)
fi

(
  cd "$root" || exit
  "${sbt_command[@]}" \
    "--addPluginSbtFile=$SBT_ECLIPSE_PLUGIN" \
    "set Global / EclipseKeys.projectFlavor := EclipseProjectFlavor.Java" \
    eclipse
)

if [[ $(metadata_state) != current ]]; then
  echo "sbt-eclipse finished without producing current .project/.classpath metadata" >&2
  exit 1
fi

if git -C "$root" rev-parse --git-dir >/dev/null 2>&1; then
  exclude_path=$(git -C "$root" rev-parse --git-path info/exclude)
  if [[ $exclude_path != /* ]]; then
    exclude_path=$root/$exclude_path
  fi
  mkdir -p "$(dirname "$exclude_path")"
  touch "$exclude_path"
  for pattern in .classpath .project .settings/; do
    if ! grep -Fqx -- "$pattern" "$exclude_path"; then
      echo "$pattern" >>"$exclude_path"
    fi
  done
fi

echo "Generated Eclipse metadata in $root"
