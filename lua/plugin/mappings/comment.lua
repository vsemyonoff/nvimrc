local M = {}

local utils = require('core/utils')
local nmap, vmap = utils.nmap, utils.vmap

M.setup = function()
    nmap("<leader>/", function() require("Comment.api").toggle_current_linewise() end, {
        desc = "Comment line",
    })
    vmap("<leader>/", "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>",
         { desc = "Toggle comment line" })
end

return M
