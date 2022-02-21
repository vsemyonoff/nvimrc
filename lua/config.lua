local stdpath = vim.fn.stdpath

local M = {
    packer = {
        setup = {
            path = string.format('%s/site/pack/packer/opt/packer.nvim',
                                 stdpath('data')),
            url = 'https://github.com/wbthomason/packer.nvim',
        },

        spec = 'plugin',
        user_config = {
            display = {
                open_fn = function()
                    return require('packer.util').float({ border = 'single' })
                end,
                prompt_border = 'double',
            },
        },
    },

    main = 'core', -- setup entry point
}

return M
