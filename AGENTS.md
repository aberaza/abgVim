# AGENTS.md — abgVim Neovim Configuration

## Intent
Full-featured personal Neovim IDE (Lua config only) for C#/.NET, JS/TS/Node, Bash/Shell, PostgreSQL, Markdown and REST development. Minimalist aesthetics: icons/dots/lines over text labels, floating UI, toggleable info panels. Retains vim feel (modal editing, fast navigation) while providing IDE-grade tooling: LSP + completions, AI assistance, DAP debugging, neotest, DB client, live preview.

## Repository
- Root: `~/abgVim` (symlinked from `~/.config/nvim`)
- Entrypoint: `init.lua` — loads `core.env`, sets leaders, then `config.*` and `config.lazy`
- Lua tree: `lua/config/`, `lua/core/`, `lua/plugins/` (with subdirs per domain)
- Legacy vimscript files (`vimrc`, `abg.vim`, `config/`, `bundle/`) — **not the focus; do not modify**
- Lock file: `lazy-lock.json` (all pinned commits)
- Secrets: `.env` loaded via `core.env` → `vim.env.*`

## Lua Config Layout
```
init.lua                         ← entrypoint
lua/
  core/
    env.lua                      ← .env loader
    context_keys.lua             ← floating keymap inspector
  config/
    options.lua                  ← vim.opt / vim.o settings
    keymaps.lua                  ← global keymaps (leader = Space, localleader = ,)
    lsp.lua                      ← LspAttach autocmd, diagnostic signs/config
    utils.lua                    ← shared helpers: diagnostic_icons, dap icons, setup_keymaps()
    lazy.lua                     ← lazy.nvim bootstrap + spec imports
    git_branch_watch.lua         ← branch-change watcher (unused/experimental)
  plugins/
    init.lua                     ← plenary (shared dep)
    themes.lua                   ← sonokai (active), tokyonight (lazy)
    treesitter.lua               ← treesitter + textobjects
    fzf.lua                      ← fzf-lua (primary fuzzy finder)
    aerial.lua                   ← code outline sidebar (lazy, cmd only)
    git.lua                      ← fugitive + merginal + gitsigns
    markdown.lua                 ← render-markdown.nvim + live-preview.nvim
    trouble.lua                  ← trouble.nvim (diagnostics)
    dadbod.lua                   ← vim-dadbod + UI (PostgreSQL/SQL client)
    neotest.lua                  ← neotest + adapters: jest, vitest, dotnet, golang, deno
    nvim-tree.lua                ← nvim-tree (DISABLED, replaced by mini.files)
    lsp/
      mason.lua                  ← mason + mason-lspconfig; servers: ts_ls, vtsls, eslint,
                                    html, cssls, jsonls, yamlls, csharp_ls, gopls, lua_ls, vimls
    autocomplete/
      blink.lua                  ← blink.cmp (super-tab); sources: copilot, lsp, snippets, buffer, dadbod
    ai/
      copilot.lua                ← copilot.lua inline + codecompanion.nvim (chat/inline/agents)
      mcphub.lua                 ← mcphub.nvim (DISABLED standalone; active inside copilot.lua)
      codecompanion_extras/      ← custom slash-commands: jira, mermaid, pr, extras helpers
    debug/
      dap.lua                    ← nvim-dap + dap-ui + virtual-text + mason-nvim-dap
      config/
        js-debug.lua             ← pwa-node/pwa-chrome/firefox adapters
        dotnet-debug.lua         ← coreclr/netcoredbg adapter
        go-debug.lua             ← delve adapter
    mini/
      mini.lua                   ← mini.comment, cursorword, surround, pairs, move, bufremove,
                                    statusline, indentscope, pick (secondary picker)
      clue.lua                   ← mini.clue (which-key equivalent)
      diff.lua                   ← mini.diff (sign-style git diff + overlay; used by codecompanion)
      files.lua                  ← mini.files (primary file explorer; dotfiles + git filter toggles)
      hipatterns.lua             ← mini.hipatterns (FIXME/TODO/hex_color highlights)
      icons.lua                  ← mini.icons (icon overrides)
      statusline.lua             ← placeholder (mini.statusline config is in mini.lua opts)
      indentscope.lua            ← placeholder (indentscope config is in mini.lua)
```

## Key Plugin Stack
| Category | Plugin(s) |
|---|---|
| Plugin manager | lazy.nvim |
| LSP | nvim-lspconfig + mason + mason-lspconfig |
| Completion | blink.cmp (super-tab preset) |
| Snippets | friendly-snippets |
| Syntax | nvim-treesitter + textobjects |
| Fuzzy find | fzf-lua (primary), mini.pick (secondary / ui.select) |
| File explorer | mini.files |
| Git | gitsigns, mini.diff, vim-fugitive, vim-merginal |
| Debugging | nvim-dap + dap-ui + dap-virtual-text + mason-nvim-dap |
| Testing | neotest + jest/vitest/dotnet/golang/deno adapters |
| AI | copilot.lua + codecompanion.nvim + mcphub.nvim (MCP) |
| DB | vim-dadbod + dadbod-ui + dadbod-completion |
| Markdown | render-markdown.nvim + live-preview.nvim |
| Diagnostics | trouble.nvim |
| Outline | aerial.nvim |
| UI lib | mini.* (clue, diff, files, hipatterns, icons, indentscope, statusline, etc.) |
| Theme | sonokai (active), tokyonight (lazy alt) |

## Language / Tooling Coverage
| Lang | LSP | Debug | Test | Lint/Format |
|---|---|---|---|---|
| TypeScript / JS | ts_ls + vtsls + eslint | pwa-node/chrome | jest + vitest | eslint (auto-fix on save) |
| C# / .NET | csharp_ls | netcoredbg (coreclr) | neotest-dotnet | — |
| Go | gopls | delve | neotest-golang | gofumpt |
| Bash/Shell | — | — | — | — |
| Lua | lua_ls | — | — | — |
| SQL/PostgreSQL | — (dadbod) | — | — | — |
| HTML/CSS/JSON/YAML | html, cssls, jsonls, yamlls | — | — | — |
| Markdown | — | — | — | render-markdown, live-preview |

## Keymaps Summary (leaders: Space / ,)
- `<leader>c*` — code actions, format, rename, AI
- `<leader>d*` — DAP debug
- `<leader>f*` — file/buffer search (fzf-lua)
- `<leader>g*` — git
- `<leader>l*` — LSP management
- `<leader>s*` — search/diagnostics
- `<leader>t*` — neotest
- `<leader>u*` — UI toggles (inlay hints, semantic tokens)
- `<leader>e/E/-/<C-b>` — mini.files explorer
- `<leader>cc / <C-g>` — CodeCompanion chat
- `g*/K` — LSP navigation/hover
- `[d/]d/[e/]e` — diagnostic navigation
- See `KEYMAPS.md` for full table

## Gaps / Known Issues (pre-improvement)
- No `bashls` / `shellcheck` LSP for shell scripting
- No REST client (http file runner or curl-style)
- No JSON tooling (jq integration, jsonpath)
- No code-lens (e.g. `nvim-lenses` or LSP codelens display)
- `virtual_text` in `utils.lua` is fully commented out — diagnostics show only signs
- `statusline.lua` and `indentscope.lua` are empty placeholders
- `nvim-tree.lua` is disabled but not removed
- `git_branch_watch.lua` exists but is never required
- `neotest` bash/shell adapter missing
- No build task runner (`:make` / overseer.nvim / toggleterm)
- No terminal integration beyond DAP REPL
- No `noice.nvim` or styled cmdline/notifications (uses default)
- Trouble.nvim has only one keymap wired (`<leader>xx`)
- `<leader>dd` conflicts: both DAP disconnect and LSP line diagnostics
- Copilot model set to `gpt-5-mini` (non-existent model name — likely a typo for `gpt-4o-mini`)
- `mini.pick` configured as `ui.select` but fzf-lua is primary; potential picker conflicts
- No `.editorconfig` or `conform.nvim` for formatter management beyond LSP format
- No window/session management (persistence.nvim or similar)
- Treesitter textobjects enabled in dependency but disabled in opts (`enable = false`)
- `vim.loop` deprecation warning (should use `vim.uv` in Neovim 0.10+)

## Code Style (Lua)
- 2-space indent, single quotes preferred
- `local opt = vim.opt` / `local o = vim.o` aliases in options
- `pcall()` for all external requires
- Plugin specs: `opts = {}` for simple, `config = function(_, opts)` for complex
- Lazy loading: `event`, `cmd`, `keys`, `ft` triggers — prefer over `lazy = false`
- Keymap helper: `utils.setup_keymaps(opts)` for LSP maps, `key_opts(desc)` closure pattern
- Icons/signs: centralized in `config/utils.lua` (`H.diagnostics`, `H.dap`)

## Commands
- Bootstrap: start nvim; lazy auto-installs missing plugins
- Plugin management: `:Lazy`, `:Lazy update`, `:Lazy sync`, `:Lazy clean`
- LSP server management: `:Mason`, `:MasonInstall <server>`, `:MasonUpdate`
- DAP: `:DapInstall`, `:DapUninstall`
- DB: `:DBUI`, `:DBUIToggle`, `:DBUIAddConnection`
- Outline: `:AerialToggle`
- Diagnostics: `:Trouble diagnostic toggle`
- Lint headless check: `nvim --headless -c "lua require('config.options')" -c "qa"`

## Maintenance Notes
- Update `lazy-lock.json` via `:Lazy update` then commit
- Add new language support: LSP server in `mason.lua` ensure_installed + server_settings, DAP adapter in debug/config/, neotest adapter in neotest.lua
- New plugin files go in `lua/plugins/<domain>.lua`; register import in `config/lazy.lua` spec if new subdir
- Keep `KEYMAPS.md` in sync when adding keymaps
- `.env` holds API keys (gitignored); never commit secrets
