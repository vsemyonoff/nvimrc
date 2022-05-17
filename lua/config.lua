local stdpath = vim.fn.stdpath

local M = {
    system = {
        main = "core", -- setup entry point
        servers = { "bashls", "clangd", "efm", "sumneko_lua" }, -- LSP servers
        leader = " ", -- Leader key
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

    ui = {
        border_style = "rounded", -- none, single, double, rounded, solid, shadow
        theme = "nordfox",
    },
}

return M
