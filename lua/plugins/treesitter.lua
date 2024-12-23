return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  build = ":TSUpdate",
  event = "BufReadPost",
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  keys = {
    { "<c-space>", desc = "Increment Selection" },
    { "<bs>", desc = "Decrement Selection", mode = "x" },
  },
  opts_extend = { "ensure_installed" },
  opts = {
    ensure_installed = { "bash", "lua", "javascript", "typescript", "tsx", "json", "json5","markdown", "vim", "yaml", "c_sharp" },
    
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
}
