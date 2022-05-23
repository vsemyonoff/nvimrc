local M = {}

local include = require('core/utils').include
local stdpath = vim.fn.stdpath

local settings = {
    ensure_installed = include('config').lsp.servers,
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

M.setup = function()
    require('nvim-lsp-installer').setup(settings)
end

return M
