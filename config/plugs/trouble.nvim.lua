local status, trouble = pcall(require, 'trouble')
if not status then return end

trouble.setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    icons = true, -- use devicons for filenames
    group = true, -- group results by file
    -- auto_open = true, -- automatically open the list when you have diagnostics
    auto_close = true, -- automatically close the list when you have no diagnostics
    auto_preview = true,

    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed fold_closed
    
    use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
    auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
}

-- Lua
local keymap = vim.keymap
local function desc(description)
  local bufopts = { noremap=true, silent=true, desc=description}
  return bufopts
end
keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", desc('Trouble List Toggle')
)
keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc('Trouble Workspace Diagnostics')
)
keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc('Trouble Document Diagnostics')
)
keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc('Trouble LocationList Toggle')
)
keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc('Trouble Quicklist Toggle')
)
keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", desc('Trouble LSP References Toggle')
)
