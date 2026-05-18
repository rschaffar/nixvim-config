{ pkgs, ... }:
let
  javaDebugServer = "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server";
  javaTestServer = "${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server";
in
{
  extraPlugins = with pkgs.vimPlugins; [
    nvim-jdtls
    neotest
    neotest-java
    plenary-nvim
    nvim-nio
    FixCursorHold-nvim
  ];

  extraPackages = with pkgs; [
    jdt-language-server
    jdk17
    jdk21
  ];

  extraConfigLua = ''
    do
      local ok_neotest, neotest = pcall(require, "neotest")
      if ok_neotest then
        neotest.setup({
          adapters = {
            require("neotest-java")({
              incremental_build = false,
            }),
          },
        })
      end
    end

    local java_group = vim.api.nvim_create_augroup("UserJavaConfig", { clear = true })

    local function java_bundles()
      local bundles = {}

      vim.list_extend(
        bundles,
        vim.fn.glob("${javaDebugServer}/com.microsoft.java.debug.plugin-*.jar", true, true)
      )

      local excluded = {
        ["com.microsoft.java.test.runner-jar-with-dependencies.jar"] = true,
        ["jacocoagent.jar"] = true,
      }

      for _, bundle in ipairs(vim.fn.glob("${javaTestServer}/*.jar", true, true)) do
        local name = vim.fn.fnamemodify(bundle, ":t")
        if not excluded[name] then
          table.insert(bundles, bundle)
        end
      end

      return bundles
    end

    local function java_capabilities()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end
      return capabilities
    end

    local function setup_java_dap()
      if vim.g.java_dap_setup_done then
        return
      end

      local ok_jdtls, jdtls = pcall(require, "jdtls")
      if not ok_jdtls then
        return
      end

      jdtls.setup_dap({ hotcodereplace = "auto" })

      local ok_dap, dap = pcall(require, "dap")
      if ok_dap then
        dap.configurations.java = dap.configurations.java or {}

        local has_attach = false
        for _, config in ipairs(dap.configurations.java) do
          if config.request == "attach" and config.name == "Attach to JVM" then
            has_attach = true
            break
          end
        end

        if not has_attach then
          table.insert(dap.configurations.java, {
            type = "java",
            request = "attach",
            name = "Attach to JVM",
            hostName = "127.0.0.1",
            port = 5005,
          })
        end
      end

      vim.g.java_dap_setup_done = true
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = java_group,
      pattern = "java",
      callback = function(args)
        local ok_jdtls, jdtls = pcall(require, "jdtls")
        if not ok_jdtls then
          vim.notify("nvim-jdtls is not available", vim.log.levels.ERROR)
          return
        end

        local root_markers = {
          "mvnw",
          "gradlew",
          "pom.xml",
          "build.gradle",
          "build.gradle.kts",
          "settings.gradle",
          "settings.gradle.kts",
        }

        local root_dir = vim.fs.root(args.buf, ".git")
        if not root_dir then
          root_dir = vim.fs.root(args.buf, root_markers)
        end
        if not root_dir then
          root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf))
        end

        local project_name = (vim.fs.basename(root_dir) or "java-project") .. "-" .. vim.fn.sha256(root_dir):sub(1, 8)
        local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

        local config = {
          name = "jdtls",
          cmd = {
            "jdtls",
            "-data",
            workspace_dir,
          },
          root_dir = root_dir,
          capabilities = java_capabilities(),
          init_options = {
            bundles = java_bundles(),
          },
          settings = {
            java = {
              configuration = {
                runtimes = {
                  {
                    name = "JavaSE-17",
                    path = "${pkgs.jdk17}/lib/openjdk",
                  },
                  {
                    name = "JavaSE-21",
                    path = "${pkgs.jdk21}/lib/openjdk",
                    default = true,
                  },
                },
              },
            },
          },
          on_attach = function(_, _)
            setup_java_dap()
          end,
        }

        jdtls.start_or_attach(config)
      end,
    })
  '';
}
