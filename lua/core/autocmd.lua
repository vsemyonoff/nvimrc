-- Highlight on yank
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

-- Auto format
vim.api.nvim_exec([[
    augroup auto_fmt
        autocmd!
        autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync()
    aug END
]], false)

vim.api.nvim_exec([[
    augroup help
        autocmd!
        autocmd FileType help nnoremap <Esc> <cmd>helpclose<cr>
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
