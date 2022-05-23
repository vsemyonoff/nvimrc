local border_style = require('core/utils').include('config').ui.border_style

require('dressing').setup({
    input = { --
        border = border_style,
        winblend = 0,
    },
    select = {
        backend = { "telescope", "builtin", "nui" },
        builtin = { --
            border = border_style,
            winblend = 0,
        },
        nui = {
            border = { --
                style = border_style,
            },
        },
    },
})
