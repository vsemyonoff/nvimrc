local M = {}

local autocmd = vim.api.nvim_create_autocmd

local config = function()
    local setlocal = vim.opt_local
    setlocal.number = false
    setlocal.relativenumber = false
    setlocal.signcolumn = "no"
end

M.setup = function(_, _)
    autocmd("User", {
        pattern = "MainStartupComplete",
        callback = config,
        once = true,
        group = "PackerUserSetup",
        desc = "Fix Packer window look after config reloaded",
    })
    config()
end

return M
