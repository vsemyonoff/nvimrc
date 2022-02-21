local include = require('core/utils').pkg_include
local lsp = require('lspconfig')
local common = include('lspconfig/common')

local rtpath = vim.split(package.path, ';')
table.insert(rtpath, "lua/?.lua")
table.insert(rtpath, "lua/?/init.lua")

local lualib = vim.api.nvim_get_runtime_file("", true)
lualib['/usr/share/awesome/lib'] = true

lsp.sumneko_lua.setup {
    cmd = { "/usr/bin/lua-language-server" },
    capabilities = common.capabilities,
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        common.on_attach(client, bufnr)
    end,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                -- Setup your lua path
                path = rtpath,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim', 'awesome', 'client', 'root', 'screen', 'tag' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = lualib,
            },
            telemetry = { enable = false },
        },
    },
    flags = { debounce_text_changes = 150 },
}

lsp.efm.setup {
    init_options = { documentFormatting = true },
    filetypes = { 'lua' },
    -- LuaFormatter off
    on_attach = function(_, _)
        require('core/utils').bnmap('<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    end,
    -- LuaFormatter on
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            lua = {
                { formatCommand = "lua-format --in-place", formatStdin = true },
            },
        },
    },
    flags = { debounce_text_changes = 150 },
}
