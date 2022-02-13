local M = {}

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

function M.get_config(name)
    local config_name = string.format('plugin/%s', name)
    local hasconfig, config = pcall(require, config_name)

    if not hasconfig then
        print(string.format("[warning]: config '%s' not found", config))
    end

    return (hasconfig and config or nil)
end

function M.opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
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
