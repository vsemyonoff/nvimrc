local border = Core.config.ui.border_style

return {
  "blink.cmp",
  optional = true,
  opts = {
    keymap = { preset = "super-tab" },
    completion = {
      documentation = { auto_show = true, window = { border = border } },
      menu = { border = border },
      trigger = {
        show_on_keyword = false,
        show_on_trigger_character = false,
      },
    },
  },
}
