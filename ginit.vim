" Enable Mouse
set mouse=a

if exists(':GuiFont')
    " Set Editor Font
    let s:fontName = "RobotoMono Nerd Font"
    let s:fontSizeDefault = 11
    let s:fontSize = s:fontSizeDefault

    :execute "GuiFont! " . s:fontName . ":h" . s:fontSize

    function! AdjustFontSize(amount)
        let s:fontSize = s:fontSize + a:amount
        :execute "GuiFont! " . s:fontName . ":h" . s:fontSize
    endfunction

    noremap <silent><C-S-Up> :call AdjustFontSize(1)<CR>
    noremap <silent><C-S-Down> :call AdjustFontSize(-1)<CR>

    inoremap <silent><C-S-Up> <Esc>:call AdjustFontSize(1)<CR>a
    inoremap <silent><C-S-Down> <Esc>:call AdjustFontSize(-1)<CR>a
endif

" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

if exists(':GuiScrollBar')
    GuiScrollBar 0
endif

if exists('*GuiRenderLigatures')
    GuiRenderLigatures 1
endif

if exists('*GuiShowContextMenu')
    nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
    inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
    vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
endif
