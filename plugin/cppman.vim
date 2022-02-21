function! s:CppMan()
    let old_isk = &iskeyword
    setl iskeyword+=:
    let str = expand("<cword>")
    let &l:iskeyword = old_isk
    execute 'Man ' . str
endfunction
command! CppMan :call s:CppMan()

augroup CppMan
    autocmd!
    autocmd FileType cpp nnoremap <buffer>K <cmd>CppMan<CR>
augroup END
