local status, dap = pcall(require, "dap")
if (not status) then return end

local dap_breakpoint = {
    breakpoint = {
      text = " ",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    condbreak = {
      text = "",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    logpoint = {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    rejected = {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
  }

vim.fn.sign_define("DapBreakpoint", dap_breakpoint.breakpoint)
vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condbreak)
vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

-- c# Helpers from https://github.com/mfussenegger/nvim-dap/wiki/Cookbook
vim.g.dotnet_build_project = function()
  local default_path = vim.fn.getcwd() .. '/'
  if vim.g['dotnet_last_proj_path'] ~= nil then
    default_path = vim.g['dotnet_last_proj_path']
  end
  local path = vim.fn.input('Path to your *proj file', default_path, 'file')
  vim.g['dotnet_last_proj_path'] = path
  local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
  print('')
  print('Cmd to execute: ' .. cmd)
  local f = os.execute(cmd)
  if f == 0 then
    print('\nBuild: ✔️ ')
  else
    print('\nBuild: ❌ (code: ' .. f .. ')')
  end
end
vim.g.dotnet_get_dll_path = function()
    local request = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end

    if vim.g['dotnet_last_dll_path'] == nil then
        vim.g['dotnet_last_dll_path'] = request()
    else
        if vim.fn.confirm('Do you want to change the path to dll? \n' .. vim.g['dotnet_last_dll_path'], '&yes\n&no', 2) == 1 then
            vim.g['dotnet_last_dll_path'] = request()
        end
    end

    return vim.g['dotnet_last_dll_path']
end

-- -- Keymaps
local whichkey = require "which-key"

local keymap = {
  d = {
    name = "DAP",
    R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
    E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
    C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
    U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
    S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
    q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
  },
}

local keymap_v = {
    d = {
      name = "Debug",
      e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
    },
  }

whichkey.register(keymap, {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
})

whichkey.register(keymap_v, {
  mode = "v",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
})

-- vim.keymap.set('n', '<leader>dct', '<cmd>lua require"dap".continue()<CR>')
-- vim.keymap.set('n', '<leader>dsv', '<cmd>lua require"dap".step_over()<CR>')
-- vim.keymap.set('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>')
-- vim.keymap.set('n', '<leader>dso', '<cmd>lua require"dap".step_out()<CR>')
-- vim.keymap.set('n', '<leader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>')

-- vim.keymap.set('n', '<leader>dsc', '<cmd>lua require"dap.ui.variables".scopes()<CR>')
-- vim.keymap.set('n', '<leader>dhh', '<cmd>lua require"dap.ui.variables".hover()<CR>')
-- vim.keymap.set('v', '<leader>dhv', '<cmd>lua require"dap.ui.variables".visual_hover()<CR>')

-- vim.keymap.set('n', '<leader>duh', '<cmd>lua require"dap.ui.widgets".hover()<CR>')
-- vim.keymap.set('n', '<leader>duf', "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")

-- vim.keymap.set('n', '<leader>dsbr', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
-- vim.keymap.set('n', '<leader>dsbm', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
-- vim.keymap.set('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>')
-- vim.keymap.set('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>')
-- NodeJs (JS TS )
-- dap.adapters.node2 = {
--   type = 'executable',
--   command = 'node',
--   args = {HOME .. '/.xdg_home/nvim/extensions/vscode-node-debug2/out/src/nodeDebug.js'},
-- }

-- dap.configurations.javascript = {
-- {
--     name = 'Launch',
--     type = 'node2',
--     request = 'launch',
--     program = '${file}',
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = 'inspector',
--     console = 'integratedTerminal',
--   },
--   {
--     -- For this to work you need to make sure the node process is started with the `--inspect` flag.
--     name = 'Attach to process',
--     type = 'node2',
--     request = 'attach',
--     processId = require'dap.utils'.pick_process,
--   },
-- }


-- local HOME = os.getenv "HOME"
-- C# setup
-- local CSHARP_DEBUGGER = HOME .. "/.dotnet/tools/netcoredbg"

dap.adapters.coreclr = {
  type = "executable",
  command = 'netcoredbg',
  args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
  { 
    type = "coreclr",
    name = "Debug C# - netcoredbg",
    request = "launch",
    program = function()
      -- return vim.fn.input ('Path to DLL > ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
      return vim.fn.input('Path to DLL [../bin/Debug/X.dll]> ', vim.fn.getcwd() .. '/src/Application/Vp.Pim', 'file')
      -- local choice = vim.fn.inputlist( [ 
      -- \ 'Select Hexagon App', 
      -- \ '1. Article.Api',
      -- \ '2. Article.Microservice',
      -- \ '3. ArticleWrite.Api',
      -- \ '4. CampaignIndexation.Microservice',
      -- \ '5. Hexagon.Gateway.Api',
      -- \ '6. Hexagon.Microservice',
      -- \ '7. LegacyMapping.Api',
      -- \ '8. LegacyMapping.Microservice',
      -- \ '9. Lookalike.Api',
      -- \ 'a. Taxonomy.Apiv
      -- \ 'b. Taxonomy.Microservice',
      -- \ 'c. TunnelIndexation.Microservice'])

      -- local choiceMap = { 1 = 'Vp.Pim.Article.Api', 2 = 'Vp.Pim.Article.Microservice', 3 = 'Vp.Pim.Article.Write.Api' }
      -- return vim.fn.getcwd() .. '/src/Application/' .. choiceMap[choice] .. '/bin/Debug/' .. choiceMap[choice] .. '.dll' 
    end,
  }, 
  { 
    type = "coreclr",
    name = "Debug C# - Article.Write.Api",
    request = "launch",
    program = "${workspaceFolder}/src/Application/Vp.Pim.Article.Write.Api/bin/Debug/net6.0/Vp.Pim.Article.Write.Api.dll",
    cwd = "${workspaceFolder}/src/Application/Vp.Pim.Article.Write.Api/bin/Debug/net6.0/"
  }, 
  { 
    type = "coreclr",
    name = "Debug C# - CampaignIndexation.Microservice",
    request = "launch",
    program = "${workspaceFolder}/src/Application/Vp.Pim.CampaignIndexation.Microservice/bin/Debug/net6.0/Vp.Pim.CampaignIndexation.Microservice.dll",
    cwd = "${workspaceFolder}/src/Application/Vp.Pim.CampaignIndexation.Microservice/bin/Debug/net6.0/"
  }, 
  { 
    type = "coreclr",
    name = "Debug C# - Taxonomy.Api",
    request = "launch",
    program = "${workspaceFolder}/src/Application/Vp.Pim.Taxonomy.Api/bin/Debug/net6.0/Vp.Pim.Taxonomy.Api.dll",
    -- cwd = "${workspaceFolder}/src/Application/Vp.Pim.Taxonomy.Api/bin/Debug/net6.0/"
    args = { '--interpreter=vscode' },
  }, 
  { 
    type = "coreclr",
    name = "Attach to C#",
    request = "attach",
    pid = require('dap.utils').pick_process,
    -- processId = function()
    --   return vim.fn.input('Process PID > ')
    -- end,
    cwd = "${workspaceFolder}",
  }, 
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) == 1 then
            vim.g.dotnet_build_project()
        end
        return vim.g.dotnet_get_dll_path()
    end,
  },
}
