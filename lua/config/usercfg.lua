return {
  diagnostic = { update_in_insert = true },

  system = {
    lang = "en_US.UTF-8",
    localleader = " ",
  },

  ui = {
    -- font = { name = "RobotoMono Nerd Font",     size = 11 },
    -- font = { name = "CodeNewRoman Nerd Font",   size = 11 },
    font = { name = "JetBrainsMono Nerd Font Mono", size = 12 },
    nerd_font = true,
    theme = {
      name = "catppuccin",
      -- flavor = "mocha",
      url = "catppuccin/nvim",
      opts = {
        dim_inactive = { enabled = true },
      },
    },
  },
}
