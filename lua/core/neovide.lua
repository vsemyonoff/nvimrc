--- @class Core.Neovide
--- @field public setup fun()
local M = {}

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local defaults = {
  confirm_quit = true,
  cursor_animate_command_line = true,
  cursor_animate_in_insert_mode = false,
  cursor_animation_length = 0.06,
  cursor_antialiasing = false,
  cursor_smooth_blink = false,
  cursor_trail_size = 0.7,
  cursor_unfocused_outline_width = 0.125,
  cursor_vfx_mode = "",
  cursor_vfx_opacity = 200,
  cursor_vfx_particle_curl = 1,
  cursor_vfx_particle_density = 7,
  cursor_vfx_particle_lifetime = 1.2,
  cursor_vfx_particle_phase = 1.5,
  cursor_vfx_particle_speed = 10,
  detach_on_quit = "always_quit",
  floating_blur_amount_x = 2,
  floating_blur_amount_y = 2,
  floating_corner_radius = 0.4,
  floating_shadow = true,
  floating_z_height = 10,
  fullscreen = false,
  hide_mouse_when_typing = true,
  input_ime = false,
  light_angle_degrees = 45,
  light_radius = 5,
  padding_bottom = 0,
  padding_left = 10,
  padding_right = 10,
  padding_top = 10,
  position_animation_length = 0.05,
  profiler = false,
  refresh_rate = 60,
  refresh_rate_idle = 5,
  remember_window_size = true,
  scale_factor = 1,
  scroll_animation_far_lines = 1,
  scroll_animation_length = 0.1,
  show_border = false,
  text_contrast = 0.5,
  text_gamma = 0,
  theme = "auto",
  touch_deadzone = 6,
  touch_drag_timeout = 0.17,
  opacity = 1,
  underline_stroke_scale = 1,
}

local update_globals = function()
  local usercfg = vim.tbl_deep_extend("force", defaults, Core.config.ui.neovide or {}) or {}
  for key, val in pairs(usercfg) do
    vim.g["neovide_" .. key] = val
  end
end

M.setup = function()
  -- Reload globals on config updated event
  Core:on(Core.Signal.CoreSetupHook, update_globals)
  update_globals()
end

local function set_ime(args)
  if args.event:match("Enter$") then
    vim.g.neovide_input_ime = true
  else
    vim.g.neovide_input_ime = false
  end
end

local ime_input = augroup("CoreImeInput", { clear = true })
autocmd({ "InsertEnter", "InsertLeave" }, {
  pattern = "*",
  callback = set_ime,
  group = ime_input,
  desc = "Toggle `insert mode` IME input",
})
autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
  pattern = "[/\\?]",
  callback = set_ime,
  group = ime_input,
  desc = "Toggle `command line mode` IME input",
})

local map = Core.map
map("<A-+>", function()
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
end, "Increase font size")
map("<A-_>", function()
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
end, "Decrease font size")
map("<C-0>", function()
  vim.g.neovide_scale_factor = 1
end, "Normal font size")

return M
