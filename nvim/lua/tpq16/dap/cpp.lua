local dap_status_ok, dap = pcall(require, 'dap')
if not dap_status_ok then
	return
end

local M = {}

function M.setup()
  dap.configurations.cpp = {
    -- {
    --   name = "Debug",
    --   type = "cppdbg",
    --   request = "launch",
    --   targetArchitecture = "x86_64",
    --   program = "${fileDirname}/${fileBasenameNoExtension}",
    --   args = {},
    --   cwd = '${workspaceFolder}',
    --   stopOnEntry = true,
    --   externalConsole = false,
    --   MIMode = 'lldb',
    --   miDebuggerPath = '/Users/tuongquangphung/cpptools-osx/extension/debugAdapters/lldb/bin/lldb-mi',
    --   preLaunchTask = "C/C++: clang++ build active file",
    --   --customLaunchSetupCommands = { text = "target-run", description = "run target", ignoreFailures = false },
    --   --environment = { name = "config", value = "Debug" },
    --   --launchCompleteCommand = "exec-run",
    -- },

    {
      name = "Debug - test: ",
      type = "cppdbg",
      request = "launch",
      targetArchitecture = "x86_64",
      program = "${fileDirname}/${fileBasenameNoExtension}",
      MIMode = 'lldb',
      cwd = '${workspaceFolder}',
      stopOnEntry = true,
      launchCompleteCommand = "exec-run"
    },

    {
      name = 'Attach Cpp:',
      type = 'cppdbg',
      request = 'launch',
      MIMode = 'lldb',
      miDebuggerServerAddress = 'localhost:1234',
      miDebuggerPath = '/usr/bin/lldb',
      cwd = '${workspaceFolder}',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
    },
  }
  -- Cpp Dap
  dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = '/Users/tuongquangphung/cpptools-osx/extension/debugAdapters/bin/OpenDebugAD7',
  }
end

return M
