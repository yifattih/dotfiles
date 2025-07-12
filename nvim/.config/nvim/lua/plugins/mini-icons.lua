-- Author: Yifattih
-- ===========================================================================
-- MINI ICONS
-- ===========================================================================

return {
    'echasnovski/mini.icons',
    lazy = false, -- Load on startup
    config = function()
        require("mini.icons").setup()
    end
}
