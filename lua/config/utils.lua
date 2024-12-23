local H = {}

H.icons = {
  diagnostics = {
    Error = " ", -- ✘
    Warning = " ",
    Hint  = " ", -- ⚑,
    Information = " ", -- »
  },
  dap = {
    Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint          = " ",
    BreakpointCondition = " ",
    BreakpointRejected  = { " ", "DiagnosticError" },
    LogPoint            = ".>",
  },
}

return H
