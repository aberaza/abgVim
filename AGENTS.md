# AGENTS.md - Dual Vim/Neovim Configuration Guidelines

## Repository Structure
This repository contains TWO separate configurations:
1. **VimScript Configuration** - Entry points: `vimrc` (Vim) / `ginit.vim` (GUI)
2. **Lua Configuration** - Entry point: `init.lua` (Neovim only)

## Build/Lint/Test Commands

### VimScript Configuration
- Test Vim config: `vim -u vimrc -c "qa"`
- Test Neovim with vim-plug: `nvim -u vimrc --headless -c "qa"`
- Plugin management: `:PlugInstall`, `:PlugUpdate`, `:PlugClean`

### Lua Configuration  
- Test Lua config: `nvim --headless -c "lua require('config.options')" -c "qa"`
- Check syntax: `nvim --headless -c "luafile %" -c "qa"` for individual Lua files
- Plugin management: `:Lazy install`, `:Lazy update`, `:Lazy clean`
- Lint Lua files with `luacheck` if available

## Code Style Guidelines

### VimScript Files (.vim)
- Use 2-space indentation
- Function names: `snake_case` with `function! Name()`
- Variables: `g:` for globals, `l:` for locals, `s:` for script-local
- Use `NEOVIM()`, `VIM()`, `MAC()`, `LINUX()` helper functions for platform detection
- Conditional plugin loading with `NPlug`, `VPlug`, `APlug` commands
- Use `call SourceFile()` for safe file sourcing

### Lua Files (.lua)
- Use 2-space indentation consistently
- Prefer `vim.opt` over `vim.o` for complex options
- Use local variables for frequently accessed APIs (`local opt = vim.opt`)
- Use `require()` for module imports with local aliases: `local cmp = require('cmp')`
- Variables: `snake_case` for locals, `PascalCase` for modules
- Functions: `snake_case` for regular functions
- Use `pcall()` for safe module loading

### Plugin Configuration
- **VimScript**: Use vim-plug with conditional loading (`NPlug`/`VPlug`)
- **Lua**: Use lazy.nvim with `opts` function pattern for complex configs
- Keep plugin configs in `config/plugs/` (VimScript) or `lua/plugins/` (Lua)
- Use event-based loading (`event = "BufReadPre"`) for performance

### Keymaps
- **VimScript**: Use `abg#register_keys()` helper or direct `nnoremap` etc.
- **Lua**: Use `vim.keymap.set()` with `key_opts()` helper for consistent options
- Include descriptions for all keymaps

### Error Handling
- **VimScript**: Use `try/catch` blocks and check `exists()`
- **Lua**: Use `pcall()` for safe module loading, check plugin existence before requiring