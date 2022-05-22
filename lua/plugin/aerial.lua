require('aerial').setup({
    close_behavior = "global",
    backends = { "lsp", "treesitter", "markdown" },
    width = 0.25,
    min_width = 30,
    show_guides = true,
    filter_kind = false,
    guides = {
        mid_item = "├ ",
        last_item = "└ ",
        nested_top = "│ ",
        whitespace = "  ",
    },
})
