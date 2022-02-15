local include = require('utils').include

-- Sensible defaults
include('settings')

-- Key mappings
include('keymaps')

-- LSP
require('lang')

-- DAP
-- require('dbg')

-- nvim-compe
require('config/compe')

-- lspkind-nvim
require('config/lspkind')

-- nvim-lightbulb
-- require('config/lightbulb')

-- snippets.nvim
-- require('config/snippets')

-- completion-nvim
-- require('config/completion')

-- vim-slime
require('config/slime')
