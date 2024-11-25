local status, ts = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

ts.setup {
  ensure_installed = { "bash", "lua", "javascript", "typescript", "tsx", "json", "json5","markdown", "vim", "yaml", "c_sharp" },
  sync_install = false,
  -- requires tree-sitter-cli
  auto_install = true,
  incremental_selection = { enable = true },
  highlight = {
    enable = true,
    -- disable = { "c", "rust" },
    -- Next line prevents default syntax from working as it will colide with plugin
    additional_vim_regex_highlighting = false,
  },
  textobjects = { enable = false },
  indent = {
    enable = true
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}



vim.opt.foldmethod='expr'
