local utils = require('utils')
local nvim_lsp = require('lspconfig')
local common = utils.include('lang/common')

local rtpath = vim.split(package.path, ';')
table.insert(rtpath, "lua/?.lua")
table.insert(rtpath, "lua/?/init.lua")

local lualib = vim.api.nvim_get_runtime_file("", true)
lualib['/usr/share/awesome/lib'] = true

nvim_lsp.sumneko_lua.setup {
    cmd = { "/usr/bin/lua-language-server" },
    capabilities = common.capabilities,
    on_attach = common.on_attach,
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
}

nvim_lsp.efm.setup {
    init_options = { documentFormatting = true },
    filetypes = { 'lua' },
    -- LuaFormatter off
    on_attach = function(_, _)
        utils.bnmap('<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', { noremap = true })
    end,
    -- LuaFormatter on
    settings = {
        rootMarkers = { ".git/" },
        languages = { lua = { { formatCommand = "lua-format -i", formatStdin = true } } },
    },
}
