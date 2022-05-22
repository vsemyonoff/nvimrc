local M = {}

local include = require('core/utils').pkg_include
-- local include = require('core/utils').include
-- local border_style = include('config').ui.border_style or "rounded"
local lspcfg = require('lspconfig')

local usercmd = vim.api.nvim_buf_create_user_command
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local set = vim.opt_local

local lsp_highlight_document = function(bufnr)
    local lsp_hl = augroup("lsp_document_highlight", { clear = true })
    autocmd("CursorHold", {
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
        group = lsp_hl,
    })
    autocmd("CursorMoved", {
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
        group = lsp_hl,
    })
end

M.lsp_format_on_save = function(bufnr)
    local lsp_fmt = augroup("lsp_document_format", { clear = true })
    autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
        group = lsp_fmt,
    })

    usercmd(bufnr, "Format", vim.lsp.buf.format, { desc = "Format file with LSP" })
    set.formatexpr = "v:lua.vim.lsp.formatexpr()"
end

M.setup = function(client, bufnr)
    -- local win = require('lspconfig/ui/windows')
    -- local _default_opts = win.default_opts
    --
    -- win.default_opts = function(options)
    --     local opts = _default_opts(options)
    --     opts.border = border_style
    --     return opts
    -- end
    --

    -- Run default server callback if any
    local default_cb = lspcfg[client.name].on_attach
    if default_cb then
        default_cb(client, bufnr)
    end

    local aerial_avail, aerial = pcall(require, 'aerial')
    if aerial_avail then
        aerial.on_attach(client, bufnr)
    end

    if client.server_capabilities.completionProvider then
        set.omnifunc = 'v:lua.vim.lsp.omnifunc'
    end

    if client.server_capabilities.definitionProvider then
        set.tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    if client.server_capabilities.documentFormattingProvider then
        M.lsp_format_on_save(bufnr)
    end

    if client.server_capabilities.documentHighlightProvider then
        lsp_highlight_document(bufnr)
    end

    include('mappings/lsp').setup(client, bufnr)
end

return M
