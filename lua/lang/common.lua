local utils = require('utils')
local setlocal = vim.opt_local
local bnmap = function(lhs, rhs) utils.bnmap(lhs, rhs, { noremap = true }) end

local on_attach = function(client, _)
    require('lsp_signature').on_attach(client)

    setlocal.omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Mappings
    bnmap('gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
    bnmap('gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
    bnmap('K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
    bnmap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    bnmap('<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    bnmap('[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
    bnmap(']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    bnmap('<leader>law', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
    bnmap('<leader>lrw', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
    bnmap('<leader>llw', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
    bnmap('<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    bnmap('<leader>lrn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    bnmap('<leader>lrf', '<cmd>lua vim.lsp.buf.references()<CR>')
    bnmap('<leader>ld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    bnmap('<leader>ll', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
    bnmap('<leader>lca', '<cmd>lua vim.lsp.buf.code_action()<CR>')

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        bnmap('<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    elseif client.resolved_capabilities.document_range_formatting then
        bnmap('<leader>lf', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
            hi LspReferenceRead cterm=bold ctermbg=red guibg=LightGrey
            hi LspReferenceText cterm=bold ctermbg=red guibg=LightGrey
            hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightGrey
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]], false)
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Code actions
capabilities.textDocument.codeAction = {
    -- dynamicRegistration = true
    dynamicRegistration = false,
    codeActionLiteralSupport = {
        codeActionKind = {
            valueSet = (function()
                local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
                table.sort(res)
                return res
            end)(),
        },
    },
}

-- capabilities.textDocument.completion.completionItem.snippetSupport = true;

local M = { on_attach = on_attach, capabilities = capabilities }

return M
