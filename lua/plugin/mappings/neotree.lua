local M = {}

local nmap = require('core/utils').nmap

local neotreeToggle = function()
    local root = vim.lsp.buf.list_workspace_folders()[1]
    require('neo-tree/command').execute({ toggle = true, dir = root or "~" })
end

M.setup = function() nmap('\\', neotreeToggle) end

return M
