# Keymap Documentation

## Table of Contents
- [Basic Operations](#basic-operations)
- [Motions & Navigation](#motions--navigation)
- [Text Objects & Selection](#text-objects--selection)
- [Editing & Operations](#editing--operations)
- [Search & Find](#search--find)
- [LSP & Code Intelligence](#lsp--code-intelligence)
- [Diagnostics](#diagnostics)
- [Code Actions & Refactoring](#code-actions--refactoring)
- [File Management](#file-management)
- [Git Integration](#git-integration)
- [Testing & Debugging](#testing--debugging)
- [Build & Tasks](#build--tasks)
- [AI & Copilot](#ai--copilot)
- [UI & Toggles](#ui--toggles)
- [Windows & Tabs](#windows--tabs)
- [Built-in Keymaps](#built-in-keymaps)

## Basic Operations

| Key | Mode | Description | Context |
|-----|------|-------------|------|
| `<C-s>` | n,i | Save file | Basic |
| `<leader>w` | n,v | Save file (alternative) | Basic |

## Motions & Navigation

| Key | Mode | Description | Context |
|-----|------|-------------|------|
| `gD` | n | Goto Declaration | LSP |
| `gd` | n | Goto Definition | LSP |
| `gy` | n | Goto Type Definition | LSP |
| `gi` | n | Goto Implementation | LSP |
| `gs` | n | Signature Help | LSP |
| `gO` | n | Document Symbols | LSP (fzf-lua) |
| `gW` | n | Workspace Symbols | LSP (fzf-lua) |
| `gl` | n | Line Diagnostics (float) | LSP |
| `[d` | n | Previous Diagnostic | LSP |
| `]d` | n | Next Diagnostic | LSP |
| `[e` | n | Previous Error | LSP |
| `]e` | n | Next Error | LSP |
| `g[` | n,v,o | Jump to left edge of text object | mini.ai |
| `g]` | n,v,o | Jump to right edge of text object | mini.ai |

## Text Objects & Selection

> All work with `a`/`i` prefix in operator-pending and visual mode.

| Key | Name | Powered by |
|-----|------|------------|
| `f` | function **call** | mini.ai builtin |
| `F` | function **definition** | mini.ai + treesitter |
| `C` | class / struct / interface | mini.ai + treesitter |
| `o` | conditional or loop block | mini.ai + treesitter |
| `a` | argument between commas | mini.ai builtin |
| `b` | any bracket `)` `]` `}` | mini.ai alias |
| `q` | any quote `"` `'` `` ` `` | mini.ai alias |
| `t` | HTML/JSX tag | mini.ai builtin |
| `L` | whole line (linewise) | mini.extra |
| `I` | indent block | mini.extra |
| `n` | number literal | mini.ai pattern |
| `W` | camelCase/PascalCase segment | mini.ai pattern |
| `?` | user-prompted pair | mini.ai builtin |
| `<c-space>` | n,x | Increment treesitter selection | nvim-treesitter |
| `<bs>` | x | Decrement treesitter selection | nvim-treesitter |

## Editing & Operations

| Key | Mode | Description | Context |
|-----|------|-------------|------|
| `K` | n | Hover Documentation | LSP |
| `<C-k>` | i | Signature Help | LSP / blink.cmp |

## Search & Find

| Key | Mode | Description | Plugin |
|-----|------|-------------|--------|
| `<C-p>` | n | Find Files | fzf-lua |
| `<C-S-P>` | n | Find Actions (keymaps + commands) | fzf-lua |
| `<C-f>` | n | Find in Files (grep) | fzf-lua |
| `<leader>s` | v | Find Word under Cursor | fzf-lua |
| `<leader>ff` | n | Find Files (full / hidden) | fzf-lua |
| `<leader>fb` | n | Find Buffers (MRU) | fzf-lua |
| `<leader>,` | n | Find Buffers (MRU, quick) | fzf-lua |
| `<leader>fC` | n | Find Commands | fzf-lua |
| `<leader>fc` | n | Find Colorscheme | fzf-lua |
| `<leader>fbs` | n,v | Search current buffer lines | mini.pick |
| `<leader>sd` | n | Document Diagnostics | fzf-lua |
| `<leader>sD` | n | Workspace Diagnostics | fzf-lua |

## LSP & Code Intelligence

| Key | Mode | Description | Context |
|-----|------|-------------|------|
| `<leader>li` | n | Incoming Calls | LSP |
| `<leader>lr` | n | Stop LSP clients | LSP |
| `<leader>ll` | n | LSP Log | LSP |

## Diagnostics

| Key | Mode | Description | Plugin |
|-----|------|-------------|--------|
| `<leader>dl` | n | Line Diagnostics (float) | LSP |
| `gl` | n | Line Diagnostics (float, alias) | LSP |
| `<leader>xx` | n | Diagnostics Toggle (Trouble) | trouble.nvim |
| `<leader>sd` | n | Find Document Diagnostics | fzf-lua |
| `<leader>sD` | n | Find Workspace Diagnostics | fzf-lua |

## Code Actions & Refactoring

| Key | Mode | Description | Context |
|-----|------|-------------|------|
| `<leader>ca` | n,v | Code Action | LSP |
| `<leader>cA` | n | Source Action | LSP |
| `<leader>cr` | n | Rename Symbol | LSP |
| `<leader>cf` | n,v | Format Buffer / Selection | conform.nvim |
| `<leader>cF` | n | Format Buffer (LSP direct, fallback) | LSP |
| `<leader>cx` | x | Format Selection (LSP direct) | LSP |
| `<leader>ci` | n | Import All Missing | LSP |
| `<leader>co` | n | Organize Imports | LSP |
| `<leader>cR` | n,v | Refactor Selected Code (AI) | codecompanion.nvim |
| `<leader>ce` | n,v | Explain Selected Code (AI) | codecompanion.nvim |
| `<leader>cg` | n,v | Generate Code Snippet (AI) | codecompanion.nvim |

## File Management

| Key | Mode | Description | Plugin |
|-----|------|-------------|--------|
| `<leader>e` | n | Explorer (toggle) | mini.files |
| `<leader>E` | n | Explorer (current file) | mini.files |
| `<C-b>` / `-` | n | Explorer (cwd) | mini.files |

### mini.files internal mappings
| Key | Description |
|-----|-------------|
| `g.` | Toggle dotfiles |
| `gf` | Toggle git tracked files only |
| `gi` | Toggle git tracked + untracked |
| `<CR>` | Open / enter directory |
| `=` | Synchronise (apply renames / moves) |
| `@` | Reveal cwd |
| `?` | Help |
| `q` | Close |

## Git Integration

| Key | Mode | Description | Plugin |
|-----|------|-------------|--------|
| `<leader>tb` | n | Toggle Line Blame | gitsigns.nvim |
| `<leader>tg` | n | Toggle GitSigns | gitsigns.nvim |
| `<leader>go` | n | Toggle Diff Overlay | mini.diff |

## Testing & Debugging

### Testing (neotest)
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>tf` | n | Test File |
| `<leader>tfd` | n | Test File with DAP |
| `<leader>tx` | n | Test Suite |
| `<leader>tl` | n | Test Last |
| `<leader>tld` | n | Test Last with DAP |
| `<leader>tn` | n | Test Nearest |
| `<leader>tnd` | n | Test Nearest with DAP |
| `<leader>tv` | n | Test Visit |
| `<leader>ta` | n | Test Attach |
| `<leader>ts` | n | Test Stop |
| `<leader>tS` | n | Toggle Test Summary |
| `<leader>to` | n | Test Output |

### Debugging (nvim-dap)
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>dc` | n | Continue / Start |
| `<leader>di` | n | Step Into |
| `<leader>do` | n | Step Over |
| `<leader>du` | n | Step Out |
| `<leader>db` | n | Step Back |
| `<leader>dR` | n,v | Run to Cursor |
| `<leader>dt` | n,v | Toggle Breakpoint |
| `<leader>dC` | n | Conditional Breakpoint |
| `<leader>dL` | n | Log Point |
| `<leader>dr` | n | Toggle REPL |
| `<leader>dg` | n | Get Session |
| `<leader>dd` | n | Disconnect |
| `<leader>dx` | n | Terminate |
| `<leader>dq` | n | Quit |
| `<leader>dU` | n | Toggle DAP UI |
| `<leader>de` | n,v | Eval Expression |

## Build & Tasks

### Overseer (task runner)
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>or` | n | Run Task (picker) |
| `<leader>ob` | n | Build Task (picker) |
| `<leader>ot` | n | Toggle Task List |
| `<leader>oi` | n | Overseer Info |
| `<leader>oq` | n | Close Task List |
| `<leader>ol` | n | Restart Last Task |

### Built-in task templates (auto-detected)
| Template | Trigger condition |
|----------|------------------|
| `npm: build` / `npm: dev` | `package.json` present |
| `dotnet: build` / `dotnet: run` | `*.sln` / `*.csproj` present |
| `go: build` / `go: run` | `go.mod` present |

## AI & Copilot

| Key | Mode | Description | Plugin |
|-----|------|-------------|--------|
| `<leader>cc` | n | Toggle CodeCompanion Chat | codecompanion.nvim |
| `<C-g>` | n | Toggle CodeCompanion Chat (alt) | codecompanion.nvim |
| `ga` | v | Add selection to Chat | codecompanion.nvim |
| `<C-g>` | v | Add selection to Chat (alt) | codecompanion.nvim |
| `<leader>ce` | n,v | Explain Selected Code | codecompanion.nvim |
| `<leader>cR` | n,v | Refactor Selected Code | codecompanion.nvim |
| `<leader>cg` | n,v | Generate Code Snippet | codecompanion.nvim |
| `<M-l>` | i | Accept Copilot suggestion | copilot.lua |
| `<M-j>` | i | Next Copilot suggestion | copilot.lua |
| `<M-k>` | i | Previous Copilot suggestion | copilot.lua |

## UI & Toggles

| Key | Mode | Description | Context |
|-----|------|-------------|------|
| `<leader>uh` | n | Toggle Inlay Hints | LSP |
| `<leader>uv` | n | Toggle Diagnostic Virtual Text (on/off) | LSP |
| `<leader>uV` | n | Cycle Diagnostic Virtual Text (full→minimal→off) | LSP |
| `<leader>us` | n | Toggle Semantic Tokens | LSP |
| `<leader>uf` | n | Toggle Auto-format on Save (buffer) | conform.nvim |
| `<leader>uF` | n | Toggle Auto-format on Save (global) | conform.nvim |
| `<leader>uS` | n | Toggle Satellite Scrollbar | satellite.nvim |
| `<leader>tb` | n | Toggle Line Blame | gitsigns.nvim |
| `<leader>tg` | n | Toggle GitSigns | gitsigns.nvim |

## Windows & Tabs

> Mini.tabline shows all open buffers as tabs. Use `mini.bufremove` to close.

| Key | Mode | Description | Context |
|-----|------|-------------|------|
| `<C-w>...` | n | Split / resize / navigate windows | Vim built-in (mini.clue hints) |

## Built-in Keymaps

### Completion (blink.cmp — super-tab preset)
| Key | Mode | Description |
|-----|------|-------------|
| `<Tab>` | i,s | Accept completion / Next item |
| `<S-Tab>` | i,s | Previous item |
| `<C-n>` | i | Select Next Completion |
| `<C-p>` | i | Select Previous Completion |
| `<C-Space>` | i | Open menu / Show docs |
| `<C-e>` | i | Hide menu |
| `<C-k>` | i | Toggle signature help |

### Copilot inline (copilot.lua)
| Key | Mode | Description |
|-----|------|-------------|
| `<M-l>` | i | Accept suggestion |
| `<M-j>` | i | Next suggestion |
| `<M-k>` | i | Previous suggestion |

## Mode Legend

- **n** Normal · **i** Insert · **v** Visual · **x** Visual-char · **o** Operator-pending · **c** Command · **s** Select · **t** Terminal

## Prefix Groups

| Prefix | Domain |
|--------|--------|
| `g` | Go-to / navigation (LSP + mini.ai motions) |
| `<leader>c` | Code actions, format, rename, AI |
| `<leader>d` | DAP debug |
| `<leader>f` | File / buffer search (fzf-lua) |
| `<leader>g` | Git |
| `<leader>l` | LSP management |
| `<leader>o` | Overseer tasks |
| `<leader>s` | Search / diagnostics |
| `<leader>t` | Testing + UI toggles (git blame, signs) |
| `<leader>u` | UI toggles (hints, virtual text, format, scrollbar) |
| `<leader>e/E/-` | File explorer (mini.files) |
| `<leader>cc/<C-g>` | CodeCompanion chat |

## Plugin Summary

| Category | Plugin(s) |
|----------|-----------|
| File explorer | mini.files |
| Fuzzy find | fzf-lua (primary), mini.pick (ui.select) |
| Syntax | nvim-treesitter + textobjects |
| Text objects | mini.ai (treesitter + custom) |
| Completion | blink.cmp (copilot, LSP, snippets, buffer, dadbod) |
| Formatting | conform.nvim (prettier, csharpier, gofumpt, shfmt, stylua) |
| Tasks / build | overseer.nvim |
| Testing | neotest (jest, vitest, dotnet, golang, deno) |
| Debugging | nvim-dap + dap-ui + dap-virtual-text |
| Git | gitsigns, mini.diff, vim-fugitive, vim-merginal |
| AI | copilot.lua + codecompanion.nvim + mcphub.nvim |
| DB | vim-dadbod + dadbod-ui |
| Markdown | render-markdown.nvim + live-preview.nvim |
| Diagnostics | trouble.nvim |
| Outline | aerial.nvim |
| Scrollbar | satellite.nvim |
| Statusline | mini.statusline (custom: mode icon, branch, ●N diags, LSP) |
| Tabline | mini.tabline (icons, ● modified marker) |
| Notifications | mini.notify (icon-prefixed, LSP progress) |
| UI lib | mini.clue, mini.diff, mini.files, mini.hipatterns, mini.icons, mini.indentscope |
| Themes | sonokai (default), catppuccin-mocha (alt), tokyonight (alt) |
