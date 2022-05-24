require("diffview").setup({
    icons = { -- Only applies when use_icons is true.
        folder_closed = "",
        folder_open = "",
    },
    signs = { fold_closed = "", fold_open = "" },
    file_panel = {
        listing_style = "list", -- One of 'list' or 'tree'
    },
})
