local status, dapui = pcall(require, "dapui")
if (not status) then return end

dapui.setup {
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        { id = "breakpoints", size = 0.20 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.30 },
      },
      size = 50,
      position = 'right',
    },
    {
      elements = { 'repl' },
      size = 10,
      position = 'bottom',
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 }
}
