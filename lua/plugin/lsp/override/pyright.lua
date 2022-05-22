local include = require('core/utils').pkg_include

return {
    on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = false
        include('lsp/on_attach').setup(client, bufnr)
    end,

    settings = { python = { analysis = { typeCheckingMode = "off" } } },
}
