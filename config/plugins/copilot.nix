# GitHub Copilot configuration integrated with nvim-cmp
#
# Design decisions:
# - Copilot's built-in UI (ghost text and panel) is disabled; suggestions flow through nvim-cmp
# - Copilot starts DISABLED by default and must be explicitly enabled via :CopilotToggle or :Copilot enable
# - Key material files (.key, .pem, .p12, .enc, .gpg) are blocked from Copilot to prevent leaking secrets
# - Global state (vim.g.copilot_user_enabled) tracks whether user has enabled Copilot
# - Command interception ensures consistent state tracking across enable/disable/attach operations
# - Auth check waits for LSP client initialization before checking (prevents false "not authenticated" warnings)
{
  plugins.copilot-lua = {
    enable = true;

    settings = {
      # Disable built-in UI - we use nvim-cmp integration instead
      suggestion = {
        enabled = false;
      };
      panel = {
        enabled = false;
      };
      # Enable Copilot for markdown files (disabled by default in copilot-lua)
      filetypes = {
        markdown = true;
      };
      # Custom should_attach function to control which buffers Copilot attaches to
      # This runs for every buffer and determines if Copilot should be active there
      should_attach.__raw = ''
        function(bufnr, bufname)
          -- Don't attach during plugin initialization phase
          if vim.g.copilot_initializing then
            return false
          end

          -- Don't attach if user hasn't explicitly enabled Copilot
          -- This ensures Copilot stays off until :CopilotToggle or :Copilot enable
          if vim.g.copilot_user_enabled ~= true then
            return false
          end

          -- Block key material files to prevent accidentally sending secrets to Copilot
          local forbidden_suffixes = { ".key", ".pem", ".p12", ".enc", ".gpg" }
          if bufname and bufname ~= "" then
            local lower = string.lower(bufname)
            for _, suffix in ipairs(forbidden_suffixes) do
              if #lower >= #suffix and lower:sub(-#suffix) == suffix then
                return false
              end
            end
          end

          -- Don't attach to unlisted buffers (e.g., internal plugin buffers)
          if not vim.bo[bufnr].buflisted then
            return false
          end

          -- Don't attach to special buffer types (help, quickfix, terminal, etc.)
          if vim.bo[bufnr].buftype ~= "" then
            return false
          end

          return true
        end
      '';
    };
  };

  # Integration with nvim-cmp for completion
  plugins.copilot-cmp = {
    enable = true;
  };

  # Initialize global state variables BEFORE plugins load
  # This ensures the state is available when copilot.setup() runs
  extraConfigLuaPre = ''
    -- Global state for Copilot
    -- copilot_initializing: true during startup, prevents premature attachment
    -- copilot_user_enabled: tracks whether user has enabled Copilot this session
    vim.g.copilot_initializing = true
    vim.g.copilot_user_enabled = false
  '';

  # Main Copilot configuration: command interception, toggle, and auth checking
  extraConfigLua = ''
    -- ============================================================================
    -- Key Material Protection
    -- ============================================================================
    -- Files with these extensions are blocked from Copilot to prevent leaking secrets
    local forbidden_suffixes = { ".key", ".pem", ".p12", ".enc", ".gpg" }

    local function is_forbidden(bufname)
      if not bufname or bufname == "" then
        return false
      end
      local lower = string.lower(bufname)
      for _, suffix in ipairs(forbidden_suffixes) do
        if #lower >= #suffix and lower:sub(-#suffix) == suffix then
          return true
        end
      end
      return false
    end

    -- ============================================================================
    -- Command Interception
    -- ============================================================================
    -- Wrap copilot.command functions to:
    -- 1. Track state via vim.g.copilot_user_enabled
    -- 2. Block attach when Copilot is disabled
    -- 3. Block attach for key material files
    local ok_command, command = pcall(require, "copilot.command")
    if ok_command then
      local orig_enable = command.enable
      local orig_disable = command.disable
      local orig_attach = command.attach

      -- Wrap enable: set global state when user enables (not during init)
      command.enable = function(...)
        if not vim.g.copilot_initializing then
          vim.g.copilot_user_enabled = true
        end
        return orig_enable(...)
      end

      -- Wrap disable: always clear global state
      command.disable = function(...)
        vim.g.copilot_user_enabled = false
        return orig_disable(...)
      end

      -- Wrap attach: enforce state and block forbidden files
      command.attach = function(opts)
        if vim.g.copilot_user_enabled ~= true then
          vim.notify("Copilot is disabled. Run :Copilot enable first.", vim.log.levels.WARN)
          return
        end
        local bufnr = opts and opts.bufnr or vim.api.nvim_get_current_buf()
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if is_forbidden(bufname) then
          vim.notify("Copilot is blocked for key material.", vim.log.levels.WARN)
          return
        end
        return orig_attach(opts)
      end

      -- ============================================================================
      -- Toggle Command
      -- ============================================================================
      -- :CopilotToggle - toggle Copilot on/off for the session
      -- When enabling, also attaches to the current buffer immediately
      local function toggle_copilot()
        if vim.g.copilot_user_enabled == true then
          command.disable()
          vim.notify("Copilot disabled", vim.log.levels.INFO)
          return
        end

        command.enable()
        command.attach({ bufnr = vim.api.nvim_get_current_buf() })
        vim.notify("Copilot enabled", vim.log.levels.INFO)
      end

      vim.api.nvim_create_user_command("CopilotToggle", toggle_copilot, { desc = "Toggle Copilot" })

      -- ============================================================================
      -- Initialization Complete
      -- ============================================================================
      -- Mark initialization done and ensure Copilot starts disabled
      vim.g.copilot_initializing = false
      command.disable()
    end

    -- ============================================================================
    -- Authentication Check
    -- ============================================================================
    -- Check if user is authenticated with GitHub Copilot
    -- This uses a robust pattern that:
    -- 1. Waits for the Copilot LSP client to be initialized
    -- 2. Uses the async callback version of is_authenticated()
    -- 3. Retries multiple times if the client isn't ready yet
    -- 4. Only shows warning once per session
    --
    -- This prevents false "not authenticated" warnings that occur when checking
    -- before the LSP client is ready (is_authenticated() returns false immediately
    -- if the client isn't initialized)
    local ok_auth, copilot_auth = pcall(require, "copilot.auth")
    local ok_client, copilot_client = pcall(require, "copilot.client")

    if ok_auth and ok_client then
      local auth_warning_emitted = false

      local function warn_if_unauthenticated()
        -- Use callback version for proper async handling
        copilot_auth.is_authenticated(function(err)
          if auth_warning_emitted then
            return
          end

          if err then
            auth_warning_emitted = true
            vim.notify("Copilot auth check failed: " .. tostring(err), vim.log.levels.WARN)
            return
          end

          if not copilot_auth.is_authenticated() then
            auth_warning_emitted = true
            vim.notify("Copilot is not authenticated. Run :Copilot auth to sign in.", vim.log.levels.WARN)
          end
        end)
      end

      -- Wait for client initialization before checking auth
      -- Retries up to 5 times with 1500ms delays
      local function ensure_client_then_check(retries)
        if auth_warning_emitted then
          return
        end

        local client = copilot_client.get()
        if not (client and client.initialized) then
          if retries > 0 then
            vim.defer_fn(function()
              ensure_client_then_check(retries - 1)
            end, 1500)
          end
          return
        end

        warn_if_unauthenticated()
      end

      -- Start checking (will retry if client not ready)
      ensure_client_then_check(5)

      -- Also check when Copilot LSP attaches to a buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("CopilotAuthCheck", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "copilot" then
            ensure_client_then_check(3)
          end
        end,
      })
    end
  '';
}
