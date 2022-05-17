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

    noremap <silent><C-up> <cmd>call AdjustFontSize(1)<cr>
    noremap <silent><C-down> <cmd>call AdjustFontSize(-1)<cr>
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
    noremap <silent><rightmouse> <cmd>call GuiShowContextMenu()<cr>
endif
