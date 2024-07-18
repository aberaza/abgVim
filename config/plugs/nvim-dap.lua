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
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '**/bin/Debug/**/*.dll', 'file')
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

local function get_dll()
	return coroutine.create(function(dap_run_co)
		-- local items = vim.fn.globpath(vim.fn.getcwd(), '**/bin/Debug/net8.0/Vp.Pim.*{Api,Microservice}.dll', 0, 1)
		local items = vim.fn.globpath(vim.fn.getcwd(), 'src/Applicaitons/*/', 1, 1)
		local opts = {
			format_item = function(path)
				return vim.fn.fnamemodify(path, ':t')
			end,
		}
		local function cont(choice)
			if choice == nil then
				return nil
			else
				-- coroutine.resume(dap_run_co, choice)
				coroutine.resume(dap_run_co, vim.fn.getcwd() .. '/src/Applicaitons/' .. choice .. '/**/bin/Debug/net8.0/' .. choice .. '.dll')
			end
		end

		vim.ui.select(items, opts, cont)
	end)
end

-- -- Keymaps
vim.keymap.set({'n','v'}, '<leader>dR', dap.run_to_cursor, { desc = 'Run to Cursor'} )
vim.keymap.set({'n','v'}, '<leader>dR', dap.run_to_cursor, { desc = 'Run to Cursor' })
vim.keymap.set({'n','v'}, '<leader>db', dap.step_back, { desc = 'Step Back' })
vim.keymap.set({'n','v'}, '<leader>dc', dap.continue, { desc = 'Continue' })
vim.keymap.set({'n','v'}, '<leader>dd', dap.disconnect, { desc = 'Disconnect' })
vim.keymap.set({'n','v'}, '<leader>dg', dap.session, { desc = 'Get Session' })
vim.keymap.set({'n','v'}, '<leader>di', dap.step_into, { desc = 'Step Into' })
-- vim.keymap.set({'n','v'}, '<leader>dp', dap.pause.toggle, { desc = 'Pause' })
vim.keymap.set({'n','v'}, '<leader>do', dap.step_over, { desc = 'Step Over' })
vim.keymap.set({'n','v'}, '<leader>dq', dap.close, { desc = 'Quit' })
vim.keymap.set({'n','v'}, '<leader>ds', dap.continue, { desc = 'Start' })
vim.keymap.set({'n','v'}, '<leader>dx', dap.terminate, { desc = 'Terminate' })

vim.keymap.set({'n','v'}, '<leader>dC', function() dap.set_breakpoint(vim.fn.input '[Condition] > ') end, { desc = 'Conditional Breakpoint' })

  -- local whichkey = require "which-key"
vim.keymap.set({'n','v'}, '<leader>dr', dap.repl.toggle, { desc = 'Toggle Repl' })
vim.keymap.set({'n','v'}, '<leader>dt', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
vim.keymap.set({'n','v'}, '<leader>du', dap.step_out, { desc = 'Step Out' })
local status, dapui = pcall(require, "dapui")
if (status) then
  vim.keymap.set({'n','v'}, '<leader>de', dapui.eval, { desc = 'Evaluate' })
  vim.keymap.set('v', '<leader>dE', dapui.eval, { desc = 'Evaluate' })
  vim.keymap.set({'n','v'}, '<leader>dU', dapui.toggle, { desc = 'Toggle UI' })
  vim.keymap.set({'n','v'}, '<leader>dE', function() dapui.eval(vim.fn.input '[Expression] > ') end, { desc = 'Evaluate Input' })
-- vim.keymap.set({'n','v'}, '<leader>dh', dapui.widgets.hover, { desc = 'Hover Variables' })
-- vim.keymap.set({'n','v'}, '<leader>dS', dapui.widgets.scopes, { desc = 'Scopes' })
end


-- local HOME = os.getenv "HOME"
-- C# setup

-- helpers (from netcoredbg-macos-arm64)
local function getCurrentFileDirName()
  local fullPath = vim.fn.expand('%:p:h')      -- Get the full path of the directory containing the current file
  local dirName = fullPath:match("([^/\\]+)$") -- Extract the directory name
  return dirName
end

local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

local function get_dll_path()
  local debugPath = vim.fn.expand('%:p:h') .. '/bin/Debug'
  if not file_exists(debugPath) then
    return vim.fn.getcwd()
  end
  local command = 'find "' .. debugPath .. '" -maxdepth 1 -type d -name "*net*" -print -quit'
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()
  result = result:gsub("[\r\n]+$", "") -- Remove trailing newline and carriage return
  if result == "" then
    return debugPath
  else
    local potentialDllPath = result .. '/' .. getCurrentFileDirName() .. '.dll'
    if file_exists(potentialDllPath) then
      return potentialDllPath
    else
      return result == "" and debugPath or result .. '/'
    end
    --        return result .. '/' -- Adds a trailing slash if a net folder is found
  end
end
-- local CSHARP_DEBUGGER = HOME .. "/.dotnet/tools/netcoredbg"
dap.adapters.coreclr = {
  type = "executable",
  command = 'netcoredbg',
  args = { "--interpreter=vscode" },
}

vim.g.dotnet_get_app = function()
  local hexagon_apps = vim.fn.globpath(vim.fn.getcwd() .. '/**/Vp.Pim*{Api,Microservice}', true, true)
  local chosen_app = vim.fn.inputlist( hexagon_apps)
  print(chosen_app)
  -- if #chosen_app > 0 then
  --   local folder_name = vim.fn.fnamemodify(chosen_app[1], ':t')
  --   -- return vim.fn.getcwd() .. '/src/Applications/' .. folder_name .. '/**/bin/Debug/net8.0/' .. folder_name .. '.dll'
  --   vim.g.dotnet_current_app = folder_name
  --   return folder_name
  -- else
  --   return ''
  -- end
end
vim.g.dotnet_current_app=''

dap.configurations.cs = {
  { 
    type = "coreclr",
    name = "Debug C# - netcoredbg",
    request = "launch",
    program = function()
      vim.g.dotnet_get_app()
    end,
    cwd = "${workspaceFolder}/src/Application/Vp.Pim.Article.Write.Api/bin/Debug/net6.0/"
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
    name = ".Net::Attach",
    request = "attach",
    processId = require('dap.utils').pick_process,
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
  {
		type = 'coreclr',
		name = 'NetCoreDbg: Launch',
		request = 'launch',
		cwd = '${fileDirname}',
		program = get_dll,
	},
  -- from netcoredbg-macos-arm64
  {
    type = "coreclr",
    name = "NetCoreDBG: Launch",
    request = "launch",
    cwd = "${fileDirname}",
    program = function ()
      return vim.fn.input('Path to dll', get_dll_path(), 'file')
    end,
    env = {
      ASPNETCORE_ENVIRONMENT = function()
        return vim.fn.input("ASPNETCORE_ENVIRONMENT: ", "Development")
      end,
      ASPNETCORE_URL = function()
        return vim.fn.input("ASPNETCORE_URL: ", "http://localhost:5000")
      end,
    }
  },
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Configurations                                           │
-- ╰──────────────────────────────────────────────────────────╯
-- from ECOVIM 
dap.configurations.javascript = {
  {
    name = "Node.js",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
}

dap.configurations.javascript = {
  {
    name = "Chrome (9222)",
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}",
  },
}

dap.configurations.javascriptreact = {
  {
    name = "Chrome (9222)",
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}",
  },
}

dap.configurations.typescriptreact = {
  {
    name = "Chrome (9222)",
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}",
  },
  {
    name = "React Native (8081) (Node2)",
    type = "node2",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
    port = 8081,
  },
  {
    name = "Attach React Native (8081)",
    type = "pwa-node",
    request = "attach",
    processId = require('dap.utils').pick_process,
    cwd = vim.fn.getcwd(),
    rootPath = '${workspaceFolder}',
    skipFiles = { "<node_internals>/**", "node_modules/**" },
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
}

