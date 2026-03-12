local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("core"):new():setup()
Core.debug = true

require("lazy").setup({
  lockfile = vim.fn.stdpath("config") .. "/versions.json",
  defaults = { lazy = false, version = false },
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins" },
  },
  --- @type table<any>
  dev = {
    path = "~/Sources",
    patterns = {}, -- For example {"folke"} to use local plugin version
    fallback = false, -- Fallback to git when local plugin doesn't exist
  },
  install = { colorscheme = { Core.config.ui.theme.name, "habamax" } },
  checker = { enabled = true, notify = false },
  change_detection = {
    enabled = true,
    notify = false,
  },
  ui = {
    border = Core.config.ui.border_style,
    title = " Lazy Plgugin Mnager ",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
