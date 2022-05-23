local M = {}

local include = require('core/utils').include
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

M.setup = function()
    local ftDetectHandler = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
        local fname = vim.fn.expand("%:p:t")

        local present, handler = pcall(include, ('filetype/%s'):format(ft:lower()))
        if present then
            if type(handler.setup) == "function" then
                handler.setup(ft, fname)
            end
        end
    end

    local ftDetectGrp = augroup("FiletypeDetectGroup", { clear = true })
    autocmd("FileType", {
        callback = ftDetectHandler,
        group = ftDetectGrp,
        desc = "Run file type handler after detection",
    })

    local yankGrp = augroup("YankHighlight", { clear = true })
    autocmd("TextYankPost", {
        callback = function()
            vim.highlight.on_yank()
        end,
        group = yankGrp,
        desc = "Highlight yanked region",
    })

    local termGrp = augroup("TerminalGroup", { clear = true })
    autocmd("TermOpen", {
        command = "setlocal nonumber norelativenumber signcolumn=no",
        group = termGrp,
    })
    autocmd("TermOpen", { command = "startinsert", group = termGrp })

    local cursorGrp = augroup("CursorLine", { clear = true })
    autocmd("WinEnter", {
        callback = function()
            vim.opt.cursorline = true
        end,
        group = cursorGrp,
        desc = "Enable 'cursorline' for active window",
    })
    autocmd("WinLeave", {
        callback = function()
            vim.opt.cursorline = false
        end,
        group = cursorGrp,
        desc = "Disable 'cursorline' for inactive window",
    })

    local numbersMode = augroup("NumbersMode", { clear = true })
    autocmd("InsertEnter", {
        callback = function()
            vim.opt.relativenumber = false
        end,
        group = numbersMode,
        desc = "Show absolute line numbers in insert mode",
    })
    autocmd("InsertLeave", {
        callback = function()
            vim.opt.relativenumber = true
        end,
        group = numbersMode,
        desc = "Show relative line numbers in normal mode",
    })

    local autoHelpers = augroup("AutoHelpersGrp", { clear = true })
    autocmd("BufWritePre", {
        callback = function()
            local save = vim.fn.winsaveview()
            vim.cmd([[keeppatterns %s/\s\+$//e]])
            vim.fn.winrestview(save)
        end,
        group = autoHelpers,
        desc = "Trim whitespaces before save",
    })

    autocmd("BufReadPost", {
        callback = function()
            if vim.fn.line("'\"") and -- mark is present
            vim.fn.line("'\"") <= vim.fn.line("$") then
                vim.cmd("normal! g`\"")
            end
        end,
        group = autoHelpers,
        desc = "Restore cursor position",
    })
end

return M
