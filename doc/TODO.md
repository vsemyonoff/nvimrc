# TODO

## File templates

To read a skeleton (template) file when opening a new file: >

```vim
  :autocmd BufNewFile  *.c      0r ~/vim/skeleton.c
  :autocmd BufNewFile  *.h      0r ~/vim/skeleton.h
  :autocmd BufNewFile  *.java   0r ~/vim/skeleton.java
```

To insert the current date and time in a "\*.html" file when writing it: >

```vim
  :autocmd BufWritePre,FileWritePre *.html   ks|call LastMod()|'s
  :fun LastMod()
  :  if line("$") > 20
  :    let l = 20
  :  else
  :    let l = line("$")
  :  endif
  :  exe "1," .. l .. "g/Last modified: /s/Last modified: .*/Last modified: " ..
  :  \ strftime("%Y %b %d")
  :endfun
```

```c++
  for(size_t i = 0; i < count; ++i) {
      std::cout << i << std::endl;
  }
```

You need to have a line "Last modified: <date time>" in the first 20 lines
of the file for this to work. Vim replaces <date time> (and anything in the
same line after it) with the current date and time. Explanation:
ks mark current position with mark 's'
call LastMod() call the LastMod() function to do the work
's return the cursor to the old position
The LastMod() function checks if the file is shorter than 20 lines, and then
uses the ":g" command to find lines that contain "Last modified: ". For those
lines the ":s" command is executed to replace the existing date with the
current one. The ":execute" command is used to be able to use an expression
for the ":g" and ":s" commands. The date is obtained with the strftime()
function. You can change its argument to get another date string.

## cmake

$<LOWER_CASE:$<CONFIG>>

## Telescope

LazyVim setup

## Picker

mini.pick
fzf

## LSP

Old bindings on_attach

## Map test

```lua
vim.cmd.hasmapto()
```

## File explorer

<https://github.com/stevearc/oil.nvim>

## Mini indent

Support folds
