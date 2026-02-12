-- Singleton guard
if _G.Core then
  return
end

-- Base class
local Utils = require("core.utils")

--- Configuration core class
--- @class Core : Utils
--- @field public Signal table<string, string>
--- @field public new fun() : Core
--- @field public setup fun(opts? : Config) : Core
--- @field public config Config
--- @field public debug boolean
local M = setmetatable({}, Utils)

local Enum = require("core.utils.enum")
M.Signal = Enum("CoreSetupHook", "VeryLazy")

--- Class constructor
--- @return Core
function M:new()
  --- @type Core
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
  -- GUI font
  vim.opt.guifont = Core.config.ui.font
  -- Color theme
  vim.cmd.colorscheme(Core.config.ui.theme)
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

local pretty_trace = require("lazy.core.util").pretty_trace
_G.dt = function(...)
  if Core.debug then
    pretty_trace(...)
  end
end

return M
