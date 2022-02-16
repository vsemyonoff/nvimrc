local utils = require('utils')
local include = utils.include
local stdpath = vim.fn.stdpath

-- '/lua/packerspec.lua' default packer spec file
local packerspec = 'packerspec'

-- '/lua/main.lua' default setup entry point
local maincfg = 'main'

-- Force some settings to ensure that all works as expected
local force_user_config = function(user_config)
    if not user_config.compile_path then
        -- Will load lazy-loaders manually, so puth them in
        -- /lua/loaders.lua (can be overriden in 'packerspec')
        local new_path = string.format("%s/lua/loaders.lua", stdpath('config'))
        user_config.compile_path = new_path
    end
    user_config.auto_reload_compiled = true
    user_config.compile_on_sync = true
end

-- Start/ReStart Packer helper
PackerStartup = function(packer, spec)
    force_user_config(spec.config)
    packer.startup(spec)
end

-- Install/configure Packer
local haspacker, packer = pcall(require, 'packer')
if not haspacker then
    if vim.fn.executable('git') ~= 1 then
        error("[error]: packer setup failed ('git not installed')")
    end

    local setup = {
        -- Install Packer as optional to allow 'packadd' usage, it will be
        -- moved to 'start' after first sync automatically
        path = stdpath('data') .. '/site/pack/packer/opt/packer.nvim',
        url = 'https://github.com/wbthomason/packer.nvim'
    }

    local handle
    handle = vim.loop.spawn('git', {
        args = {'clone', '--depth', '1', setup.url, setup.path}
    }, vim.schedule_wrap(function(code, _)
        handle:close()
        if code ~= 0 then
            error(
                "[error]: packer setup failed ('git clone failed with code " ..
                    code .. "')")
        end
        vim.cmd('packadd packer.nvim')
        packer = require('packer')
        PackerStartup(packer, include(packerspec))
        packer.sync()
    end))
else
    local spec = include(packerspec)
    PackerStartup(packer, spec)
    include(maincfg)

    -- Compile packer's lazy-loaders
    local _, loaders, _ = utils.split_path(spec.config.compile_path)
    local hasloaders, _ = pcall(include, loaders)
    if not hasloaders then
        packer.compile()
    else
        include(loaders)
    end
end

-- Packer related autocommands
local aucmd = {}
aucmd.resync_packer = string.format([[lua
    local spec = require('utils').include('%s')
    local packer = require('packer')
    PackerStartup(packer, spec)
    packer.sync()
]], packerspec)

aucmd.reload_main = string.format([[lua
    require('utils').include('%s')
]], maincfg)

utils.create_augroups({
    PackerUserSetup = {
        {"BufWritePost", packerspec .. ".lua", aucmd.resync_packer},
        {"User", "PackerComplete", aucmd.reload_main}
    }
})
