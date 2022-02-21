local nmap = require('core/utils').nmap

nmap('<Leader>gs', '<cmd>Gstatus<CR>')
nmap('<Leader>gp', '<cmd>Git push<CR>')
nmap('<Leader>gb', '<cmd>GBranches<CR>')
nmap('<Leader>gd', '<cmd>Gvdiffsplit<CR>')
nmap('<Leader>gf', '<cmd>Fit fetch --all<CR>')
nmap('<Leader>grum', '<cmd>Git rebase upstream/master<CR>')
nmap('<Leader>grom', '<cmd>Git rebase origin/master<CR>')
nmap('<Leader>gdr', '<cmd>diffget //3<CR>')
nmap('<Leader>gdl', '<cmd>diffget //2<CR>')
nmap('<leader>gdb', '<cmd>lua require("config.telescope").git_branches()<CR>')
