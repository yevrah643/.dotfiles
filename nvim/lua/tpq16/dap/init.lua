local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end
local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end
-- local dap_virtualText_status_ok, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
-- if not dap_virtualText_status_ok then
--   return
-- end

--local icons = require "user.icons"

local M = {}

local function configure()
  local dap_breakpoint = {
    error = {
      text =  "⭐️",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    rejected = {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "⭐️",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
  }

  vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
  vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
  vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
end

local function configure_exts()
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

-- local function configure_debuggers()
--   --require("config.dap.lua").setup()
--   --require("config.dap.python").setup()
--   --require("config.dap.rust").setup()
--   --require("config.dap.go").setup()
-- end
--
-- function M.setup()
--   --require("config.dap.keymaps").setup() -- Keymaps
-- end

  configure() -- Configuration
  require("nvim-dap-virtual-text").setup()
  require('telescope').load_extension('dap')
  require("dapui").setup() -- use default
  configure_exts();
  require("user.dap.cpp").setup()

return M
