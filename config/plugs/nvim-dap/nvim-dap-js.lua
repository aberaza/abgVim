local dap = require('dap')

dap.adapters.firefox = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/bin/vscode-firefox-debug/dist/adapter.bundle.js'},
}

local status, dap_js = pcall(require, "dap-vscode-js")
if (not status) then return end
dap_js.setup({
  debugger_path = '/Users/aritz.beraza/bin/vscode-js-debug',
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }
})

for _,language in ipairs({'javascript', 'typescript'}) do
  -- dap.adapters[language] = dap_js.adapters[language]
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Launch Chrome",
      url = "http://localhost:4001",
      sourceMaps=true,
      webRoot="${workspaceFolder}",
      protocol = "inspector",
      port = 9222,
      skipFiles = {"<node_internals>/**", "**/node_modules/**/*"},
    },
    {  
      name = 'Launch Firefox',
      type = 'firefox',
      request = 'launch',
      reAttach = true,
      url = 'http://localhost:4001',
      webRoot = '${workspaceFolder}',
      firefoxExecutable = '/Applications/Firefox.app/Contents/MacOS/firefox',
    },
  }
end

