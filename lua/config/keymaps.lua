local cmd, map, unmap = vim.cmd, Core.bind, vim.keymap.del

-- `;` for command mode
map({ "n", "v" }, ";", ":", "Command mode", { remap = true, silent = false })

-- Disable macros recording
map({ "n", "v" }, "q", "<nop>", nil)

-- Redo
map({ "n", "v" }, "U", cmd.redo, "Redo", { remap = true })

-- Folds Open/Close <ctrl>+arrow keys
map("n", "<c-up>", "zM", "Close all folds")
map("n", "<c-down>", "zR", "Open all folds")
map("n", "<c-left>", "zc", "Close fold")
map("n", "<c-right>", "zo", "Open fold")

-- Comment block
pcall(unmap, "v", "gc") -- clear default `gc` mapping
local operator_rhs = function()
  return require("vim._comment").operator()
end
map("v", "gc", operator_rhs, "BLock comment toggle", { expr = true })
map("v", "<c-\\>", operator_rhs, "BLock comment toggle", { expr = true })
-- Comment line
pcall(unmap, "n", "gcc") -- clear default `gcc` mapping
local line_rhs = function()
  return operator_rhs() .. "_"
end
map("n", "gc", line_rhs, "Line comment toggle", { expr = true })
map("n", "<c-\\>", line_rhs, "Line comment toggle", { expr = true })

-- Window focus <alt>+arrow  keys
map({ "n", "v" }, "<a-down>", "<c-w>j", "Go to lower window", { remap = true })
map({ "n", "v" }, "<a-left>", "<c-w>h", "Go to left window", { remap = true })
map({ "n", "v" }, "<a-right>", "<c-w>l", "Go to right window", { remap = true })
map({ "n", "v" }, "<a-up>", "<c-w>k", "Go to upper window", { remap = true })
-- Split
map({ "n", "v" }, "<leader>-", "<C-W>s", "Split window below", { remap = true })
map({ "n", "v" }, "<leader>|", "<C-W>v", "Split window right", { remap = true })
-- Close
map({ "n", "v" }, "<leader>wd", cmd.close, "Close window", { remap = true })

-- Buffers
map({ "n", "v" }, "<a-t>", function()
  cmd.enew()
  cmd.startinsert()
end, "New buffer")
map({ "n", "v" }, "<a-w>", function()
  Snacks.bufdelete()
end, "Delete buffer")
map({ "n", "v" }, "<a-{>", cmd.bprevious, "Prev buffer")
map({ "n", "v" }, "<a-}>", cmd.bnext, "Next buffer")

-- Move Lines
map("n", "<s-down>", "<cmd>move .+1<cr>==", "Move line down")
map("n", "<s-up>", "<cmd>move .-2<cr>==", "Move line up")
-- map("i", "<s-down>", "<cmd>move .+1<cr><esc>==gi", "Move line down")
-- map("i", "<s-up>", "<cmd>move .-2<cr><esc>==gi", "Move line up")
map("v", "<s-down>", ":<c-u>'<,'>move '>+1<cr>gv=gv", "Move block down")
map("v", "<s-up>", ":<c-u>'<,'>move '<-2<cr>gv=gv", "Move block up")

-- Quit all
map({ "n", "v" }, "<c-c><-c-c>", cmd.qall, "Quit all")
