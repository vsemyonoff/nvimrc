--- Configuration manager class
--- @class Config
--- @field diagnostic DiagOpts
--- @field icons Icons
--- @field system SystemOpts
--- @field ui UiOpts
--- @field init fun()
local M = {}

--- @alias DiagOpts vim.diagnostic.Opts

--- Diagnostic messages severity level
--- @enum Severity
M.Severity = vim.diagnostic.severity

--- @class Icons
--- @field diagnostic table<Severity, string>
--- @field expander table<string, string>
--- @field git table<string, string>
local icons = {
  diagnostic = {
    [M.Severity.ERROR] = "",
    [M.Severity.WARN] = "",
    [M.Severity.INFO] = "",
    [M.Severity.HINT] = "",
  },
  expander = {
    collapsed = "",
    expanded = "",
  },
  git = {
    added = "",
    modified = "",
    removed = "",
    staged = "󰱒",
    unstaged = "󰄱",
  },
}

--- System options
--- @class SystemOpts
--- @field lang string
--- @field leader string
--- @field localleader string
--- @field tools table<string>
local system = {
  lang = vim.env.LANG or "C.UTF-8", -- System locale name
  leader = " ", -- Leader key
  localleader = ",", -- Local leader key
  tools = vim.empty_dict(), -- Tools to be installed by `Mason`
}

--- @class Bounds
--- @field max integer
--- @field min integer

--- @class FontOpts
--- @field name string
--- @field size integer
--- @field inc integer
--- @field bounds Bounds

--- @class ThemeOpts
--- @field name string
--- @field flavor string|nil
--- @field url string
--- @field opts table<any>

--- User interface options
--- @class UiOpts
--- @field font FontOpts
--- @field theme ThemeOpts
--- @field border_style string
--- @field nerd_font boolean
--- @field neovide table<any>

--- @type UiOpts
local ui = {
  theme = { name = "habamax", flavor = nil, url = "/usr/share/nvim/runtime/colors", opts = vim.empty_dict() },
  font = { name = "monospace", size = 10, inc = 1, bounds = { max = 18, min = 8 } },
  border_style = "rounded", -- none, single, double, rounded, solid, shadow
  nerd_font = false,
  neovide = vim.empty_dict(),
}

--- @type DiagOpts
local diagnostic = {
  float = {
    border = ui.border_style,
    focusable = false,
    header = "",
    prefix = "* ",
    source = "if_many",
    style = "minimal",
  },
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_text = {
    prefix = "* ",
    source = "if_many",
    spacing = 4, -- TODO: use tab setting
  },
}

--- Default options
--- @class Opts
--- @field diagnostic DiagOpts
--- @field icons Icons
--- @field system SystemOpts
--- @field ui UiOpts
local default = {
  diagnostic = diagnostic,
  icons = icons,
  system = system,
  ui = ui,
}

--- User options
--- @type Opts
local usercfg = nil

--- Override defaults with user options
function M.init()
  local ok, override = pcall(Core.include, "config.usercfg")
  usercfg = vim.tbl_deep_extend("force", default, ok and override or {})
end

M.init()

return setmetatable(M, {
  __index = function(_, key)
    return usercfg and usercfg[key] or vim.deepcopy(default[key])
  end,
})
