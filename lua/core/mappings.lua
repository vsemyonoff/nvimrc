local M = {}

local wk = require('which-key')
local utils = require('core/utils')
local map, nmap, imap, tmap, vmap = utils.map, utils.nmap, utils.imap, utils.tmap, utils.vmap

M.setup = function()
    map("<Space>", "<Nop>")

    -- File
    wk.register({
        f = { name = "File", n = { "<cmd>enew<cr>", "New" } },
        t = { name = "Terminal", t = { '<cmd>15sp +term<cr>', "Open" } },
    }, { prefix = "<leader>" })

    -- map("A-w", "<cmd>bd<cr>", { desc = "Close" })
    nmap("C-l", "<cmd>nohlsearch<cr>", { desc = "Clear highlights" })

    vmap('<', '<gv', { desc = "Shift selection right" })
    vmap('>', '>gv', { desc = "Shift selection left" })
end

return M
