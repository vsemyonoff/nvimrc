-- Map leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Sensible defaults
require('settings')

-- Key mappings
require('keymaps')

-- LSP
require('lang')

-- DAP
-- require('dbg')

-- Another option is to groups configuration in one folder
--require('config')

require('config/colorscheme')
require('config/fugitive')
require('config/devicon')
require('config/project')
require('config/telescope')

-- nvim-compe
require('config/compe')

-- lspkind-nvim
require('config/lspkind')

-- nvim-colorizer
require('config/colorizer')

-- nvim-lightbulb
-- require('config/lightbulb')

-- treesitter
require('config/treesitter')

-- snippets.nvim
-- require('config/snippets')

-- completion-nvim
-- require('config/completion')

-- vim-slime
require('config/slime')
