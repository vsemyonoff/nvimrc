local nightfox = require('nightfox')

nightfox.setup({
    fox = "nordfox", -- Which fox style should be applied
    transparent = false, -- Disable setting the background color
    alt_nc = true, -- Non current window bg to alt color see `hl-NormalNC`
    terminal_colors = true, -- Configure the colors used when opening :terminal
    styles = {
        comments = "italic", -- Style that is applied to comments: see `highlight-args` for options
        functions = "NONE", -- Style that is applied to functions: see `highlight-args` for options
        keywords = "NONE", -- Style that is applied to keywords: see `highlight-args` for options
        strings = "NONE", -- Style that is applied to strings: see `highlight-args` for options
        variables = "NONE", -- Style that is applied to variables: see `highlight-args` for options
    },
    inverse = {
        match_paren = false, -- Enable/Disable inverse highlighting for match parens
        visual = false, -- Enable/Disable inverse highlighting for visual selection
        search = false, -- Enable/Disable inverse highlights for search highlights
    },
    colors = {}, -- Override default colors
    hlgroups = {
        LineNr = { bg = "${bg_alt}" },
        SignColumn = { bg = "${bg_alt}" },
        SignColumnSB = { bg = "${bg_alt}" },
        -- GitSigns
        GitSignsAdd = { bg = "${bg_alt}" }, -- diff mode: Added line |diff.txt|
        GitSignsChange = { bg = "${bg_alt}" }, -- diff mode: Changed line |diff.txt|
        GitSignsDelete = { bg = "${bg_alt}" }, -- diff mode: Deleted line |diff.txt|
    },
})

-- Load the configuration set above and apply the colorscheme
nightfox.load()
