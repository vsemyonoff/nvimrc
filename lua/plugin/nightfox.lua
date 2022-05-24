local options = { --
    dim_inactive = true,
    styles = { --
        comments = "italic",
    },
}

local groups = {
    all = {
        -- Base
        LineNr = { bg = "bg0" },
        SignColumn = { bg = "bg0" },
        SignColumnSB = { bg = "bg0" },
        -- GitSigns
        GitSignsAdd = { bg = "bg0" },
        GitSignsChange = { bg = "bg0" },
        GitSignsDelete = { bg = "bg0" },
        -- neo-tree
        NeoTreeNormal = { bg = "bg1" },
        NeoTreeNormalNC = { bg = "bg0" },
    },
}

require('nightfox').setup({ options = options, groups = groups })

local theme = require('core/utils').include('config').ui.theme
vim.cmd({ cmd = "colorscheme", args = { theme } })
