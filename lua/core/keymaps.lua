local utils = require('core/utils')
local nmap, imap, tmap, vmap = utils.nmap, utils.imap, utils.tmap, utils.vmap

-- Map leader to space
vim.g.mapleader = ' '
-- vim.g.maplocalleader = ','

nmap('<C-l>', '<cmd>noh<CR>') -- clear highlights
nmap('<Leader>tt', '<cmd>15sp +term<CR>')
nmap('<Leader>fq', '<cmd>q<CR>')
nmap('<Leader>fsf', '<cmd>w<CR>')
nmap('<C-w><C-o>', ':MaximizerToggle!<CR>')
nmap('<Leader>e', '!!$SHELL<CR>')

imap('jk', '<Esc>') -- jk to escape

tmap('<C-w><C-o>', '<C-\\><C-n> :MaximizerToggle!<CR>')
tmap('<C-h>', '<C-\\><C-n><C-w>h')
tmap('<C-j>', '<C-\\><C-n><C-w>j')
tmap('<C-k>', '<C-\\><C-n><C-w>k')
tmap('<C-l>', '<C-\\><C-n><C-w>l')
tmap('jk', '<C-\\><C-n>')

nmap('<Leader>bc', '<cmd>bd<CR>')
nmap('<Leader>bn', '<cmd>bn<CR>')
nmap('<Leader>bp', '<cmd>bp<CR>')
nmap('<Leader>bl', '<cmd>ls<CR>')

vmap('<', '<gv')
vmap('>', '>gv')

nmap('<M-left>', '<C-w>>')
nmap('<M-right>', '<C-w><')
nmap('<M-up>', '<C-w>+')
nmap('<M-down>', '<C-w>-')

vim.api.nvim_exec([[
    cnoreabbrev W! w!
    cnoreabbrev Q! q!
    cnoreabbrev Qall! qall!
    cnoreabbrev Wq wq
    cnoreabbrev Wa wa
    cnoreabbrev wQ wq
    cnoreabbrev WQ wq
    cnoreabbrev W w
    cnoreabbrev Q q
    cnoreabbrev Qall qall

    cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
]], false)

