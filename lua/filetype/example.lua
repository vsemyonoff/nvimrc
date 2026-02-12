local M = {}

-- args:
--   match: a string that matched the pattern (see <amatch>)
--   buf: the number of the buffer the event was triggered in (see <abuf>)
--   file: the file name of the buffer the event was triggered in (see <afile>)
--   data: a table with other relevant data that is passed for some events
M.setup = function(args)
  -- local fname, ftype = args.file, args.match:lower()

  -- local cmd = nil
  -- if ftype == "qf" then
  --   cmd = vim.cmd.cclose
  -- elseif ftype == "help" then
  --   cmd = vim.cmd.helpclose
  -- else
  --   cmd = vim.cmd.quit
  -- end
  -- Core.lbind({ "n", "v" }, "<esc>", cmd, "Close Help/QuickFix/Tool window")

  local set = vim.opt_local
  set.number = false
  set.relativenumber = false
  set.signcolumn = "no"
end

return M
