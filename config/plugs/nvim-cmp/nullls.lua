local status, nullls = pcall(require, "null-ls")
if (not status) then return end
local  helpers
nullls.setup({
  debounce = 550,
  save_after_format = false,
  sources = {
--     -- formatting
--     nullls.builtins.formatting.prettierd,
--     nullls.builtins.formatting.shfmt,
    nullls.builtins.formatting.fixjson,
    nullls.builtins.formatting.csharpier,
    nullls.builtins.formatting.markdownlint,

--     -- diagnostics
--     nullls.builtins.diagnostics.tsc,
--     -- nullls.builtins.eslint_d,
--     -- Code Actions
--     -- nullls.builtins.code_actions.gitsign,
--     -- nullls.builtins.gitrebase,
    nullls.builtins.code_actions.proselint,
--    require("typescript.extensions.null-ls.code-actions"),
    -- hoveron
    nullls.builtins.hover.dictionary,
    nullls.builtins.hover.printenv,
  },
  root_dir = require'null-ls.utils'.root_pattern ".git",
})


