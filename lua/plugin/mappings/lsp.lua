local M = {}

local bnmap = require('core/utils').bnmap
local bvmap = require('core/utils').bvmap

M.setup = function(client, bufnr)
    require('which-key').register({
        l = {
            name = "LSP",
            d = { vim.diagnostic.open_float, "Hover diagnostic" },
            i = { "<cmd>LspInfo<cr>", "LSP information" },
            I = { "<cmd>LspInstallInfo<cr>", "LSP installer" },
        },
    }, { prefix = "<leader>", buffer = bufnr })

    if client.server_capabilities.hoverProvider then
        bnmap("K", vim.lsp.buf.hover, { desc = "Hover symbol details" })
    end

    if client.server_capabilities.codeActionProvider then
        bnmap("<leader>la", vim.lsp.buf.code_action, { desc = "LSP code action" })
    end

    if client.server_capabilities.renameProvider then
        bnmap("<leader>lr", vim.lsp.buf.rename, { desc = "Rename current symbol" })
    end

    if client.server_capabilities.declarationProvider then
        bnmap("gD", vim.lsp.buf.declaration, {
            desc = "Go to declaration of current symbol",
        })
    end

    if client.server_capabilities.definitionProvider then
        bnmap("gd", vim.lsp.buf.definition, {
            desc = "Show the definition of current symbol",
        })
    end

    if client.server_capabilities.implementationProvider then
        bnmap("gI", vim.lsp.buf.implementation, {
            desc = "Go to implementation of current symbol",
        })
    end

    if client.server_capabilities.referencesProvider then
        bnmap("gr", "<cmd>Trouble lsp_references<cr>", {
            desc = "References of current symbol",
        })
    end

    if client.server_capabilities.documentFormattingProvider then
        bnmap('<leader>lf', vim.lsp.buf.format, { desc = "Format buffer" })
    end

    if client.server_capabilities.documentRangeFormattingProvider then
        bvmap('<leader>lf', vim.lsp.buf.range_formatting, {
            desc = "Format selection",
        })
    end
end

return M
