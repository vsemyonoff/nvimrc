local include = require('utils').include
local nvim_lsp = require('lspconfig')
local common = include('lang/common')

-- Common settings
local servers = { "bashls", "clangd", "cmake", "jsonls", "tsserver", "vimls" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = common.capabilities,
        on_attach = common.on_attach,
        -- init_options = {
        --     onlyAnalyzeProjectsWithOpenFiles = true,
        --     suggestFromUnimportedLibraries = false,
        --     closingLabels = true,
        -- };
    }
end

-- Lua specific settings
include('lang/lua')
