local M = {}

M.base_dir = "plugin"

M.basename = function(path)
    local name = string.gsub(path, "(.*/)(.*)", "%2")
    return name
end

M.split_path = function(path)
    -- returns: { path, filename, extension }
    return path:match("(.-)([^\\/]-)%.?([^%.\\/]*)$")
end

local get_config = function(name) return ("%s/%s"):format(M.base_dir, name) end

M.pkg_config = function(name)
    local fmt = "require('core/utils').include('%s')"
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

M.pkg_include = function(name) return M.include(get_config(name)) end

local _map_impl = function(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }

    -- Parse options
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end

    -- Apply mapping
    vim.keymap.set(mode, lhs, rhs, options)
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
