local M = {}

M.base_dir = "plugin"

M.create_augroups = function(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup ' .. group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten { 'autocmd', def }, ' ')
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
    if not filename then
        error("[error]: module not found '" .. name .. "'")
    end
    return dofile(filename)
end

local _map_impl = function(mode, lhs, rhs, opts)
    local options = { noremap = false, silent = true }
    local buffer = false

    -- Parse options
    if opts then
        if opts.buffer then
            buffer = opts.buffer
            opts.buffer = nil
        end
        options = vim.tbl_extend('force', options, opts)
    end

    -- Apply mapping
    if buffer then
        vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, options)
    else
        vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    end
end

local _buf_map_impl = function(mode, lhs, rhs, opts)
    local options = { buffer = true }

    if opts then
        options = vim.tbl_extend('keep', options, opts)
    end

    _map_impl(mode, lhs, rhs, options)
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

-- Global
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

-- Buffer local
M.bmap = function(lhs, rhs, opts) _buf_map_impl('', lhs, rhs, opts) end
M.bnmap = function(lhs, rhs, opts) _buf_map_impl('n', lhs, rhs, opts) end
M.bmapi = function(lhs, rhs, opts) _buf_map_impl('!', lhs, rhs, opts) end
M.bimap = function(lhs, rhs, opts) _buf_map_impl('i', lhs, rhs, opts) end
M.bcmap = function(lhs, rhs, opts) _buf_map_impl('c', lhs, rhs, opts) end
M.bvmap = function(lhs, rhs, opts) _buf_map_impl('v', lhs, rhs, opts) end
M.bxmap = function(lhs, rhs, opts) _buf_map_impl('x', lhs, rhs, opts) end
M.bsmap = function(lhs, rhs, opts) _buf_map_impl('s', lhs, rhs, opts) end
M.bomap = function(lhs, rhs, opts) _buf_map_impl('o', lhs, rhs, opts) end
M.btmap = function(lhs, rhs, opts) _buf_map_impl('t', lhs, rhs, opts) end
M.blmap = function(lhs, rhs, opts) _buf_map_impl('l', lhs, rhs, opts) end

return M
