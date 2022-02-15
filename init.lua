-- '~/.config/nvim/lua/main.lua' default setup entry point
local packerspec = 'packerspec'
local maincfg = 'main'
local loadcmd = string.format("lua require('utils').include('%s')", maincfg)
local utils = require('utils')
local include = utils.include
local stdpath = vim.fn.stdpath

utils.create_augroups({
    PackerUserSetup = {
        { "BufWritePost", packerspec .. ".lua", "source <afile> | PackerSync" },
        { "User"        , "PackerComplete"    , loadcmd                       },
    }
})

local meta = {
    -- Initially install Packer as optional, it will be moved to 'start'
    -- after first sync automatically
    path = stdpath('data') .. '/site/pack/packer/opt/packer.nvim',
    url = 'https://github.com/wbthomason/packer.nvim'
}

-- Will load lazy-loaders manually, so puth them in
-- /lua/loaders.lua (can be overriden in '/lua/packerspec.lua')
local function fix_compile_path(user_config)
    if not user_config.compile_path then
        user_config.compile_path = string.format("%s/lua/loaders.lua", stdpath('config'))
    end
end

local haspacker, packer = pcall(require, 'packer')
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
            meta.url,
            meta.path
        },
    },
    vim.schedule_wrap(function(code, _)
        handle:close()
        if code ~= 0 then
            error("[error]: packer setup failed ('git clone failed with code ".. code .."')")
        end
        vim.cmd('packadd packer.nvim')
        packer  = require('packer')
        local spec = require(packerspec)
        fix_compile_path(spec.config)
        packer.startup(spec)
        packer.sync()
    end))
else
    local spec = require(packerspec)
    fix_compile_path(spec.config)
    packer.startup(spec)
    include(maincfg)

    -- Compile packer's lazy-loaders
    local _, loaders, _ = utils.split_path(spec.config.compile_path)
    local hasloaders, _ = pcall(require, loaders)
    if not hasloaders then
        packer.compile()
    else
        require(loaders)
    end
end
