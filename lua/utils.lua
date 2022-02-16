local M = {}

M.base_dir = "plugin"

M.create_augroups = function(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup ' .. group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten {'autocmd', def}, ' ')
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command('augroup END')
    end
end

M.split_path = function(path)
    -- returns: { path, filename, extension }
    return path:match("(.-)([^\\/]-)%.?([^%.\\/]*)$")
end

local get_config = function(name)
    local cfg = string.format("%s/%s", M.base_dir, name)
    return cfg
end

M.pkg_config = function(name)
    local fmt = "require('utils').include('%s')"
    -- return string.format(fmt, get_config(name))
    return fmt:format(get_config(name))
end

M.find_module = function(name)
    local fmt = "%s/lua/?.lua;%s/lua/?/init.lua"
    local config = vim.fn.stdpath('config')
    local path = fmt:format(config, config)
    local filename, _ = package.searchpath(name, path)
    return filename
end

M.include = function(name)
    local filename = M.find_module(name)
    if not filename then error("[error]: module not found '" .. name .. "'") end
    return dofile(filename)
end

-- map helpers
local _map_impl = function(mode, lhs, rhs, opts)
    local options = {noremap = false, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- +----------------------------------------------------------------+
-- |        | Norm | Ins  | Cmd  | Vis  | Sel  | Oper | Term | Lang |
-- |--------+------+------+------+------+------+------+------+------+
-- |   map  | yes  |  -   |  -   | yes  | yes  | yes  |  -   |  -   |
-- |  nmap  | yes  |  -   |  -   |  -   |  -   |  -   |  -   |  -   |
-- |  mapi  |  -   | yes  | yes  |  -   |  -   |  -   |  -   |  -   |
-- |  imap  |  -   | yes  |  -   |  -   |  -   |  -   |  -   |  -   |
-- |  cmap  |  -   |  -   | yes  |  -   |  -   |  -   |  -   |  -   |
-- |  vmap  |  -   |  -   |  -   | yes  | yes  |  -   |  -   |  -   |
-- |  xmap  |  -   |  -   |  -   | yes  |  -   |  -   |  -   |  -   |
-- |  smap  |  -   |  -   |  -   |  -   | yes  |  -   |  -   |  -   |
-- |  omap  |  -   |  -   |  -   |  -   |  -   | yes  |  -   |  -   |
-- |  tmap  |  -   |  -   |  -   |  -   |  -   |  -   | yes  |  -   |
-- |  lmap  |  -   | yes  | yes  |  -   |  -   |  -   |  -   | yes  |
-- +----------------------------------------------------------------+

M.map = function(lhs, rhs, opts) _map_impl('', lhs, rhs, opts) end
M.nmap = function(lhs, rhs, opts) _map_impl('n', lhs, rhs, opts) end
M.mapi = function(lhs, rhs, opts) _map_impl('!', lhs, rhs, opts) end
M.imap = function(lhs, rhs, opts) _map_impl('i', lhs, rhs, opts) end
M.cmap = function(lhs, rhs, opts) _map_impl('c', lhs, rhs, opts) end
M.vmap = function(lhs, rhs, opts) _map_impl('v', lhs, rhs, opts) end
M.xmap = function(lhs, rhs, opts) _map_impl('x', lhs, rhs, opts) end
M.smap = function(lhs, rhs, opts) _map_impl('s', lhs, rhs, opts) end
M.omap = function(lhs, rhs, opts) _map_impl('o', lhs, rhs, opts) end
M.tmap = function(lhs, rhs, opts) _map_impl('t', lhs, rhs, opts) end
M.lmap = function(lhs, rhs, opts) _map_impl('l', lhs, rhs, opts) end

return M
