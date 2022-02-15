local M = {}

M.base_dir = "plugin"

function M.split_path(path)
  -- returns: { path, filename, extension }
  return path:match("(.-)([^\\/]-)%.?([^%.\\/]*)$")
end

function M.get_config(name)
    return string.format("%s/%s", M.base_dir, name)
end

function M.pkg_config(name)
    return string.format("require('utils').include('%s')", M.get_config(name))
end

function M.find_module(name)
    local config = vim.fn.stdpath('config')
    local path = string.format('%s/lua/?.lua;%s/lua/?/init.lua', config, config)
    local filename, _ = package.searchpath(name, path)
    return filename
end

function M.include(name)
    local filename = M.find_module(name)
    if not filename then
        error("[error]: module not found '" .. name .. "'")
    end
    local chunk = loadfile(filename)
    return chunk()
end

function M.map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.create_augroups(definitions)
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

return M
