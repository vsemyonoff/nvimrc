--- Enum table constructor
--- @param ... string enumeration element names
--- @return table<string, string>
return function(...)
  local ret = {}
  for _, value in ipairs({ ... }) do
    value = type(value) == "string" and value or tostring(value)
    ret[value] = { value }
  end
  return ret
end
