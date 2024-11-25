local status, lsnip = pcall(require, 'luasnip')
if not status then return end

require("luasnip.loaders.from_vscode").lazy_load() -- load VSCode snippets,accepts { paths={'./path1', './path/2'}} parameter
require("luasnip.loaders.from_snipmate").lazy_load() -- also accepts path parameter
require("luasnip.loaders.from_lua").lazy_load() -- also accepts path parameter

local types = require "luasnip.util.types"

lsnip.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "●", "GruvboxOrange" } },
      },
    },
    [types.insertNode] = {
      active = {
        virt_text = { { "●", "GruvboxBlue" } },
      },
    },
  },
}
