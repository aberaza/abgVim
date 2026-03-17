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
- [AI & Copilot](#ai--copilot)
- [UI & Toggles](#ui--toggles)
- [Windows & Tabs](#windows--tabs)
- [Built-in Keymaps](#built-in-keymaps)

## Basic Operations

| Key | Mode | Description | Context |
|-----|------|-------------|---------|
| `<C-s>` | n,i | Save file | Basic |
| `<leader>w` | n,i | Save file (alternative) | Basic |

## Motions & Navigation

| Key | Mode | Description | Context |
|-----|------|-------------|---------|
| `gD` | n | Goto Declaration | LSP |
| `gd` | n | Goto Definition | LSP |
| `gI` | n | Goto Type Definition | LSP |
| `gi` | n | Goto Implementation | LSP |
| `gr` | n | Goto References | LSP |
| `gs` | n | Signature Help | LSP |
| `gO` | n | Document Symbols | LSP (fzf-lua) |
| `gW` | n | Workspace Symbols | LSP (fzf-lua) |
| `[d` | n | Previous Diagnostic | LSP |
| `]d` | n | Next Diagnostic | LSP |
| `[e` | n | Previous Error | LSP |
| `]e` | n | Next Error | LSP |

## Text Objects & Selection

| Key | Mode | Description | Plugin |
|-----|------|-------------|--------|
| `<c-space>` | n,x | Increment Selection | nvim-treesitter |
| `<bs>` | x | Decrement Selection | nvim-treesitter |

## Editing & Operations

| Key | Mode | Description | Context |
|-----|------|-------------|---------|
| `K` | n | Hover Documentation | LSP |
| `<C-k>` | i | Signature Help | LSP |

## Search & Find

| Key | Mode | Description | Plugin |
|-----|------|-------------|--------|
| `<C-p>` | n | Find Files | fzf-lua |
| `<C-S-P>` | n | Find Actions | fzf-lua |
| `<C-F>` | n | Find in Files | fzf-lua |
| `<leader>s` | n | Find Word under Cursor | fzf-lua |
| `<leader>ff` | n | Find Files (Full Search) | fzf-lua |
| `<leader>fb` | n | Find Buffers | fzf-lua |
| `<leader>fC` | n | Find Commands | fzf-lua |
| `<leader>fc` | n | Find Colorscheme | fzf-lua |

## LSP & Code Intelligence

| Key | Mode | Description | Context |
|-----|------|-------------|---------|
| `<leader>li` | n | Incoming Calls | LSP |
| `<leader>lr` | n | Stop LSP | LSP |
| `<leader>ll` | n | LSP Log | LSP |

## Diagnostics

| Key | Mode | Description | Plugin |
|-----|------|-------------|--------|
| `<leader>dl` | n | Line Diagnostics | LSP |
| `<leader>xx` | n | Diagnostics Toggle (Trouble) | trouble.nvim |
| `<leader>sd` | n | Find Document Diagnostics | fzf-lua |
| `<leader>sD` | n | Find Workspace Diagnostics | fzf-lua |

## Code Actions & Refactoring

| Key | Mode | Description | Context |
|-----|------|-------------|---------|
| `<leader>ca` | n,v | Code Action | LSP |
| `<leader>cA` | n | Source Action | LSP |
| `<leader>cr` | n | Rename Symbol | LSP |
| `<leader>cR` | n,v | Refactor Selected Code (AI) | codecompanion.nvim |
| `<leader>cf` | n | Format Buffer | LSP |
| `<leader>cF` | x | Format Selection | LSP |
| `<leader>ci` | n | Import All Missing | LSP |
| `<leader>co` | n | Organize Imports | LSP |

## File Management

| Key | Mode | Description | Plugin |
|-----|------|-------------|--------|
| `<leader>e` | n | Explorer (Mini.files) | mini.files |
| `<leader>E` | n | Explorer Current File | mini.files |
| `g.` | n | Toggle dotfiles | mini.files |

## Git Integration

| Key | Mode | Description | Plugin |
|-----|------|-------------|--------|
| `<leader>tb` | n | Toggle Line Blame | gitsigns.nvim |
| `<leader>hb` | n | Show Line Blame | gitsigns.nvim |
| `<leader>go` | n | Toggle Diff Overlay | mini.diff |

## Testing & Debugging

### Testing
| Key | Mode | Description | Plugin |
|-----|------|-------------|--------|
| `<leader>tf` | n | Test File | neotest |
| `<leader>tfd` | n | Test File with DAP | neotest |
| `<leader>tx` | n | Test Suite | neotest |
| `<leader>tl` | n | Test Last | neotest |
| `<leader>tld` | n | Test Last with DAP | neotest |
| `<leader>tn` | n | Test Nearest | neotest |
| `<leader>tnd` | n | Test Nearest with DAP | neotest |
| `<leader>tv` | n | Test Visit | neotest |
| `<leader>ta` | n | Test Attach | neotest |
| `<leader>ts` | n | Test Stop | neotest |
| `<leader>tS` | n | Toggle Test Summary | neotest |
| `<leader>to` | n | Test Output | neotest |

### Debugging
| Key | Mode | Description | Plugin |
|-----|------|-------------|--------|
| `<leader>dc` | n | Continue / Start | nvim-dap |
| `<leader>di` | n | Step Into | nvim-dap |
| `<leader>do` | n | Step Over | nvim-dap |
| `<leader>du` | n | Step Out | nvim-dap |
| `<leader>db` | n | Step Back | nvim-dap |
| `<leader>dR` | n,v | Run to Cursor | nvim-dap |
| `<leader>dt` | n,v | Toggle Breakpoint | nvim-dap |
| `<leader>dC` | n | Conditional Breakpoint | nvim-dap |
| `<leader>dL` | n | Log Point | nvim-dap |
| `<leader>dr` | n | Toggle REPL | nvim-dap |
| `<leader>dg` | n | Get Session | nvim-dap |
| `<leader>dd` | n | Disconnect | nvim-dap |
| `<leader>dx` | n | Terminate | nvim-dap |
| `<leader>dq` | n | Quit | nvim-dap |
| `<leader>dU` | n | Toggle DAP UI | nvim-dap-ui |
| `<leader>de` | n,v | Eval Expression | nvim-dap-ui |

## AI & Copilot

| Key | Mode | Description | Plugin |
|-----|------|-------------|--------|
| `ga` | v | Add to Chat | codecompanion.nvim |
| `<C-g>` | v | Add to Chat (alternative) | codecompanion.nvim |
| `<leader>cc` | n | Toggle CodeCompanion Chat | codecompanion.nvim |
| `<C-g>` | n | Toggle CodeCompanion Chat (alternative) | codecompanion.nvim |
| `<leader>ce` | v | Explain Selected Code | codecompanion.nvim |
| `<leader>cR` | v | Refactor Selected Code (AI) | codecompanion.nvim |
| `<leader>cg` | n | Generate Code Snippet | codecompanion.nvim |

## UI & Toggles

| Key | Mode | Description | Context |
|-----|------|-------------|---------|
| `<leader>uh` | n | Toggle Inlay Hints | LSP |
| `<leader>uv` | n | Toggle Diagnostic Virtual Text (on/off) | LSP |
| `<leader>uV` | n | Cycle Diagnostic Virtual Text (full→minimal→off) | LSP |
| `<leader>us` | n | Toggle Semantic Tokens | LSP |

## Windows & Tabs

| Key | Mode | Description | Context |
|-----|------|-------------|---------|
| `<leader>nl` | n | FileTree Toggle & Find | nvim-tree |

## Built-in Keymaps

### Completion (blink.cmp — super-tab preset)
| Key | Mode | Description | Plugin |
|-----|------|-------------|--------|
| `<Tab>` | i,s | Accept completion / Next item | blink.cmp |
| `<S-Tab>` | i,s | Previous item | blink.cmp |
| `<C-n>` | i | Select Next Completion | blink.cmp |
| `<C-p>` | i | Select Previous Completion | blink.cmp |
| `<C-Space>` | i | Open menu / Show docs | blink.cmp |
| `<C-e>` | i | Hide menu | blink.cmp |
| `<C-k>` | i | Toggle signature help | blink.cmp |

## Mode Legend

- **n** - Normal mode
- **i** - Insert mode  
- **v** - Visual mode
- **x** - Visual mode (characterwise)
- **c** - Command mode
- **s** - Select mode
- **t** - Terminal mode

## Keymap Organization

### Prefix Groups
- `g` - Go to/movement operations
- `<leader>c` - Code-related actions
- `<leader>d` - Debug / Diagnostic operations
- `<leader>f` - File operations
- `<leader>g` - Git operations
- `<leader>l` - LSP server management
- `<leader>s` - Search operations
- `<leader>t` - Testing operations
- `<leader>u` - UI toggles
- `<leader>a` - AI operations

### Case Conventions
- Lowercase = basic/primary action
- Uppercase = advanced/alternative action
- `<C-` prefix = control key combinations
- `<M-` prefix = alt/meta key combinations

## Plugin Categories

### File Management
- **mini.files**: Lightweight file explorer
- **fzf-lua**: Fuzzy finding for files, buffers, commands
- **nvim-tree**: File tree sidebar

### Code Navigation & Editing
- **nvim-treesitter**: Syntax highlighting and incremental selection
- **blink.cmp**: Autocompletion engine (with copilot, LSP, snippets, buffer sources)

### Testing & Debugging
- **neotest**: Testing framework with DAP integration (JS, Go, .NET, Vitest, Deno)
- **nvim-dap**: Debug Adapter Protocol for debugging (JS/TS, Chrome, Firefox, Go, .NET)
- **nvim-dap-ui**: Visual debugging interface with scopes, breakpoints, stacks, watches

### Git Integration
- **gitsigns.nvim**: Git signs and blame information
- **mini.diff**: Diff overlay functionality

### AI & Code Generation
- **codecompanion.nvim**: AI chat and code assistance
- **copilot.lua**: GitHub Copilot integration

### Diagnostics & UI
- **trouble.nvim**: Pretty diagnostics display

## Notes

- All keymaps use `<leader>` as the prefix (default: space)
- Plugin-specific keymaps are only available when the plugin is loaded
- Some keymaps work in multiple modes for consistency
- LSP keymaps are defined in `config/utils.lua` and are always available when LSP is active
- Alternative keymaps are provided for frequently used actions (e.g., `<C-s>` and `<leader>w>` for save)
- Visual mode keymaps are only included where they make logical sense
