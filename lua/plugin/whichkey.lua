local include = require('core/utils').include

require('which-key').setup({
    plugins = { spelling = { enabled = true }, presets = { operators = false } },
    key_labels = {
        ["<BS>"] = "BS",
        ["<CR>"] = "RET",
        ["<Enter>"] = "RET",
        ["<Return>"] = "RET",
        ["<Esc>"] = "ESC",
        ["<Space>"] = "SPS",
        ["<Tab>"] = "TAB",
        -- Arrows
        ["<Down>"] = "🡇",
        ["<Left>"] = "🡄",
        ["<Right>"] = "🡆",
        ["<Up>"] = "🡅",
        -- Functional
        ["<F1>"] = "F1",
        ["<F2>"] = "F2",
        ["<F3>"] = "F3",
        ["<F4>"] = "F4",
        ["<F5>"] = "F5",
        ["<F6>"] = "F6",
        ["<F7>"] = "F7",
        ["<F8>"] = "F8",
        ["<F9>"] = "F9",
        ["<F10>"] = "F10",
        ["<F11>"] = "F11",
        ["<F12>"] = "F12",
        -- Other
        ["<Del>"] = "DEL",
        ["<End>"] = "END",
        ["<Home>"] = "HOME",
        ["<Insert>"] = "INS",
        ["<PageDown>"] = "PGDN",
        ["<PageUp>"] = "PGUP",
        -- Mouse
        ["<LeftMouse>"] = "LMB",
        ["<RightMouse>"] = "RMB",
        --
        ["<leader>"] = "LDR",
    },
    window = {
        border = include('config').ui.border_style or "rounded",
        padding = { 2, 2, 2, 2 },
    },
})
