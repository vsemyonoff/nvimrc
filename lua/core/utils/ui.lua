--- User interface tweaks
--- @class Ui
--- @field setup fun(opts? : Opts)
local M = {}

-- Folded text format
function M.foldtext()
  local first, last, getline, trim = vim.v.foldstart, vim.v.foldend, vim.fn.getline, vim.fn.trim
  local text = "%s%s --[[ %d lines ]]-- %s"
  local indent = string.rep(" ", vim.fn.indent(first))
  local count = last - first
  return text:format(indent, trim(getline(first)), count, trim(getline(last)))
end

--- Setup `Neovim` internal diagnostic behavior
--- @param opts? DiagOpts
local function setup_diagnostic(opts)
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

--- Main setup
--- @param cfg? Config
function M.setup(cfg)
  local opts = cfg and cfg.diagnostic or nil
  setup_diagnostic(opts)
end

return M
