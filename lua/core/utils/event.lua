--- Event emitter class (stolen from `Mason` souce code)
--- @class Event
--- @field private __event_handlers table<any, table<fun(...: any)>>
--- @field private __event_handlers_once table<any, table<fun(...: any)>>
local M = {}

--- Constructor
--- @return Event
function M:new()
  local instance = setmetatable({}, self)
  self.__index = self

  instance.__event_handlers = {}
  instance.__event_handlers_once = {}

  return instance
end

-- Safely call handler function
local function call_handler(event, handler, ...)
  local ok, err = pcall(handler, ...)
  if not ok then
    vim.schedule(function()
      vim.api.nvim_echo({ { ("[%s]: %s\n"):format(event, err), "ErrorMsg" } }, true, {})
    end)
  end
end

--- Fire event
--- @param event any event specifier
--- @param ... any handler arguments
function M:emit(event, ...)
  dt(("[%s]: "):format(event), ...)
  if self.__event_handlers[event] then
    for handler in pairs(self.__event_handlers[event]) do
      call_handler(event, handler, ...)
    end
  end
  if self.__event_handlers_once[event] then
    for handler in pairs(self.__event_handlers_once[event]) do
      call_handler(event, handler, ...)
      self.__event_handlers_once[event][handler] = nil
    end
  end
  return self
end

--- Connect event handler
--- @param event any event specifier
--- @param handler fun(...: any) handler function
function M:on(event, handler)
  if not self.__event_handlers[event] then
    self.__event_handlers[event] = {}
  end
  self.__event_handlers[event][handler] = handler
  return self
end

--- Connect one-time event handler. Disconnects on first fire.
--- @param event any event specifier
--- @param handler fun(...: any) handler function
function M:once(event, handler)
  if not self.__event_handlers_once[event] then
    self.__event_handlers_once[event] = {}
  end
  self.__event_handlers_once[event][handler] = handler
  return self
end

--- Disconnect event handler
--- @param event any event specifier
--- @param handler fun(...: any) handler function
function M:off(event, handler)
  if self.__event_handlers[event] then
    self.__event_handlers[event][handler] = nil
  end
  if self.__event_handlers_once[event] then
    self.__event_handlers_once[event][handler] = nil
  end
  return self
end

return M
