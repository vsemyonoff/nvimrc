local include = require('core/utils').pkg_include
local common = include('lspconfig/common')
local lsp = require('lspconfig')

local servers = { "bashls", "clangd", "cmake", "jsonls", "tsserver", "vimls" }
for _, server in ipairs(servers) do
    lsp[server].setup {
        capabilities = common.capabilities,
        on_attach = common.on_attach,
        flags = { debounce_text_changes = 150 },
    }
end

-- Lua specific settings
include('lspconfig/lua')
