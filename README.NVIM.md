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

### Autocomplete Suggestions & Snippets (CMP)

- `Down` -> Next suggestion
- `Up` -> Previous suggestion
- `<C-n>` -> Open Suggestions / Next suggestion
- `<C-p>` -> Open Suggestions / Previous suggestion
- `<C-y>` -> Accept suggestion
- `<C-e>` -> Abort

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


## Flows & Tools

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

