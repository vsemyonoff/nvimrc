require('bufferline').setup({
    options = {
        show_close_icon = false,
        offsets = {
            {
                filetype = "aerial",
                text = "Symbols outline:",
                text_allign = "center",
                padding = 1,
            },
            {
                filetype = "neo-tree",
                text = "File manager:",
                text_allign = "center",
                padding = 1,
            },
            {
                filetype = "packer",
                text = "Package manager:",
                text_allign = "center",
                padding = 1,
            },
        },
        buffer_close_icon = "",
        modified_icon = "",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
        view = "multiwindow",
        separator_style = "thin",
    },
})
