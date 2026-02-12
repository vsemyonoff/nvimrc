local freekey = function(key)
  vim.keymap.set({ "n", "v" }, key, "<nop>")
end
local g, set = vim.g, vim.opt

-- Language mapping russian -> english
-- stylua: ignore
local ru = "№ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ"
local en = "#`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\\"ZXCVBNM<>"

set.autowrite = true
set.breakindent = true
set.cmdheight = 0 -- Hide cmdline
set.completeopt = { "menu", "menuone", "noselect" } -- Options for insert mode completion
set.conceallevel = 2
set.confirm = true
set.copyindent = true -- Copy the previous indentation on autoindenting
set.cursorline = true -- Highlight the text line of the cursor
set.expandtab = true -- Enable the use of space in tab
set.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- -- set.foldexpr = "v:lua.require'core.utils.ui'.foldexpr()"
set.foldlevel = 99
set.foldlevelstart = 1
-- set.foldmethod = "expr"
set.foldtext = "v:lua.require'core.utils.ui'.foldtext()"
-- set.formatexpr = "v:lua.require'core.utils'.format.formatexpr()"
set.formatoptions = "jcroqlnt" -- tcqj
set.grepformat = "%f:%l:%c:%m"
set.grepprg = "rg --vimgrep"
set.history = 100 -- Number of commands to remember in a history table
set.ignorecase = true -- Case insensitive searching
set.inccommand = "nosplit"
set.jumpoptions = "view"
set.langmap = string.format("%s;%s", ru, en)
set.laststatus = 3
set.lazyredraw = false
set.linebreak = true
set.listchars = "tab:▹▹,trail:·,extends:▸,precedes:◂,eol:↵,nbsp:▬"
set.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
set.mouse = "a" -- Enable mouse support
set.number = true -- Show numberline
set.numberwidth = 4
set.preserveindent = true -- Preserve indent structure as much as possible
set.pumheight = 10 -- Height of the pop up menu
set.relativenumber = true -- Show relative numberline
set.ruler = false
set.scrolloff = 8 -- Number of lines to keep above and below the cursor
set.sessionoptions = {
  "buffers",
  "curdir",
  "folds",
  "globals",
  "localoptions",
  "options",
  "skiprtp",
  "winsize",
}
set.shiftround = true -- Round indent
set.shiftwidth = 4 -- Number of space inserted for indentation
set.shortmess:append({ W = true, I = true, c = true, C = true })
set.showmatch = true
set.showmode = false -- Disable showing modes in command line
set.sidescrolloff = 8 -- Number of columns to keep at the sides of the cursor
set.signcolumn = "yes:2" -- Always show the sign column
set.smartcase = true -- Case sensitivie searching
set.smartindent = true
set.smoothscroll = true
set.softtabstop = 4
set.spelllang = { "en_us", "ru" }
set.splitbelow = true -- Splitting a new window below the current one
set.splitkeep = "screen"
set.splitright = true -- Splitting a new window at the right of the current one
set.statuscolumn = "" -- [[%!v:lua.require'snacks.statuscolumn'.get()]]
set.swapfile = false -- Disable use of swapfile for the buffer
set.tabstop = 4 -- Number of space in a tab
set.termguicolors = true -- Enable 24-bit RGB color in the TUI
set.timeoutlen = 300 -- Length of time to wait for a mapped sequence
set.undofile = true -- Enable persistent undo
set.undolevels = 10000
set.updatetime = 200 -- Length of time to wait before triggering the plugin
set.virtualedit = "all" -- "block"
set.wildmode = "longest:full,full"
set.wrap = true -- Disable wrapping of lines longer than the width of window
set.writebackup = false -- Disable making a backup before overwriting a file

-- Fix markdown indentation settings
g.markdown_recommended_style = 0

-- Leader keys
g.mapleader = Core.config.system.leader
freekey(g.mapleader)
g.maplocalleader = Core.config.system.localleader
freekey(g.maplocalleader)

-- Disable some internal providers
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
