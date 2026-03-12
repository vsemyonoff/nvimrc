return {
  "mason.nvim",
  optional = true,
  opts = {
    ui = {
      border = Core.config.ui.border_style,
      width = 0.8,
      height = 0.8,
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
}
