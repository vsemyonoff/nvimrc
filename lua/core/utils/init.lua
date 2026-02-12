-- Base class
local Event = require("core.utils.event")

--- Utilities class
--- @class Utils : Event
--- @field ui Ui
local M = setmetatable(require("core.utils.bind"), Event)

--- Constructor
--- @return Utils
function M:new()
  --- @type Utils
  local instance = setmetatable(Event:new(), self)
  self.__index = self

  instance.ui = require("core.utils.ui")

  return instance
end

--- Perform class setup
function M:setup()
  local LazyUtil = require("lazy.core.util")

  --- Override the default title for notifications.
  for _, level in ipairs({ "info", "warn", "error" }) do
    M[level] = function(msg, opts)
      opts = opts or {}
      opts.title = opts.title or "Core"
      return LazyUtil[level](msg, opts)
    end
  end

  self.ui.setup()
end

--- Test string is empty
--- @param str string string to test
--- @return boolean
function M.empty(str)
  return str == nil or str == ""
end

--- Test buufer is service or not
--- @param bufnr integer buffer number to test
--- @return boolean
function M.service_buf(bufnr)
  return not M.empty(vim.bo[bufnr].buftype)
end

--- Find module by name
--- @param name string moule name
--- @return string?
function M.find_module(name)
  local fmt = "%s/lua/?.lua;%s/lua/?/init.lua"
  local conf_path = vim.fn.stdpath("config")
  local path = fmt:format(conf_path, conf_path)
  local filename, _ = package.searchpath(name, path)
  return filename
end

--- Execute module by name. Reloads module on every call.
--- Useful for config files reloading.
--- @param name string module name
--- @return any
function M.include(name)
  local filename = M.find_module(name)
  if not filename then
    error(("[error]: module not found '%s'"):format(name))
  end
  return dofile(filename)
end

return M

-- vim: ts=2 sts=2 sw=2 et
