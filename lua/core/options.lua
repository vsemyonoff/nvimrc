-- local utils = require('utils')
local cmd = vim.cmd
local set = vim.opt

-- langmap
local ru =
    '№ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ'
local en =
    '#`qwertyuiop[]asdfghjkl\\;\'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>'

cmd 'syntax enable'
cmd 'filetype plugin indent on'

set.cindent = true
set.clipboard = { 'unnamed', 'unnamedplus' }
set.cursorline = true
set.expandtab = true
set.hidden = true
set.ignorecase = true
set.listchars = 'tab:▹▹,trail:·,extends:▸,precedes:◂,eol:↵,nbsp:▬'
set.langmap = string.format('%s;%s', ru, en)
set.matchpairs = { '(:)', '{:}', '[:]', '<:>' }
set.number = true
set.numberwidth = 4
set.relativenumber = true
set.sidescroll = 5
set.signcolumn = 'yes:1'
set.scrolloff = 8
set.shiftround = true
set.shiftwidth = 4
set.showmatch = true
set.showmode = false
set.softtabstop = 4
set.smartcase = true
set.smartindent = true
set.spelllang = { 'en', 'ru' }
set.splitbelow = true
set.splitright = true
set.tabstop = 4
set.termguicolors = true
set.wildmode = { 'longest', 'full' }
set.wrap = false
