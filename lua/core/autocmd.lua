local M = {}

local include = require('core/utils').include
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

M.setup = function()
    local ftDetectHandler = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
        local fname = vim.fn.expand("%:p:t")

        local present, handler = pcall(include, ('filetype/%s'):format(ft))
        if present then
            if type(handler.setup) == "function" then
                handler.setup(ft, fname)
            end
        end
    end

    -- Filetype detect
    local ftDetectGrp = augroup("FiletypeDetectGroup", { clear = true })
    autocmd("FileType", { callback = ftDetectHandler, group = ftDetectGrp })

    -- Highlight on yank
    local yankGrp = augroup("YankHighlight", { clear = true })
    autocmd("TextYankPost", {
        callback = function() vim.highlight.on_yank() end,
        group = yankGrp,
    })

    -- vim.api.nvim_exec([[
    --     augroup auto_spellcheck
    --         autocmd!
    --         autocmd BufNewFile,BufRead *.md setlocal spell
    --         autocmd BufNewFile,BufRead *.org setfiletype markdown
    --         autocmd BufNewFile,BufRead *.org setlocal spell
    --         autocmd BufNewFile,BufRead *.html setlocal ts=2 sw=2
    --         autocmd BufNewFile,BufRead *.js setlocal ts=2 sw=2
    --         autocmd BufNewFile,BufRead *.json setlocal syntax=off
    --     augroup END
    -- ]], false)

    local termGrp = augroup("TerminalGroup", { clear = true })
    autocmd("TermOpen", {
        command = "setlocal nonumber norelativenumber signcolumn=no",
        group = termGrp,
    })
    autocmd("TermOpen", { command = "startinsert", group = termGrp })

    vim.api.nvim_exec([[
        fun! TrimWhitespace()
            let l:save = winsaveview()
            keeppatterns %s/\s\+$//e
            call winrestview(l:save)
        endfun

        autocmd BufWritePre * :call TrimWhitespace()
    ]], false)

    -- Show cursor line only in active window
    local cursorGrp = augroup("CursorLine", { clear = true })
    autocmd("WinEnter", {
        callback = function() vim.opt.cursorline = true end,
        group = cursorGrp,
    })
    autocmd("WinLeave", {
        callback = function() vim.opt.cursorline = false end,
        group = cursorGrp,
    })

    -- Use relative & absolute line numbers in 'n' & 'i' modes respectively
    local numbersMode = augroup("NumbersMode", { clear = true })
    autocmd("InsertEnter", {
        callback = function() vim.opt.relativenumber = false end,
        group = numbersMode,
    })
    autocmd("InsertLeave", {
        callback = function() vim.opt.relativenumber = true end,
        group = numbersMode,
    })

    -- Go to last loc when opening a buffer
    autocmd("BufReadPost", {
        command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
    })
end

return M
