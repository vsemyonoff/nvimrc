local M = {}

M.setup = function()
    local nmap = require('core/utils').nmap
    nmap("<A-}>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer tab" })
    nmap("<A-{>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer tab" })
end

return M
