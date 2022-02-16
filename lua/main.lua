local include = require('utils').include

-- Sensible defaults
include('settings')

-- Key mappings
include('keymaps')

-- LSP
include('lang')

-- DAP
-- require('dbg')

-- lspkind-nvim
include('config/lspkind')

-- nvim-lightbulb
-- require('config/lightbulb')

-- snippets.nvim
-- require('config/snippets')
