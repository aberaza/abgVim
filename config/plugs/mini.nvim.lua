local status, align = pcall(require, 'mini.align')
if (not status) then return end

align.setup({})

-- gc for comments
require('mini.comment').setup({})
require('mini.cursorword').setup({})
-- sa|sd|sr|sh<caracter surround a reemplazar><caracter surround nuevo> para añadir,eliminar, reemplazar el surrounding actual, textofbjects y otros
require('mini.surround').setup({}) 
-- f|F para avanzar/retroceder hasta la siguiente f t|T<character> lo mismo con otro caracter, ';' para repetir movimiento
require('mini.jump').setup({})
require('mini.pairs').setup({})

require('mini.indentscope').setup({ symbol = '┆', options = { border = "top", try_as_border = true } })
require('mini.bufremove').setup({})
-- Disable for certain filetypes
      vim.api.nvim_create_autocmd({ "FileType" }, {
        desc = "Disable indentscope for certain filetypes",
        callback = function()
          local ignore_filetypes = {
            "aerial",
            "dashboard",
            "help",
            "lazy",
            "leetcode.nvim",
            "mason",
            "neo-tree",
            "NvimTree",
            "neogitstatus",
            "notify",
            "startify",
            "toggleterm",
            "Trouble"
          }
          if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
            vim.b.miniindentscope_disable = true
          end
        end,
})

-- require('mini.misc').setup() -- contains a zoom() function

require('mini.files').setup({
  mappings = {
    go_in_plus = '<CR>'
  },
  options = {
    use_as_default_explorer = true, -- if true, will replace netrw
  },
  windows = {
    preview = true,
    width_preview = 60,
    width_focus = 35,
    width_nonfocus = 15,
  }
})

require('mini.pick').setup({})
require('mini.extra').setup({})

-- Provide help with keymappings, clashes with Which 
local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<leader>' },
    { mode = 'x', keys = '<leader>' },
    -- Windows
    { mode = 'n', keys = '<C-w>' },
    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },
    -- Built-in completion
    -- { mode = 'i', keys = '<C-x>' },
    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = "g'" },
    { mode = 'n', keys = '`' },
    { mode = 'n', keys = 'g`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = "g'" },
    { mode = 'x', keys = '`' },
    { mode = 'x', keys = 'g`' },
    -- G key 
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },
    -- Folds
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },
  clues = {
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.registers({ show_contents = true}),
    -- miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.z(),
    { mode = 'n', keys = '<leader>s', desc='Find word under cursor' },
    { mode = 'x', keys = '<leader>s', desc='Find word under cursor' },
    { mode = 'n', keys = '<leader>*', desc='Find word under cursor' },
    { mode = 'n', keys = '<leader>b', desc='Find buffers' },
    { mode = 'n', keys = '<leader>fb', desc='Find buffers' },
    { mode = 'n', keys = '<leader>c', desc='Find commands' },
    { mode = 'n', keys = '<leader>fc', desc='Find colorschemes' },
    { mode = 'n', keys = '<leader>fh', desc='Find help tags' },
    { mode = 'n', keys = '<leader>fm', desc='Find maps' },
  },
  window = {
    config = { anchor = 'NE', row='auto', col='auto', width='auto'},
  },
  delay=300 
})
-- require('mini.tabline').setup({})
-- require('mini.completion').setup({})
-- require('mini.jump2d').setup({
--   start_jumping = 'S',
-- })
-- Mover bloques visuales o lineas con Alt + dirección en modo visual y normal
-- require('mini.move').setup({}) 

-- local function lsp_clients()
--   local buf_clients = vim.lsp.buf_get_clients()
--   if next(buf_clients) == nil then
--     return ""
--   end
--   local buf_client_names = {}
--   for _, client in pairs(buf_clients) do
--     if client.name ~= "null-ls" then
--       table.insert(buf_client_names, client.name)
--     end
--   end
--   return "[" .. table.concat(buf_client_names, ", ") .. "]"
-- end
--
-- local function lsp_progress()
--   -- if not is_active then
--   -- 	return
--   -- end
--   local messages = vim.lsp.util.get_progress_messages()
--   if #messages == 0 then
--     return ""
--   end
--   local status = {}
--   for _, msg in pairs(messages) do
--     local title = ""
--     if msg.title then
--       title = msg.title
--     end
--     table.insert(status, (msg.percentage or 0) .. "%% " .. title)
--   end
--   local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
--   local ms = vim.loop.hrtime() / 1000000
--   local frame = math.floor(ms / 120) % #spinners
--   return table.concat(status, "  ") .. " " .. spinners[frame + 1]
-- end
-- vim.api.nvim_set_hl(0, "MiniStatuslineLspClient", { fg = "#a9a1e1" })

-- local function file_info()
--   local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
--   local file_name, file_ext, file_type = vim.fn.expand('%:t'), vim.fn.expand('%:e'), vim.bo.fileencoding or vim.bo.encoding 
--   -- if not has_devicons then return string.format('%s  [%s]', file_ext, file_type) end
--   local file_type_icon, file_enc_icon = vim.fn;WebDevIconsGetFileTypeSymbol(), vim.fn.WebDevIconsGetFileFormatSymbol()
--   return string.format('[%s - %s]:%s', file_type_icon, file_ext, file_enc_icon)
-- end
--
-- local function status_line()
--   local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
--   local git = MiniStatusline.section_git({ trunc_width = 75 })
--   local filename = MiniStatusline.section_filename({ trunc_width = 140 })
--   local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
--   local clients = lsp_clients()
--   local progress = lsp_progress()
--   -- local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
--   local fileinfo = file_info()
--
--   local location = MiniStatusline.section_location({ trunc_width = 75 })
--   return MiniStatusline.combine_groups({
--     { hl = mode_hl, strings = { mode } },
--     { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
--     "%<", -- truncate point 
--     { hl = 'MiniStatuslineFilneame', strings = { filename } },
--     { hl = "MiniStatuslineLspClient", strings = { clients } },
--     { hl = "MiniStatuslineLspClient", strings = { progress } },
--     "%=", -- end of left alignment
--     { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
--     { hl = mode_hl, strings = { location } },
--   })
-- end
--
-- require("mini.statusline").setup({
--   content = {
--     active = status_line,
--   },
--   use_icons = true,
--   set_vim_settings = false,
-- })

-- -- KEYMAPS
-- vim.keymap.set('n', '<C-B>', ':lua MiniFiles.open()<CR>')
