local M = {}

local map = require('core/utils').nmap
local wk = require('which-key')

M.setup = function()
    wk.register({
        f = {
            name = "File",
            f = { "<cmd>Telescope find_files<cr>", "Open" },
            r = { "<cmd>Telescope oldfiles<cr>", "Recent" },
        },
        g = { name = "Git" },
        s = { name = "Search" },
    }, { prefix = "<leader>" })

    map("<leader>fw", function() require("telescope.builtin").live_grep() end, {
        desc = "Search words",
    })
    map("<leader>gt", function() require("telescope.builtin").git_status() end, {
        desc = "Git status",
    })
    map("<leader>gb", function() require("telescope.builtin").git_branches() end, {
        desc = "Git branchs",
    })
    map("<leader>gc", function() require("telescope.builtin").git_commits() end, {
        desc = "Git commits",
    })
    map("<leader>ff", function() require("telescope.builtin").find_files() end, {
        desc = "Search files",
    })
    map("<leader>fb", function() require("telescope.builtin").buffers() end, {
        desc = "Search buffers",
    })
    map("<leader>fh", function() require("telescope.builtin").help_tags() end, {
        desc = "Search help",
    })
    map("<leader>fm", function() require("telescope.builtin").marks() end, {
        desc = "Search marks",
    })
    map("<leader>fo", function() require("telescope.builtin").oldfiles() end, {
        desc = "Search history",
    })
    map("<leader>sb", function() require("telescope.builtin").git_branches() end, {
        desc = "Git branchs",
    })
    map("<leader>sh", function() require("telescope.builtin").help_tags() end, {
        desc = "Search help",
    })
    map("<leader>sm", function() require("telescope.builtin").man_pages() end, {
        desc = "Search man",
    })
    map("<leader>sn", function() require("telescope").extensions.notify.notify() end, {
        desc = "Search notifications",
    })
    map("<leader>sr", function() require("telescope.builtin").registers() end, {
        desc = "Search registers",
    })
    map("<leader>sk", function() require("telescope.builtin").keymaps() end, {
        desc = "Search keymaps",
    })
    map("<leader>sc", function() require("telescope.builtin").commands() end, {
        desc = "Search commands",
    })
    map("<leader>ls", function()
        local aerial_avail, _ = pcall(require, "aerial")
        if aerial_avail then
            require("telescope").extensions.aerial.aerial()
        else
            require("telescope.builtin").lsp_document_symbols()
        end
    end, { desc = "Search symbols" })
    map("<leader>lR", function() require("telescope.builtin").lsp_references() end, {
        desc = "Search references",
    })
    map("<leader>lD", function() require("telescope.builtin").diagnostics() end, {
        desc = "Search diagnostics",
    })
end

return M
