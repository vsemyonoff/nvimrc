local M = {}

M.setup = function(_, _)
    local include = require('core/utils').pkg_include
    include('mappings/cmake').setup()

    local setlocal = vim.opt_local
    setlocal.number = false
    setlocal.relativenumber = false
    setlocal.signcolumn = "no"
end

return M
