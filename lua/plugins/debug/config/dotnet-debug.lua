-- DAP configuration for .NET / C# debugging
-- Requires: netcoredbg (install via Mason or manually)
-- Mason: :MasonInstall netcoredbg
-- Manual: https://github.com/Samsung/netcoredbg

local H = {}

H.adapters = {
  coreclr = {
    type = 'executable',
    command = vim.fn.exepath('netcoredbg') ~= '' and vim.fn.exepath('netcoredbg')
      or (vim.fn.stdpath('data') .. '/mason/bin/netcoredbg'),
    args = { '--interpreter=vscode' },
  },
}

H.configurations = {
  cs = {
    -- Launch: build and run the project
    {
      name = 'Launch (.NET)',
      type = 'coreclr',
      request = 'launch',
      program = function()
        -- Try to find the DLL automatically
        local cwd = vim.fn.getcwd()
        local glob = vim.fn.glob(cwd .. '/bin/Debug/**/**.dll', false, true)
        if #glob > 0 then
          return vim.fn.input('Path to dll: ', glob[1], 'file')
        end
        return vim.fn.input('Path to dll: ', cwd .. '/bin/Debug/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
    },
    -- Attach to running process
    {
      name = 'Attach (.NET)',
      type = 'coreclr',
      request = 'attach',
      processId = require('dap.utils').pick_process,
    },
    -- Launch with build step
    {
      name = 'Build & Launch (.NET)',
      type = 'coreclr',
      request = 'launch',
      preLaunchTask = 'dotnet build',
      program = function()
        local cwd = vim.fn.getcwd()
        local glob = vim.fn.glob(cwd .. '/bin/Debug/**/**.dll', false, true)
        if #glob > 0 then
          return vim.fn.input('Path to dll: ', glob[1], 'file')
        end
        return vim.fn.input('Path to dll: ', cwd .. '/bin/Debug/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
    },
  },
}

return H
