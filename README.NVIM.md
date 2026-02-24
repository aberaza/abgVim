# Neovim Config

## Plugins

It uses Lazy plugin manager.

## KeyBindings

### Text/Code

- `gc` -> comment (line, visual block)
- `gcc` -> toggle comment
- `gc` -> text object (so we can do `dgc` and will delete whole comment)
- `sa` (visual/motion) -> `sa <delimiter>` add delimiter as surround
- `sd` -> delete surrounding
- `sf` / `sF` -> find surrounding (right / left)
- `sh` -> highlight surrounding
- For complex surrounds, use `?` as surround to enter interactive prompt for left-right surroundings.
- `v`, `V`, `Ctrl-V` -> Enter visual mode in character, line, and blockwise mode
- `Alt-h,l,j,k` -> move line (visual/normal mode). Lines are reindented automatically.

### UI

- `<leader> go` -> Toggle Diff overlay (show what has changed)

### Autocomplete Suggestions & Snippets (blink.cmp — super-tab preset)

- `Tab` -> Accept completion / Next item
- `S-Tab` -> Previous item
- `<C-n>` -> Next suggestion
- `<C-p>` -> Previous suggestion
- `<C-Space>` -> Open menu / Show docs
- `<C-e>` -> Hide menu
- `<C-k>` -> Toggle signature help

### Copilot Suggestions (shadow text)

- `Alt-l` -> Accept suggestion
- `Alt-j` -> Next suggestion
- `Alt-k` -> Previous suggestion

### Command Mode

- `<C-z>` -> Do not use (suspends the editor)
- `Tab` -> Open/Select next
- `S-Tab` -> Open/Select previous
- `<C-n>` -> (If menu open) Next suggestion
- `<C-e>` -> Abort
- `<C-y>` -> Accept suggestion

### LSP

- `gD` -> GoTo Declaration
- `gd` -> GoTo Definition
- `go` -> GoTo Type Definition
- `gi` -> GoTo Implementation
- `gr` -> GoTo References
- `gs` -> Signature Help
- `K` -> Hover
- `F2` -> Rename symbol
- `F3` -> Format code buffer
- `F4` -> Select Code Action at position
- `<space>cf` -> Reformat Code

### File Tree & Search

- `Ctrl-b` -> Toggle side file tree
- `Ctrl-p` -> Fuzzy find files by name

#### Mini.Files

- `j/k` -> up-down
- `h/l` -> go in and out of folders
- `m<char>` -> bookmark a file
- `'<char>` -> go to bookmark
- `g?` -> Help
- Motion as in any other buffer


## Testing (Neotest)

All languages share the same keymaps via **neotest**. Open a test file first.

| Key | Action |
|-----|--------|
| `<leader>tn` | Run nearest test (under cursor) |
| `<leader>tf` | Run all tests in current file |
| `<leader>tx` | Run entire test suite |
| `<leader>tl` | Re-run last test |
| `<leader>tv` | Run test & enter output |
| `<leader>ta` | Attach to running test process |
| `<leader>ts` | Stop running tests |
| `<leader>tS` | Toggle test summary panel |
| `<leader>to` | Open test output window |

> Append `d` to most run keymaps to launch with DAP attached (e.g. `<leader>tnd`, `<leader>tfd`, `<leader>tld`).

### Per-language adapters

| Language | Adapter | Notes |
|----------|---------|-------|
| **TypeScript / JavaScript** | `neotest-jest` | Detects Jest config automatically |
| **TypeScript / JavaScript** | `neotest-vitest` | Detects Vitest config automatically |
| **TypeScript (Deno)** | `neotest-deno` | Detected when `deno.json` present |
| **C# / .NET** | `neotest-dotnet` | Works with xUnit, NUnit, MSTest |
| **Go** | `neotest-golang` | Uses `go test` under the hood |
| **Other** | `neotest-vim-test` | Fallback for any vim-test compatible runner |

---

## Debugging (nvim-dap + nvim-dap-ui)

The DAP UI opens/closes automatically when a session starts or ends.

### Execution

| Key | Action |
|-----|--------|
| `<leader>dc` | Continue / Start session |
| `<leader>di` | Step Into |
| `<leader>do` | Step Over |
| `<leader>du` | Step Out |
| `<leader>db` | Step Back |
| `<leader>dR` | Run to cursor |

### Breakpoints

| Key | Action |
|-----|--------|
| `<leader>dt` | Toggle breakpoint |
| `<leader>dC` | Conditional breakpoint (prompts for expression) |
| `<leader>dL` | Log point (prints message without stopping) |

### Session & UI

| Key | Action |
|-----|--------|
| `<leader>dU` | Toggle DAP UI manually |
| `<leader>de` | Evaluate expression under cursor / selection |
| `<leader>dr` | Toggle REPL |
| `<leader>dg` | Get current session info |
| `<leader>dd` | Disconnect (keep process running) |
| `<leader>dx` | Terminate session |
| `<leader>dq` | Quit / Close DAP |

### Per-language debug configurations

Select a configuration with `<leader>dc` — a picker appears when multiple configs exist.

#### JavaScript / TypeScript (js-debug)

> Requires `~/bin/js-debug/src/dapDebugServer.js` (manually installed).

| Config name | Description |
|-------------|-------------|
| Launch file (Node) | Runs the current file with Node.js |
| Attach to Node process | Attach to an already-running Node process (process picker) |
| Launch via npm (debug) | Runs `npm run debug` |
| Launch Chrome | Opens Chrome at `http://localhost:3000` |
| Attach Chrome | Attaches to Chrome started with `--remote-debugging-port=9222` |
| Launch Firefox | Opens Firefox at `http://localhost:3000` |
| Attach Firefox | Attaches to a running Firefox debug session |

#### C# / .NET (netcoredbg)

> Install debugger: `:MasonInstall netcoredbg`

| Config name | Description |
|-------------|-------------|
| Launch (.NET) | Runs the built DLL (auto-detects in `bin/Debug/`) |
| Attach (.NET) | Attaches to a running .NET process (process picker) |
| Build & Launch (.NET) | Runs `dotnet build` first, then launches |

#### Go (Delve)

> Install debugger: `:MasonInstall delve` or `go install github.com/go-delve/delve/cmd/dlv@latest`

| Config name | Description |
|-------------|-------------|
| Launch file (Go) | Debugs the current file |
| Launch package (Go) | Debugs the current package |
| Debug test (Go) | Debugs the test function under cursor |
| Debug test suite (Go) | Debugs the entire test suite (`./...`) |
| Attach to process (Go) | Attaches to a running Go process (process picker) |

---



### Git & Fugitive

#### Git Status
* Status with `:Git`
* `-` --> Stage change / file
* `X` --> Discard change / file
* `D` --> Diff change / file
* `dv`, `dh`, `dd` --> Diff in vertical, horizontal or auto split 
* `o` --> Open file in buffer
* `O` --> Open file in vertical split
* `cc` --> Commit
* `ca` --> Amend commit

#### Logs

* `:Git log` --> Show general log
* `:Git log --graph` --> Show graph log
* `:Git log %` --> Show log for current file
* `:Git log % --` --> Show log for current file with diff
* `:0Gllog` --> Fill _location list_ with log for current file (browse with `:lnext` and `:lprev` and `:lclose`)

#### Rebase/Merge

* `:Git rebase -i` `:Git rebase -i HEAD~3` --> Interactive rebase
* `:Git rebase -i <anyref>` --> Interactive rebase from <anyref> 
* [On Log file - on a commit] `ri` --> Interactive rebase from current commit
* `:Git merge <anyref>` --> Merge from <anyref>
* `:Git merge --abort` `:Git rebase --abort` --> Abort merge/rebase
* `:Git merge --continue` `:Git rebase --continue` --> Continue merge/rebase
* `:Gdiffsplit!` --> Resolve conflicts in split view (3 panes)

