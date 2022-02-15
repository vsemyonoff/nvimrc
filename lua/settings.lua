--local utils = require('utils')

local cmd = vim.cmd
local set = vim.opt
local indent = 4

cmd 'syntax enable'
cmd 'filetype plugin indent on'

set.termguicolors = true
set.expandtab = true
set.shiftwidth = indent
set.smartindent = true
set.tabstop = indent
set.hidden = true
set.ignorecase = true
set.scrolloff = 4
set.shiftround = true
set.smartcase = true
set.splitbelow = true
set.splitright = true
set.wildmode = 'list:longest'
set.number = true
set.relativenumber = true
set.scrolloff = 8
set.cursorline = true
set.clipboard = 'unnamed,unnamedplus'

-- Highlight on yank
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

-- Auto format
vim.api.nvim_exec([[
augroup auto_fmt
    autocmd!
    autocmd BufWritePre *.py,*.lua undojoin | Neoformat
aug END
]], false)

vim.api.nvim_exec([[
augroup auto_spellcheck
    autocmd!
    autocmd BufNewFile,BufRead *.md setlocal spell
    autocmd BufNewFile,BufRead *.org setfiletype markdown
    autocmd BufNewFile,BufRead *.org setlocal spell
    autocmd BufNewFile,BufRead *.html setlocal ts=2 sw=2
    autocmd BufNewFile,BufRead *.js setlocal ts=2 sw=2
    autocmd BufNewFile,BufRead *.json setlocal syntax=off
augroup END
]], false)

vim.api.nvim_exec([[
augroup auto_term
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermOpen * startinsert
augroup END
]], false)

vim.api.nvim_exec([[
    fun! TrimWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun

    autocmd BufWritePre * :call TrimWhitespace()
]], false)

