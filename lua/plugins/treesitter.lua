return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  build = ":TSUpdate",
  event = "BufReadPost",
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  keys = {
    { "<c-space>", mode = { "n", "x" }, desc = "Increment Selection" },
    { "<bs>", mode = "x", desc = "Decrement Selection" },
  },
  opts_extend = { "ensure_installed" },
  opts = {
    ensure_installed = {
      'bash', 'lua', 'javascript', 'typescript', 'tsx', 'json', 'json5', 'jsdoc',
      'markdown', 'markdown_inline', 'vim', 'vimdoc', 'c', 'query', 'yaml',
      'c_sharp', 'go', 'gomod', 'gowork', 'gosum',
      'css', 'html', 'sql', 'dockerfile', 'graphql', 'regex', 'toml',
    },
    auto_install = true,
    incremental_selection = { enable = true },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    textobjects = { enable = false },
    indent = {
      enable = true,
    },
  },
}
