-- DAP configuration for Go debugging
-- Requires: delve (install via Mason or `go install github.com/go-delve/delve/cmd/dlv@latest`)
-- Mason: :MasonInstall delve

local H = {}

H.adapters = {
  delve = {
    type = 'server',
    port = '${port}',
    executable = {
      command = vim.fn.exepath('dlv') ~= '' and vim.fn.exepath('dlv')
        or (vim.fn.stdpath('data') .. '/mason/bin/dlv'),
      args = { 'dap', '-l', '127.0.0.1:${port}' },
      detached = vim.fn.has('win32') == 0,
    },
  },
}

H.configurations = {
  go = {
    -- Launch: debug current file
    {
      name = 'Launch file (Go)',
      type = 'delve',
      request = 'launch',
      program = '${file}',
    },
    -- Launch: debug current package
    {
      name = 'Launch package (Go)',
      type = 'delve',
      request = 'launch',
      program = './${relativeFileDirname}',
    },
    -- Debug test function under cursor
    {
      name = 'Debug test (Go)',
      type = 'delve',
      request = 'launch',
      mode = 'test',
      program = './${relativeFileDirname}',
    },
    -- Debug entire test suite
    {
      name = 'Debug test suite (Go)',
      type = 'delve',
      request = 'launch',
      mode = 'test',
      program = './...',
    },
    -- Attach to running process
    {
      name = 'Attach to process (Go)',
      type = 'delve',
      request = 'attach',
      mode = 'local',
      processId = require('dap.utils').pick_process,
    },
  },
}

return H
