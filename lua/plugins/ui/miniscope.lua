return {
  {
    "snacks.nvim",
    opts = {
      indent = {
        scope = { enabled = false },
      },
    },
  },
  {
    "mini.indentscope",
    optional = true,
    opts = {
      draw = {
        animation = function()
          return 5
        end,
      },
      options = { try_as_border = true },
      symbol = "▏",
    },
  },
}
