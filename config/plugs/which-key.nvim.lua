local status, whichkey = pcall(require, 'which-key')
if (not status) then return end

whichkey.setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
}
