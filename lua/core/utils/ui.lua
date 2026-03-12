--- User interface tweaks
--- @class Ui
--- @field foldtext fun() : string
--- @field set_font fun(opts? : FontOpts)
--- @field set_theme fun(opts? : ThemeOpts)
--- @field setup fun(opts? : UiOpts)
local M = {}

-- Folded text format
function M.foldtext()
  local first, last, getline, trim = vim.v.foldstart, vim.v.foldend, vim.fn.getline, vim.fn.trim
  local text = "%s%s --[[ %d lines ]]-- %s"
  local indent = string.rep(" ", vim.fn.indent(first))
  local count = last - first
  return text:format(indent, trim(getline(first)), count, trim(getline(last)))
end

--- @param cfg? FontOpts
function M.set_font(cfg)
  cfg = cfg or Core.config.ui.font
  vim.opt.guifont = { cfg.name, (":h%d"):format(cfg.size) }
end

--- @param cfg? ThemeOpts
function M.set_theme(cfg)
  cfg = cfg or Core.config.ui.theme
  local name = cfg.name
  if cfg.flavor then
    name = name .. "-" .. cfg.flavor
  end
  -- Color theme
  vim.cmd.colorscheme(name)
end

--- Setup `Neovim` internal diagnostic behavior
--- @param opts? DiagOpts
function M.set_diagnostic(opts)
  -- Pretty diagnostic icons
  local opts_diag = opts or Core.config.diagnostic
  local icons = Core.config.icons.diagnostic
  local diag = vim.diagnostic

  if Core.config.ui.nerd_font then
    -- Change diagnostic symbols in the sign column (gutter)
    if type(opts_diag.signs) == "boolean" and opts_diag.signs then
      opts_diag.signs = { text = vim.empty_dict() }
      for severity, icon in pairs(icons) do
        local name = "DiagnosticSign" .. diag.severity[severity]:lower():gsub("^%l", string.upper)
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
        opts_diag.signs.text[severity] = icon
      end
    end
    -- Nice icons in diagnostic floats and virtual text
    local prefix = function(d)
      for severity, icon in pairs(icons) do
        if d.severity == severity then
          return icon .. " "
        end
      end
    end
    opts_diag.float.prefix = prefix
    opts_diag.virtual_text.prefix = prefix
  else
    for severity, _ in pairs(icons) do
      local name = "DiagnosticSign" .. diag.severity[severity]:lower():gsub("^%l", string.upper)
      pcall(vim.fn.sign_undefine, name)
    end
    if type(opts_diag.virtual_text.prefix) == "function" then
      opts_diag.virtual_text.prefix = "* "
    end
    if type(opts_diag.float.prefix) == "function" then
      opts_diag.float.prefix = "* "
    end
    if type(opts_diag.signs) == "table" then
      opts_diag.signs = true
    end
  end

  -- Apply settings
  vim.diagnostic.config(opts_diag)
end

--- @param amount integer
--- @param exact boolean
--- @param bounds Bounds
local function set_font_checked(amount, exact, bounds)
  vim.opt.guifont = string.gsub(vim.opt.guifont._value, ":h(%d+)", function(n)
    local size = n + amount
    if exact then
      size = amount
    end

    if size < bounds.min then
      size = bounds.min
    elseif size > bounds.max then
      size = bounds.max
    end

    return string.format(":h%d", size)
  end)
end

--- @param amount integer
--- @param exact? boolean
local function font_resize(amount, exact)
  local bounds = Core.config.ui.font.bounds
  set_font_checked(amount, exact or false, bounds)
end

--- Main setup
--- @param cfg? UiOpts
function M.setup(cfg)
  cfg = cfg or Core.config.ui
  local opts = cfg.font

  vim.api.nvim_create_user_command("GUIFontSizeUp", function(cmd)
    local increase_by = tonumber(cmd.args)
    if increase_by ~= nil then
      return font_resize(math.abs(increase_by))
    end
    return font_resize(opts.inc)
  end, { nargs = "?" })

  vim.api.nvim_create_user_command("GUIFontSizeDown", function(cmd)
    local decrease_by = tonumber(cmd.args)
    if decrease_by ~= nil then
      return font_resize(-math.abs(decrease_by))
    end
    return font_resize(-opts.inc)
  end, { nargs = "?" })

  vim.api.nvim_create_user_command("GUIFontSizeSet", function(cmd)
    local font_size = tonumber(cmd.args)
    if font_size ~= nil then
      return font_resize(font_size, true)
    end
    return font_resize(opts.size, true)
  end, { nargs = "?" })

  vim.api.nvim_create_user_command("GUIFontSizeChange", function(cmd)
    local change_by = tonumber(cmd.args)
    if change_by ~= nil then
      return font_resize(change_by)
    end
    return font_resize(opts.inc)
  end, { nargs = "?" })
end

return M
