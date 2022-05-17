local pkg_include = require('core/utils').pkg_include
local include = require('core/utils').include
local lspcfg = require('lspconfig')
local config = include('config')

local extend = vim.tbl_deep_extend

pkg_include('lsp/installer').setup()
pkg_include('lsp/handlers').setup()

local servers = config.lsp.servers
for _, server in ipairs(servers) do
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

    local opts = {
        capabilities = extend("force", capabilities, lspcfg[server].capabilities or {}),
        on_attach = pkg_include('lsp/on_attach').setup,
    }

    -- Apply server settings if any
    local present, overrides = pcall(pkg_include, ('lsp/settings/%s'):format(server))
    if present then
        opts = extend("force", opts, overrides)
    end

    lspcfg[server].setup(opts)
end
