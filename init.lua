local utils = require('core/utils')
local include = utils.include
local config = include('config')
local stdpath = vim.fn.stdpath

local packer_config = function()
    local user_config = {
        auto_clean = true,
        auto_reload_compiled = true,
        compile_on_sync = true,
        compile_path = string.format("%s/lua/loaders.lua", stdpath('config')),
    }

    return vim.tbl_deep_extend('keep', user_config,
                               config.packer.user_config or {})
end

-- Start/restart packer
PackerStartup = function(packer)
    local user_config = packer_config()
    local spec = include(config.packer.spec)
    packer.startup({ spec, config = user_config })
    return user_config
end

-- Start/restart main config
MainStartup = function() include(config.main) end

-- Install/configure Packer
local haspacker, packer = pcall(require, 'packer')
if not haspacker then
    if vim.fn.executable('git') ~= 1 then
        error("[error]: packer setup failed ('git not installed')")
    end

    local setup = config.packer.setup

    local handle
    handle = vim.loop.spawn('git', {
        args = { 'clone', '--depth', '1', setup.url, setup.path },
    }, vim.schedule_wrap(function(code, _)
        handle:close()
        if code ~= 0 then
            error("[error]: packer setup failed ('git clone failed with code "
                      .. code .. "')")
        end
        vim.cmd('packadd packer.nvim')
        packer = require('packer')
        PackerStartup(packer)
        packer.sync()
    end))
else
    local user_config = PackerStartup(packer)
    MainStartup()

    -- Compile packer's lazy-loaders
    local _, loaders, _ = utils.split_path(user_config.compile_path)
    local hasloaders, _ = pcall(include, loaders)
    if not hasloaders then
        packer.compile()
    end
end

-- Packer related autocommands
local aucmd = {}
aucmd.resync_packer = [[lua
    local packer = require('packer')
    PackerStartup(packer)
    packer.sync()
]]

aucmd.reload_main = [[lua
    MainStartup()
]]

utils.create_augroups({
    PackerUserSetup = {
        { "BufWritePost", config.packer.spec .. ".lua", aucmd.resync_packer },
        {
            "FileType",
            "packer",
            "setlocal nonumber norelativenumber signcolumn=no",
        },
        { "User", "PackerComplete", aucmd.reload_main },
    },
})
