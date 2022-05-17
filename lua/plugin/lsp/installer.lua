local M = {}

local stdpath = vim.fn.stdpath

local settings = {
    automatic_installation = true,
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗",
        },
    },
    install_root_dir = ("%s/lsp"):format(stdpath("data")),
    log_level = vim.log.levels.WARN,
}

M.setup = function() require('nvim-lsp-installer').setup(settings) end

return M
