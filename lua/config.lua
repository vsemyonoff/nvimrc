local stdpath = vim.fn.stdpath

local M = {
    lsp = {
        servers = {
            "bashls", -- Bash
            "clangd", -- C/C++
            "efm", -- Formatter
            "sumneko_lua", -- Lua LS
        },
    },

    packer = {
        setup = {
            path = ("%s/site/pack/packer/opt/packer.nvim"):format(stdpath("data")),
            url = "https://github.com/wbthomason/packer.nvim",
        },
        spec = 'plugin',
        user_config = {},
        floating = true,
    },

    system = {
        main = "core", -- setup entry point
        leader = " ", -- Leader key
    },

    ui = {
        border_style = "rounded", -- none, single, double, rounded, solid, shadow
        theme = "nordfox",
    },
}

return M
