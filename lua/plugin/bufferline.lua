require('bufferline').setup {
    options = {
        always_show_bufferline = false,
        show_close_icon = false,
        offsets = {
            {
                filetype = 'NvimTree',
                text = 'File Explorer',
                text_align = 'center',
            },
            {
                filetype = 'packer',
                text = 'Package manager',
                text_align = 'center',
            },
        },
    },
}
