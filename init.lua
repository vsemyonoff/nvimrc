local utils = require('core/utils')
local include = utils.include
local config = include('config')
local stdpath = vim.fn.stdpath

local force_config = function()
    local border_style = config.ui.border_style or "rounded"

    local user_config = {
        auto_clean = true,
        auto_reload_compiled = true,
        compile_on_sync = true,
        compile_path = ("%s/lua/loaders.lua"):format(stdpath('config')),
        display = { prompt_border = border_style },
    }

    if config.packer.floating then
        local avail, packer_util = pcall(require, "packer/util")
        if avail then
            local display = {
                open_fn = function() return packer_util.float({
                    border = border_style,
                }) end,
            }
            user_config.display = vim.tbl_deep_extend("keep", user_config.display, display)
        end
    end

    return vim.tbl_deep_extend('keep', user_config, config.packer.user_config or {})
end

-- Start/restart packer
PackerStartup = function(packer)
    local spec = include(config.packer.spec)
    local user_config = force_config()

    packer.startup({ spec, config = user_config })

    return user_config
end

-- Start/restart main config
MainStartup = function()
    require('impatient')
    include(config.system.main)
    vim.cmd({ cmd = "doautocmd", args = { "User", "MainStartupComplete" } })
end

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
            error("[error]: packer setup failed ('git clone failed with code %s')"):format(code)
        end
        vim.cmd({ cmd = "packadd", args = { "packer.nvim" } })
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
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local packerUserSetup = augroup("PackerUserSetup", { clear = true })
autocmd("BufWritePost", {
    pattern = ("%s.lua"):format(config.packer.spec),
    callback = function()
        PackerStartup(packer)
        packer.sync()
    end,
    group = packerUserSetup,
    desc = "Sync packages on specification changes",
})
autocmd("User", {
    pattern = "PackerComplete",
    callback = MainStartup,
    group = packerUserSetup,
    desc = "Update configuration after packages sync",
})
