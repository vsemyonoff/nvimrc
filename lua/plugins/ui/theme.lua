local is_local = Core.config.ui.theme.url:sub(1, 1) == "/"
local url = is_local and nil or Core.config.ui.theme.url
local dir = is_local and Core.config.ui.theme.url or nil
local name = Core.config.ui.theme.name

return {
  {
    url,
    dir = dir,
    name = name,
    lazy = false,
    priority = 1000,
    opts = Core.config.ui.theme.opts,
  },
  {
    -- disable LazyVim theme handling
    "LazyVim",
    opts = {
      colorscheme = function() end,
    },
  },
}
