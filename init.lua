local spec = {
    path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim',
    url = 'https://github.com/wbthomason/packer.nvim'
}

local utils = require('utils')
utils.create_augroups({
    PackerUserSetup = {
        { "BufWritePost", "packerspec.lua"       , "source <afile> | PackerSync"     },
        { "User"        , "PackerCompileDone"    , "source plugin/packer.lua"        },
        { "User"        , "PackerComplete ++once", "lua require('config')"           },
    }
})

local haspacker, packer = pcall(require, 'packer')
local packerspec = utils.get_config('packerspec')

if not haspacker then
    if vim.fn.executable('git') ~= 1 then
        error("[error]: packer setup failed ('git not installed')")
    end

    local handle
    handle = vim.loop.spawn(
    'git',
    {
        args = {
            'clone',
            '--depth', '1',
            spec.url,
            spec.path
        },
    },
    vim.schedule_wrap(function(code, _)
        handle:close()
        if code ~= 0 then
            error("[error]: packer setup failed ('git clone failed with code ".. code .."')")
        end
        vim.cmd('packadd packer.nvim')
        packer  = require('packer')
        packer.startup(packerspec)
        packer.sync()
    end))
else
    packer.startup(packerspec)
    require('config')
end

-- Compile loadable packer module
if vim.fn.empty(vim.fn.glob(packerspec['config']['compile_path'])) > 0 then
    packer.compile()
end
