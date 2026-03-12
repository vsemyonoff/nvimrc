local M = {}

M.setup = function()
  local set = vim.opt_local
  set.shiftwidth = 4
  set.tabstop = 4
  set.softtabstop = 4
  set.expandtab = true
end

return M
