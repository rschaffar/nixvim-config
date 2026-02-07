{ pkgs, ... }:
let
  debugpyPython = pkgs.python3.withPackages (ps: [ ps.debugpy ]);
in
{
  plugins.dap.enable = true;
  plugins.dap-ui.enable = true;
  plugins.dap-virtual-text.enable = true;

  # DAP UI auto open/close and adapters
  extraConfigLua = ''
    local dap = require("dap")
    local dapui = require("dapui")

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Python adapter
    local function python_path()
      local venv = os.getenv("VIRTUAL_ENV")
      if venv and venv ~= "" then
        return venv .. "/bin/python"
      end
      local debugpy_python = os.getenv("DEBUGPY_PYTHON")
      if debugpy_python and debugpy_python ~= "" then
        return debugpy_python
      end
      local exe = vim.fn.exepath("python3")
      if exe ~= "" then
        return exe
      end
      return "python3"
    end

    dap.adapters.python = function(cb, _)
      cb({
        type = "executable",
        command = python_path(),
        args = { "-m", "debugpy.adapter" },
      })
    end

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "''${file}",
        pythonPath = python_path,
        justMyCode = false,
        args = function()
          local input = vim.fn.input("Args: ")
          return vim.fn.split(input, " ")
        end,
      },
      {
        type = "python",
        request = "launch",
        name = "Launch module",
        module = function()
          return vim.fn.input("Module: ")
        end,
        pythonPath = python_path,
        args = function()
          local input = vim.fn.input("Args: ")
          return vim.fn.split(input, " ")
        end,
      },
      {
        type = "python",
        request = "attach",
        name = "Attach (debugpy)",
        connect = function()
          local host = vim.fn.input("Host [127.0.0.1]: ")
          if host == "" then host = "127.0.0.1" end
          local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
          return { host = host, port = port }
        end,
      },
    }

    -- Java adapter (attach mode)
    dap.adapters.java = function(callback, config)
      local host = config.hostName or config.host or "127.0.0.1"
      local port = config.port or 5005
      callback({ type = "server", host = host, port = port })
    end

    dap.configurations.java = {
      {
        type = "java",
        request = "attach",
        name = "Attach to JVM",
        hostName = "127.0.0.1",
        port = 5005,
      },
    }
  '';

  extraPackages = [ debugpyPython ];
}
