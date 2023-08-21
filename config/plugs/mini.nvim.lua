local status, align = pcall(require, 'mini.align')
if (not status) then return end

align.setup({})

-- gc for comments
require('mini.comment').setup({})
require('mini.cursorword').setup({})
require('mini.indentscope').setup({
  symbol = '┆',
})
-- sa|sd|sr<caracter surround a reemplazar><caracter surround nuevo> para añadir,eliminar o reemplazar el surrounding actual, textofbjects y otros
require('mini.surround').setup({}) 
-- f|F para avanzar/retroceder hasta la siguiente f t|T<character> lo mismo con otro caracter, ';' para repetir movimiento
require('mini.jump').setup({})
require('mini.pairs').setup({})

-- require('mini.tabline').setup({})
require('mini.bufremove').setup({})

require('mini.files').setup({
  mappings = {
    go_in_plus = '<CR>'
  },
  options = {
    use_as_default_explorer = true,
  },
  windows = {
    preview = true
  }
})
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
