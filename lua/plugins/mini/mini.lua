return {
  { 'echasnovski/mini.extra', version = false, opts = {} },
  { 'echasnovski/mini.comment',    version = false, opts = {} },
  { 'echasnovski/mini.cursorword', version = false, opts = {} },
  { 'echasnovski/mini.surround',   version = false, opts = {} },
  { 'echasnovski/mini.pairs',      version = false, opts = {} },
  { 'echasnovski/mini.move',       version = false, opts = {} },
  { 'echasnovski/mini.bufremove',  version = false, opts = {} },

  -- ── Tabline ────────────────────────────────────────────────────────────
  { 'echasnovski/mini.tabline',
    version = false,
    lazy = false,
    config = function()
      require('mini.tabline').setup({
        show_icons = true,
        -- Show tab-page number on the right only when >1 tab pages are open
        tabpage_section = 'right',
        -- Add a "+" suffix for modified buffers
        format = function(buf_id, label)
          local suffix = vim.bo[buf_id].modified and ' ● ' or ' '
          return MiniTabline.default_format(buf_id, label) .. suffix
        end,
      })
    end,
  },

  -- ── Notify ─────────────────────────────────────────────────────────────
  { 'echasnovski/mini.notify',
    version = false,
    lazy = false,
    config = function()
      local level_icons = {
        ERROR = ' ',
        WARN  = ' ',
        INFO  = ' ',
        DEBUG = ' ',
        TRACE = '󰛿 ',
        OFF   = '  ',
      }

      require('mini.notify').setup({
        content = {
          -- Prefix each notification with a severity icon; strip the timestamp
          -- (keep output terse — minimalist aesthetic).
          format = function(notif)
            -- LSP progress messages: show as-is, no icon prefix
            if notif.data and notif.data.source == 'lsp_progress' then
              return notif.msg
            end
            local icon = level_icons[notif.level] or '  '
            return icon .. notif.msg
          end,
          -- Most recent first
          sort = function(notif_arr)
            table.sort(notif_arr, function(a, b)
              return (a.ts_update or 0) > (b.ts_update or 0)
            end)
            return notif_arr
          end,
        },
        lsp_progress = {
          enable = true,
          level  = 'INFO',
          duration_last = 800,
        },
        window = {
          config = {
            border = 'rounded',
            -- Anchor to bottom-right, just above the statusline
            anchor = 'SE',
            row    = vim.o.lines - 3,
            col    = vim.o.columns - 2,
          },
          max_width_share = 0.35,
          winblend = 15,
        },
      })

      -- Override vim.notify globally so all plugins go through mini.notify
      vim.notify = require('mini.notify').make_notify()
    end,
  },

  -- ── Statusline ─────────────────────────────────────────────────────────
  { 'echasnovski/mini.statusline',
    version = false,
    lazy = false,
    dependencies = { 'echasnovski/mini.icons' },
    config = function()
      local statusline = require('mini.statusline')

      -- Mode symbols: single Unicode character per mode (dot for normal,
      -- pen for insert, etc.) — avoids text labels while staying readable.
      local mode_symbols = {
        n   = '●', -- NORMAL
        no  = '○', -- OP-PENDING
        nov = '○',
        noV = '○',
        i   = '', -- INSERT
        ic  = '',
        ix  = '',
        v   = '󰒉', -- VISUAL
        V   = '󰒊', -- V-LINE
        [string.char(22)] = '󰒋', -- V-BLOCK
        s   = '', -- SELECT
        S   = '',
        R   = '󰛔', -- REPLACE
        Rv  = '󰛔',
        c   = '', -- COMMAND
        cv  = '',
        ce  = '',
        r   = '…',
        rm  = '…',
        ['r?'] = '?',
        ['!'] = '!',
        t   = '', -- TERMINAL
      }

      -- Diagnostic counts as coloured dots: ●2 ●1
      local function diag_counts()
        local counts = {}
        local sev = vim.diagnostic.severity
        local icons = {
          [sev.ERROR] = { sym = ' ', hl = 'DiagnosticError' },
          [sev.WARN]  = { sym = ' ', hl = 'DiagnosticWarn'  },
          [sev.INFO]  = { sym = ' ', hl = 'DiagnosticInfo'  },
          [sev.HINT]  = { sym = ' ', hl = 'DiagnosticHint'  },
        }
        local diags = vim.diagnostic.get(0)
        local totals = {}
        for _, d in ipairs(diags) do
          totals[d.severity] = (totals[d.severity] or 0) + 1
        end
        for _, s in ipairs({ sev.ERROR, sev.WARN, sev.INFO, sev.HINT }) do
          if totals[s] and totals[s] > 0 then
            table.insert(counts, icons[s].sym .. totals[s])
          end
        end
        return table.concat(counts, ' ')
      end

      -- Git branch via gitsigns (no fugitive dependency at display time)
      local function git_branch(trunc_width)
        if statusline.is_truncated(trunc_width) then return '' end
        local ok, gs = pcall(require, 'gitsigns')
        if not ok then return '' end
        local head = vim.b.gitsigns_head
        if not head or head == '' then return '' end
        return ' ' .. head
      end

      statusline.setup({
        -- Show on all windows (not just focused)
        set_vim_settings = true,
        use_icons = true,

        content = {
          -- ── Active window ──────────────────────────────────────────────
          active = function()
            local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
            -- Replace the wordy mode string with the icon
            local raw_mode = vim.fn.mode()
            local mode_icon = mode_symbols[raw_mode]
              or mode_symbols[raw_mode:sub(1, 1)]
              or '●'

            local branch    = git_branch(60)
            local diff      = statusline.section_diff({ trunc_width = 80 })
            local diags     = diag_counts()
            local lsp       = statusline.section_lsp({ trunc_width = 80 })
            local filename  = statusline.section_filename({ trunc_width = 140 })
            local fileinfo  = statusline.section_fileinfo({ trunc_width = 120 })
            local location  = statusline.section_location({ trunc_width = 60 })
            local search    = statusline.section_searchcount({ trunc_width = 60 })

            return statusline.combine_groups({
              { hl = mode_hl,                   strings = { mode_icon } },
              { hl = 'MiniStatuslineDevinfo',   strings = { branch, diff, diags, lsp } },
              '%<',
              { hl = 'MiniStatuslineFilename',  strings = { filename } },
              '%=',
              { hl = 'MiniStatuslineFileinfo',  strings = { fileinfo } },
              { hl = mode_hl,                   strings = { search, location } },
            })
          end,

          -- ── Inactive window — minimal: just filename ────────────────────
          inactive = function()
            local filename = statusline.section_filename({ trunc_width = 9999 })
            return statusline.combine_groups({
              { hl = 'MiniStatuslineInactive', strings = { filename } },
            })
          end,
        },
      })
    end,
  },

  -- ── Indentscope ────────────────────────────────────────────────────────
  { 'echasnovski/mini.indentscope',
    version = false,
    event = 'BufEnter',
    opts = {
      symbol = '┆',
      options = { border = 'top', try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        desc = 'Disable indentscope for certain filetypes',
        pattern = {
          'aerial', 'codecompanion', 'help', 'lazy', 'leetcode.nvim',
          'mason', 'NvimTree', 'neogitstatus', 'notify', 'Trouble',
        },
        callback = function() vim.b.miniindentscope_disable = true end,
      })
    end,
  },

  -- ── Pick (secondary picker / vim.ui.select) ────────────────────────────
  { 'echasnovski/mini.pick',
    version = false,
    opts = {},
    config = function(_, opts)
      local ok, pick = pcall(require, 'mini.pick')
      if not ok then return end

      vim.ui.select = pick.ui_select

      pick.setup(vim.tbl_deep_extend('force', opts or {}, {
        window = {
          config = function()
            local height = math.floor(vim.o.lines * 0.80)
            local width  = math.floor(vim.o.columns * 0.90)
            return {
              relative = 'editor',
              anchor   = 'NW',
              row      = math.floor((vim.o.lines - height) / 2),
              col      = math.floor((vim.o.columns - width) / 2),
              width    = width,
              height   = height,
              border   = 'rounded',
            }
          end,
          prompt_prefix = '   ',
        },
      }))

      local function set_pick_highlights()
        vim.api.nvim_set_hl(0, 'MiniPickPrompt',       { link = 'Title' })
        vim.api.nvim_set_hl(0, 'MiniPickPromptCaret',  { link = 'Special' })
        vim.api.nvim_set_hl(0, 'MiniPickMatchCurrent', { link = 'IncSearch' })
        vim.api.nvim_set_hl(0, 'MiniPickMatchMarked',  { link = 'Search' })
        vim.api.nvim_set_hl(0, 'MiniPickMatchRanges',  { link = 'Substitute' })
      end
      set_pick_highlights()
      vim.api.nvim_create_autocmd('ColorScheme', { callback = set_pick_highlights })

      pick.registry.colorschemes = function()
        local colorschemes = vim.fn.getcompletion('', 'color')
        return pick.start({
          source = {
            name = 'Colorschemes',
            items = colorschemes,
            choose = function(item) pcall(vim.cmd, 'colorscheme ' .. item) end,
            preview = function(buf_id, item)
              pcall(vim.cmd, 'colorscheme ' .. item)
              vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, { item })
            end,
          },
        })
      end

      local map_opts = { noremap = true, silent = true }
      vim.keymap.set({ 'n', 'v' }, "<leader>fbs",
        "<cmd>Pick buf_lines scope='current'<CR>",
        vim.tbl_extend('force', map_opts, { desc = 'Search buffer' }))
    end,
  },
}
