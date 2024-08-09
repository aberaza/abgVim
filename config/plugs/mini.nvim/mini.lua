require('mini.align').setup()
require('mini.comment').setup()
require('mini.cursorword').setup()
-- sa|sd|sr|sh<caracter surround a reemplazar><caracter surround nuevo> para añadir,eliminar, reemplazar el surrounding actual, textofbjects y otros
require('mini.surround').setup() 
-- f|F para avanzar/retroceder hasta la siguiente f t|T<character> lo mismo con otro caracter, ';' para repetir movimiento
-- require('mini.jump').setup()
require('mini.pairs').setup()

-- require('mini.tabline').setup( { set_vim_settings = false })
require('mini.extra').setup({})

require('mini.move').setup()
require('mini.bufremove').setup({})
