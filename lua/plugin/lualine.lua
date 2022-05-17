local status = require('core/status')

require('lualine').setup {
    options = {
        globalstatus = true,
        disabled_filetypes = { 'NvimTree', 'packer', 'dashboard' },
        section_separators = '',
        component_separators = '',
    },

    sections = {
        lualine_a = { { 'mode', fmt = function(str) return str:sub(1, 1) end } },
        lualine_b = {
            'branch',
            {
                "diff",
                symbols = { added = " ", modified = "柳", removed = " " },
                padding = { left = 0, right = 1 },
            },
        },
        lualine_c = {
            { 'filetype', icon_only = true, padding = { left = 1, right = 0 } },
            { 'filename', path = 1 },
        },
        lualine_x = { status.lsp_progress, 'diagnostics', 'location' },
        lualine_y = { status.progress_bar },
        lualine_z = { 'fileformat' },
    },
}
