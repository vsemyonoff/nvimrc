local options = {
    -- Compiled file's destination location
    -- compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    -- compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = false, -- Disable setting background
    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = true, -- Non focused panes set to alternative background
    styles = { -- Style to be applied to different syntax groups
        comments = "italic", -- Value is any valid attr-list value `:help attr-list`
        functions = "NONE",
        keywords = "NONE",
        numbers = "NONE",
        strings = "NONE",
        types = "NONE",
        variables = "NONE",
    },
    inverse = { -- Inverse highlight for different types
        match_paren = false,
        visual = false,
        search = false,
    },
    modules = { -- List of various plugins and additional options
        -- ...
    },
}

local groups = {
    all = {
        LineNr = { bg = "bg0" },
        SignColumn = { bg = "bg0" },
        SignColumnSB = { bg = "bg0" },
        -- GitSigns
        GitSignsAdd = { bg = "bg0" }, -- diff mode: Added line |diff.txt|
        GitSignsChange = { bg = "bg0" }, -- diff mode: Changed line |diff.txt|
        GitSignsDelete = { bg = "bg0" }, -- diff mode: Deleted line |diff.txt|
    },
}

require('nightfox').setup({ options = options, groups = groups })

-- Apply theme
local theme = require('core/utils').include('config').ui.theme
vim.cmd(('colorscheme %s'):format(theme))
