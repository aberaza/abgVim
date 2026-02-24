local M = {}

local MODES = { n = true, v = true, x = true, i = true, c = true, s = true, t = true, o = true }

local function get_mode_char()
    -- Use vim.fn.mode() which is safe to call on startup (no pcall needed).
    local m = vim.fn.mode()
    if not m or m == "" then
        return "n"
    end
    -- operator-pending like "no" -> treat as normal
    if m:sub(1, 2) == "no" then return "n" end
    -- visual line 'V' -> treat as visual ('v')
    if m == "V" then return "v" end
    -- visual-block is represented as a control-V character (decimal 22)
    if m == string.char(22) then return "x" end
    -- take first char for common single-letter modes
    local first = m:sub(1,1)
    if MODES[first] then return first end
    return "n"
end

local function tokenize(lhs)
    local tokens = {}
    local i = 1
    while i <= #lhs do
        local c = lhs:sub(i, i)
        if c == "<" then
            local j = lhs:find(">", i, true)
            if j then
                table.insert(tokens, lhs:sub(i, j))
                i = j + 1
            else
                table.insert(tokens, lhs:sub(i, i))
                i = i + 1
            end
        else
            table.insert(tokens, c)
            i = i + 1
        end
    end
    return tokens
end

local function join_tokens(tokens, from, to)
    from = from or 1
    to = to or #tokens
    if from > to then return "" end
    return table.concat(vim.list_slice(tokens, from, to))
end

local function collect_maps_for_mode(bufnr, mode)
    local result = {}
    local seen = {}
    -- buffer-local maps
    for _, m in ipairs(vim.api.nvim_buf_get_keymap(bufnr, mode)) do
        local key = mode .. "|" .. m.lhs
        seen[key] = true
        table.insert(result, {
            mode = mode,
            lhs = m.lhs,
            rhs = (m.rhs ~= "" and m.rhs) or (m.callback and "<lua>") or "",
            desc = m.desc or "",
            src = "buf",
        })
    end
    -- global maps (only those not shadowed)
    for _, m in ipairs(vim.api.nvim_get_keymap(mode)) do
        local key = mode .. "|" .. m.lhs
        if not seen[key] then
            table.insert(result, {
                mode = mode,
                lhs = m.lhs,
                rhs = (m.rhs ~= "" and m.rhs) or (m.callback and "<lua>") or "",
                desc = m.desc or "",
                src = "glob",
            })
        end
    end
    return result
end

local function build_prefix_groups(maps, prefix_depth)
    prefix_depth = prefix_depth or 1
    local groups = {}         -- prefix_str -> { items = { {lhs, rem, desc, src} } }
    local top_order = {}      -- stable ordering of prefixes
    for _, m in ipairs(maps) do
        local toks = tokenize(m.lhs)
        local prefix = join_tokens(toks, 1, math.min(prefix_depth, #toks))
        local remainder = ""
        if #toks > prefix_depth then
            remainder = join_tokens(toks, prefix_depth + 1, #toks)
        end
        if prefix == "" then prefix = "<empty>" end
        if not groups[prefix] then
            groups[prefix] = { items = {}, prefix_toks = toks }
            table.insert(top_order, prefix)
        end
        table.insert(groups[prefix].items, {
            lhs = m.lhs,
            rem = remainder,
            desc = m.desc,
            rhs = m.rhs,
            src = m.src,
        })
    end
    return groups, top_order
end

local function make_lines(bufnr, prefix_depth)
    prefix_depth = prefix_depth or 1
    local mode = get_mode_char()
    local maps = collect_maps_for_mode(bufnr, mode)
    if #maps == 0 then
        return { string.format("No mappings for current mode (%s) in this buffer.", mode) }
    end

    -- sort maps by lhs for deterministic output
    table.sort(maps, function(a, b) return a.lhs < b.lhs end)

    local groups, order = build_prefix_groups(maps, prefix_depth)
    local lines = {}
    table.insert(lines, string.format("Contextual keymaps — mode: %s  (prefix depth: %d)", mode, prefix_depth))
    table.insert(lines, (""):rep(0))

    for _, prefix in ipairs(order) do
        local g = groups[prefix]
        local header = string.format("Prefix: %s  (%d)", prefix, #g.items)
        table.insert(lines, header)
        for _, it in ipairs(g.items) do
            local right = (it.desc ~= "" and it.desc) or (it.rhs ~= "" and it.rhs) or "<no rhs>"
            local display_lhs = it.rem ~= "" and (prefix .. it.rem) or it.lhs
            local rem_display = it.rem ~= "" and (" → " .. it.rem) or ""
            local src = it.src == "buf" and "[buf]" or "[glob]"
            table.insert(lines, string.format("  %-20s %s %s", display_lhs, right, src))
        end
        table.insert(lines, "") -- spacer
    end

    return lines
end

local function open_floating(lines)
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.bo[bufnr].bufhidden = "wipe"
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
    vim.bo[bufnr].filetype = "context_keys"

    local width = math.min(vim.o.columns - 8, 120)
    local height = math.min(#lines + 2, math.floor(vim.o.lines * 0.7))
    local row = math.floor((vim.o.lines - height) / 2 - 1)
    local col = math.floor((vim.o.columns - width) / 2)

    local win_id = vim.api.nvim_open_win(bufnr, true, {
        relative = "editor",
        row = row,
        col = col,
        width = width,
        height = height,
        style = "minimal",
        border = "rounded",
    })

    -- close mappings (buffer-local to floating buffer)
    vim.keymap.set("n", "q", function() if vim.api.nvim_win_is_valid(win_id) then vim.api.nvim_win_close(win_id, true) end end,
        { buffer = bufnr, nowait = true, silent = true })
    vim.keymap.set("n", "<Esc>", function() if vim.api.nvim_win_is_valid(win_id) then vim.api.nvim_win_close(win_id, true) end end,
        { buffer = bufnr, nowait = true, silent = true })
end

function M.show(opts)
    -- Guard: if Neovim hasn't finished startup (v:v_did_enter == 0),
    -- defer showing until after startup to avoid popup on launch.
    if vim.v.v_did_enter == 0 then
        vim.schedule(function()
            -- re-run after startup
            M.show(opts)
        end)
        return
    end

    local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
    local depth = opts.prefix_depth or 1
    local lines = make_lines(bufnr, depth)
    open_floating(lines)
end

return M
