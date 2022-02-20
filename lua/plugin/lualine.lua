require('lualine').setup {
    options = {
        theme = 'onedark',
        disabled_filetypes = { 'neo-tree' },
        section_separators = '',
        component_separators = '',
    },
    sections = {
        lualine_a = { { 'mode', fmt = function(str) return str:sub(1, 1) end } },
        lualine_b = { 'branch' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = {
            {
                'diagnostics',
                always_visible = true,
                sections = { 'error', 'warn' },
            },
        },
        lualine_y = { { 'filetype', icon_only = false } },
        lualine_z = { 'progress' },
    },
}
