local M = {}

local include = require('core/utils').include
local leader = include('config').system.leader or " "
local g, set = vim.g, vim.opt

local ru =
    '№ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ'
local en = '#`qwertyuiop[]asdfghjkl\\;\'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>'

M.setup = function()
    -- Neovide settings
    set.guifont = "RobotoMono Nerd Font:h7.5"

    -- Common settings
    set.clipboard = "unnamedplus" -- Connection to the system clipboard
    set.completeopt = { "menu", "menuone", "noselect" } -- Options for insert mode completion
    set.copyindent = true -- Copy the previous indentation on autoindenting
    set.cursorline = true -- Highlight the text line of the cursor
    set.expandtab = true -- Enable the use of space in tab
    set.fillchars = { eob = " " } -- Disable `~` on nonexistent lines
    set.history = 100 -- Number of commands to remember in a history table
    set.ignorecase = true -- Case insensitive searching
    set.langmap = ('%s;%s'):format(ru, en)
    set.listchars = 'tab:▹▹,trail:·,extends:▸,precedes:◂,eol:↵,nbsp:▬'
    set.matchpairs = { '(:)', '{:}', '[:]', '<:>' }
    set.mouse = "a" -- Enable mouse support
    set.number = true -- Show numberline
    set.numberwidth = 4
    set.preserveindent = true -- Preserve indent structure as much as possible
    set.pumheight = 10 -- Height of the pop up menu
    set.relativenumber = true -- Show relative numberline
    set.scrolloff = 8 -- Number of lines to keep above and below the cursor
    set.shiftwidth = 4 -- Number of space inserted for indentation
    set.showmatch = true
    set.showmode = false -- Disable showing modes in command line
    set.sidescrolloff = 8 -- Number of columns to keep at the sides of the cursor
    set.signcolumn = "yes:1" -- Always show the sign column
    set.smartcase = true -- Case sensitivie searching
    set.smartindent = true
    set.softtabstop = 4
    -- set.spelllang = { 'en', 'ru' }
    set.spelllang = { 'en' }
    set.splitbelow = true -- Splitting a new window below the current one
    set.splitright = true -- Splitting a new window at the right of the current one
    set.swapfile = false -- Disable use of swapfile for the buffer
    set.tabstop = 4 -- Number of space in a tab
    set.termguicolors = true -- Enable 24-bit RGB color in the TUI
    set.timeoutlen = 300 -- Length of time to wait for a mapped sequence
    set.undofile = true -- Enable persistent undo
    set.updatetime = 300 -- Length of time to wait before triggering the plugin
    set.wildmode = { 'longest', 'full' }
    set.wrap = false -- Disable wrapping of lines longer than the width of window
    set.writebackup = false -- Disable making a backup before overwriting a file

    -- g.do_filetype_lua = 1 -- use filetype.lua
    -- g.did_load_filetypes = 0 -- don't use filetype.vim
    g.mapleader = leader -- set leader key

    -- Disable some internal plugins
    g.zipPlugin = false -- disable zip
    g.load_black = false -- disable black
    g.loaded_2html_plugin = true -- disable 2html
    g.loaded_getscript = true -- disable getscript
    g.loaded_getscriptPlugin = true -- disable getscript
    g.loaded_gzip = true -- disable gzip
    g.loaded_logipat = true -- disable logipat
    g.loaded_matchit = true -- disable matchit
    g.loaded_netrwFileHandlers = true -- disable netrw
    g.loaded_netrwPlugin = true -- disable netrw
    g.loaded_netrwSettngs = true -- disable netrw
    g.loaded_remote_plugins = true -- disable remote plugins
    g.loaded_tar = true -- disable tar
    g.loaded_tarPlugin = true -- disable tar
    g.loaded_zip = true -- disable zip
    g.loaded_zipPlugin = true -- disable zip
    g.loaded_vimball = true -- disable vimball
    g.loaded_vimballPlugin = true -- disable vimball
end

return M
