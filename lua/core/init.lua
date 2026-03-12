-- Singleton guard
if _G.Core then
  return
end

-- Base class
local Utils = require("core.utils")

--- Configuration core class
--- @class Core : Utils
--- @field public Signal table<string, string>
--- @field public new fun(self) : Core
--- @field public setup fun(self) : Core
--- @field public config Config
--- @field public debug boolean
--- @field public bind fun(any)
--- @field public lbind fun(any)
local M = setmetatable({}, Utils)

local Enum = require("core.utils.enum")
M.Signal = Enum("CoreSetupHook")

--- Class constructor
--- @return Core|Utils|Event
function M:new()
  --- @type Core|Utils|Event
  local instance = setmetatable(Utils:new(), self)
  self.__index = self

  _G.Core = instance

  instance.config = require("core.config")
  instance.debug = false

  return instance
end

--- Setup core components
function M:setup()
  Utils.setup(self)
  self.config.init()

  -- Set system language
  vim.cmd.language(self.config.system.lang)

  self:emit(self.Signal.CoreSetupHook)

  return self
end

--- Restart core setup on user config changes
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = ("%s/lua/config/usercfg.lua"):format(vim.fn.stdpath("config")),
  callback = function()
    Core:setup()
  end,
  group = vim.api.nvim_create_augroup("CoreSetup", { clear = true }),
  desc = "Reinit core once the user config file was changed",
})

local ui_setup = function()
  -- Update UI
  Core.ui.set_font()
  Core.ui.set_theme()
  Core.ui.set_diagnostic()
  -- Debug
  dt("Theme: " .. vim.g.colors_name)
end

-- UI Setup
vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    if vim.v.event.chan and vim.g.neovide then
      require("core.neovide").setup()
    end
    Core:on(Core.Signal.CoreSetupHook, ui_setup)
    ui_setup()
  end,
  group = vim.api.nvim_create_augroup("CoreUiSetup", { clear = true }),
  desc = "Core UI settings",
})

---@param opts? {level?: number}
local function pretty_trace(opts)
  opts = opts or {}
  -- local Config = require("lazy.core.config")
  local trace = {}
  local level = opts.level or 2
  while true do
    local info = debug.getinfo(level, "Sln")
    if not info then
      break
    end
    if info.what ~= "C" and (Core.debug or not info.source:find("lazy.nvim")) then
      local source = info.source:sub(2)
      -- if source:find(Config.options.root, 1, true) == 1 then
      --   source = source:sub(#Config.options.root + 1)
      -- end
      source = vim.fn.fnamemodify(source, ":p:~:.") --[[@as string]]
      local line = "  - " .. source .. ":" .. info.currentline
      if info.name then
        line = line .. " _in_ **" .. info.name .. "**"
      end
      table.insert(trace, line)
    end
    level = level + 1
  end
  return #trace > 0 and ("\n\n# stacktrace:\n" .. table.concat(trace, "\n")) or ""
end

local function notify(msg, opts)
  if vim.in_fast_event() then
    return vim.schedule(function()
      notify(msg, opts)
    end)
  end

  opts = opts or {}
  if type(msg) == "table" then
    msg = table.concat(
      vim.tbl_filter(function(line)
        return line or false
      end, msg),
      "\n"
    )
  end

  if opts.stacktrace then
    msg = msg .. pretty_trace({ level = opts.stacklevel or 2 })
  end

  local lang = opts.lang or "markdown"
  local n = opts.once and vim.notify_once or vim.notify
  n(msg, opts.level or vim.log.levels.INFO, {
    ft = lang,
    on_open = function(win)
      local ok = pcall(function()
        vim.treesitter.language.add("markdown")
      end)
      if not ok then
        pcall(require, "nvim-treesitter")
      end
      vim.wo[win].conceallevel = 3
      vim.wo[win].concealcursor = ""
      vim.wo[win].spell = false
      local buf = vim.api.nvim_win_get_buf(win)
      if not pcall(vim.treesitter.start, buf, lang) then
        vim.bo[buf].filetype = lang
        vim.bo[buf].syntax = lang
      end
    end,
    title = opts.title or "lazy.nvim",
  })
end

local function debug(msg, opts)
  if not Core.debug then
    return
  end
  opts = opts or {}
  if opts.title then
    opts.title = "lazy.nvim: " .. opts.title
  end
  if type(msg) == "string" then
    notify(msg, opts)
  else
    opts.lang = "lua"
    notify(vim.inspect(msg), opts)
  end
end

_G.dt = function(...)
  debug(...)
end

return M
