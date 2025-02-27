local H = {}

H.adapters = {
  node = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "node",
      args = { os.getenv('HOME') .. '/bin/js-debug/src/dapDebugServer.js', "${port}" }
    },
  },
  pwa_node = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "node",
      args = { os.getenv('HOME') .. '/bin/js-debug/src/dapDebugServer.js', "${port}" }
    },
  },
  firefox = {
    type = "executable",
    command = "node",
    args = {os.getenv("HOME") .. "/bin/vscode-firefox-debug/dist/adapter.bundle.js"}
  }
}

H.configurations = {}

for _, v in ipairs({"javascript", "typescript", "javascriptreact", "typescriptreact"}) do
   H.configurations[v] = {
    {
      name = "Launch Firefox",
      type = "firefox",
      request = "launch",
      reAttach = true,
      url = "http://localhost:4001",
      webRoot = "${workspaceFolder}",
      firefoxExecutable = "/Applications/Firefox.app/Contents/MacOS/firefox",
    },{
      name = "Attach Firefox",
      type = "firefox",
      request = "attach"
    }
   }
end

return H
