local augroup = function(name)
  return vim.api.nvim_create_augroup("Core" .. name, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd

autocmd("User", {
  pattern = "LazyReload",
  callback = function()
    vim.notify("Modules reloaded")
  end,
  group = augroup("lazy_reload"),
  desc = "Lazy modules reload handler",
})

autocmd("FileType", {
  callback = function(args)
    local present, handler = pcall(Core.include, ("filetype.%s"):format(args.match:lower()))
    if present then
      if type(handler.setup) == "function" then
        handler.setup(args)
      end
    end
  end,
  group = augroup("FiletypeDetect"),
  desc = "Run file type handler after detection",
})

local term_group = augroup("Terminal")
autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
  group = term_group,
  desc = "Disable UI elements in terminal",
})
autocmd("TermOpen", {
  callback = function()
    vim.cmd.startinsert()
  end,
  group = term_group,
  desc = "Start insert mode in new terminal",
})

local cursor_group = augroup("CursorLine")
autocmd("WinEnter", {
  callback = function()
    vim.opt_local.cursorline = true
  end,
  group = cursor_group,
  desc = "Enable 'cursorline' for active window",
})
autocmd("WinLeave", {
  callback = function()
    vim.opt_local.cursorline = false
  end,
  group = cursor_group,
  desc = "Disable 'cursorline' for inactive window",
})

local numbers_group = augroup("NumbersMode")
autocmd("InsertEnter", {
  callback = function(event)
    if Core.service_buf(event.buf) then
      return
    end
    vim.opt_local.relativenumber = false
  end,
  group = numbers_group,
  desc = "Show absolute line numbers in insert mode",
})
autocmd("InsertLeave", {
  callback = function(event)
    if Core.service_buf(event.buf) then
      return
    end
    vim.opt_local.relativenumber = true
  end,
  group = numbers_group,
  desc = "Show relative line numbers in normal mode",
})

local auto_helpers = augroup("AutoHelpers")
autocmd("BufWritePre", {
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
  group = auto_helpers,
  desc = "Auto create unexistent intermediate dirs when saving a file",
})
autocmd("FileType", {
  callback = function(event)
    if not Core.service_buf(event.buf) then
      return
    end
    vim.bo[event.buf].buflisted = false
    Core.bmap("<esc>", function()
      vim.cmd.close()
      pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
    end, "Close buffer")
  end,
  group = auto_helpers,
  desc = "Close service buffers with <esc>",
})
