local api, cmd, opt, uv = vim.api, vim.cmd, vim.opt_local, vim.uv or vim.loop
local augroup = function(name)
  return api.nvim_create_augroup("Core" .. name, { clear = true })
end
local autocmd = api.nvim_create_autocmd

-- Debug
-- autocmd("User", {
--   pattern = "LazyReload",
--   callback = function()
--     dt("Modules reloaded")
--   end,
--   group = augroup("lazy_reload"),
--   desc = "Lazy modules reload handler",
-- })

autocmd("FileType", {
  callback = function(args)
    local present, handler = pcall(Core.include, ("filetype.%s"):format(args.match:lower()))
    if present then
      if type(handler.setup) == "function" then
        handler.setup(args)
        dt("match detected")
      end
    end
  end,
  group = augroup("FiletypeDetect"),
  desc = "Run file type handler after detection",
})

local term_group = augroup("Terminal")
autocmd("TermOpen", {
  callback = function()
    opt.number = false
    opt.relativenumber = false
    opt.signcolumn = "no"
  end,
  group = term_group,
  desc = "Disable UI elements in terminal",
})
autocmd("TermOpen", {
  callback = function()
    cmd.startinsert()
  end,
  group = term_group,
  desc = "Start insert mode in new terminal",
})

local cursor_group = augroup("CursorLine")
autocmd("WinEnter", {
  callback = function()
    opt.cursorline = true
  end,
  group = cursor_group,
  desc = "Enable 'cursorline' for active window",
})
autocmd("WinLeave", {
  callback = function()
    opt.cursorline = false
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
    opt.relativenumber = false
  end,
  group = numbers_group,
  desc = "Show absolute line numbers in insert mode",
})
autocmd("InsertLeave", {
  callback = function(event)
    if Core.service_buf(event.buf) then
      return
    end
    opt.relativenumber = true
  end,
  group = numbers_group,
  desc = "Show relative line numbers in normal mode",
})

local auto_helpers = augroup("AutoHelpers")
autocmd("BufWritePre", {
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
  group = auto_helpers,
  desc = "Trim trailing whitespaces before save",
})
autocmd("BufWritePre", {
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = uv.fs_realpath(event.match) or event.match
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
      if #api.nvim_tabpage_list_wins(0) > 1 then
        cmd.close()
      end
      pcall(api.nvim_buf_delete, event.buf, { force = true })
    end, "Close service buffer")
  end,
  group = auto_helpers,
  desc = "Close service buffers with <esc>",
})
