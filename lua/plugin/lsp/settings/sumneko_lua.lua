local include = require('core/utils').pkg_include

local rtpath = vim.split(package.path, ';')
table.insert(rtpath, "lua/?.lua")
table.insert(rtpath, "lua/?/init.lua")

local lualib = vim.api.nvim_get_runtime_file("", true)
lualib['/usr/share/awesome/lib'] = true

return {
    on_attach = function(client, bufnr)
        client.server_capabilities.documentRangeFormattingProvider = false
        client.server_capabilities.documentFormattingProvider = false
        include('lsp/on_attach').setup(client, bufnr)
    end,

    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',

                -- Setup your lua path
                path = rtpath,
            },
            diagnostics = {
                -- Get the language server to recognize some global
                globals = { 'vim', 'awesome', 'client', 'root', 'screen', 'tag' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = lualib,
            },
            --- telemetry = { enable = false },
        },
    },
}
