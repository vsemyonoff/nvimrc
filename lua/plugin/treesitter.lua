local treesitter = require('nvim-treesitter/configs')

treesitter.setup({
    ensure_installed = "all",
    sync_install = false,
    ignore_install = {},
    highlight = {
        enable = true,
        disable = { "org" },
        additional_vim_regex_highlighting = { "org" },
    },
    context_commentstring = { enable = true, enable_autocmd = false },
    autopairs = { enable = true },
    incremental_selection = { enable = true },
    indent = { enable = false },
    rainbow = {
        enable = true,
        disable = { "html" },
        extended_mode = false,
        max_file_lines = nil,
    },
    autotag = { enable = true },
})
