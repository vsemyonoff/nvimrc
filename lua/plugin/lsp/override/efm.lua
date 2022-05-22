local include = require('core/utils').pkg_include

return {
    init_options = { documentFormatting = true, documentRangeFormatting = false },

    filetypes = { 'lua' },

    on_attach = function(_, bufnr)
        include('lsp/on_attach').lsp_format_on_save(bufnr)

        local bnmap = require('core/utils').bnmap
        bnmap('<leader>lf', vim.lsp.buf.format, { desc = "Format buffer (EFM)" })
    end,

    settings = {
        rootMarkers = { ".git/" },
        languages = {
            lua = {
                { formatCommand = "lua-format --in-place", formatStdin = true },
            },
        },
    },
}
