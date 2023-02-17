local status, indent = pcall(require, 'indent_blankline')
if (not status) then return end

indent.setup {
    use_treesitter = true,
    use_treesitter_scop = true,
    show_end_of_line = false,
    char = "", -- indicator for all contexts not in focus
    context_char="▏", --indicator for context in focus
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    -- context_patterns = {'class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', '^block', 'arguments'},
    -- max_indent_increase = 1, -- Aligned trailing multiline commnets not create indentation
}
