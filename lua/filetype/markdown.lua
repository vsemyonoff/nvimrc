local M = {}

M.setup = function(_, _)
    local setlocal = vim.opt_local
    setlocal.spell = true
end

return M
