local H = {}

local js_debug_path = os.getenv('HOME') .. '/bin/js-debug/src/dapDebugServer.js'

H.adapters = {
  ['pwa-node'] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
      command = 'node',
      args = { js_debug_path, '${port}' },
    },
  },
  ['pwa-chrome'] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
      command = 'node',
      args = { js_debug_path, '${port}' },
    },
  },
  node = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = {
      command = 'node',
      args = { js_debug_path, '${port}' },
    },
  },
  firefox = {
    type = 'executable',
    command = 'node',
    args = { os.getenv('HOME') .. '/bin/vscode-firefox-debug/dist/adapter.bundle.js' },
  },
}

H.configurations = {}

for _, lang in ipairs({ 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }) do
  H.configurations[lang] = {
    -- Node.js: launch current file
    {
      name = 'Launch file (Node)',
      type = 'pwa-node',
      request = 'launch',
      program = '${file}',
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      resolveSourceMapLocations = { '${workspaceFolder}/**', '!**/node_modules/**' },
    },
    -- Node.js: attach to running process
    {
      name = 'Attach to Node process',
      type = 'pwa-node',
      request = 'attach',
      processId = require('dap.utils').pick_process,
      cwd = '${workspaceFolder}',
      sourceMaps = true,
    },
    -- Node.js: launch via npm script (e.g. "npm run dev")
    {
      name = 'Launch via npm (debug)',
      type = 'pwa-node',
      request = 'launch',
      runtimeExecutable = 'npm',
      runtimeArgs = { 'run', 'debug' },
      cwd = '${workspaceFolder}',
      sourceMaps = true,
    },
    -- Chrome: launch
    {
      name = 'Launch Chrome',
      type = 'pwa-chrome',
      request = 'launch',
      url = 'http://localhost:3000',
      webRoot = '${workspaceFolder}',
      sourceMaps = true,
    },
    -- Chrome: attach (start Chrome with --remote-debugging-port=9222)
    {
      name = 'Attach Chrome',
      type = 'pwa-chrome',
      request = 'attach',
      port = 9222,
      webRoot = '${workspaceFolder}',
      sourceMaps = true,
    },
    -- Firefox: launch
    {
      name = 'Launch Firefox',
      type = 'firefox',
      request = 'launch',
      reAttach = true,
      url = 'http://localhost:3000',
      webRoot = '${workspaceFolder}',
      firefoxExecutable = '/Applications/Firefox.app/Contents/MacOS/firefox',
    },
    -- Firefox: attach
    {
      name = 'Attach Firefox',
      type = 'firefox',
      request = 'attach',
    },
  }
end

return H
