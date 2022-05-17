local M = {}

M.setup = function(_, _)
    local bnmap = require('core/utils').bnmap
    bnmap("<esc>", "<cmd>helpclose<cr>", { desc = "Close help window" })

    local setlocal = vim.opt_local
    setlocal.number = true
    setlocal.relativenumber = false
    setlocal.signcolumn = "no"
end

return M
