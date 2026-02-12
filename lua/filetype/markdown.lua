local M = {}

M.setup = function()
  local set = vim.opt_local
  set.shiftwidth = 2
  set.spell = true
  set.tabstop = 2
  set.softtabstop = 2
  set.expandtab = true
end

return M
