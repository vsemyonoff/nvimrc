local M = {}

M.setup = function()
    local map = require('core/utils').nmap
    local wk = require('which-key')

    wk.register({
        f = { name = "File" },
        g = { name = "Git" },
        s = { name = "Search" },
    }, { prefix = "<leader>" })

    -- File
    map("<leader>fb", function() require("telescope.builtin").buffers() end, {
        desc = "Switch",
    })
    map("<leader>ff", function() require("telescope.builtin").find_files() end, {
        desc = "Open",
    })
    map("<leader>fm", function() require("telescope.builtin").marks() end, {
        desc = "Bookmarks",
    })
    map("<leader>fr", function() require("telescope.builtin").oldfiles() end, {
        desc = "Recent",
    })

    -- Git
    map("<leader>gb", function() require("telescope.builtin").git_branches() end, {
        desc = "Branchs",
    })
    map("<leader>gc", function() require("telescope.builtin").git_commits() end, {
        desc = "Commits",
    })

    -- Search
    map("<leader>sw", function() require("telescope.builtin").live_grep() end, {
        desc = "Words",
    })
    map("<leader>sh", function() require("telescope.builtin").help_tags() end, {
        desc = "Help",
    })
    map("<leader>sm", function() require("telescope.builtin").man_pages() end, {
        desc = "Man",
    })
    map("<leader>sn", function() require("telescope").extensions.notify.notify() end, {
        desc = "Notifications",
    })
    map("<leader>sr", function() require("telescope.builtin").registers() end, {
        desc = "Registers",
    })
    map("<leader>sk", function() require("telescope.builtin").keymaps() end, {
        desc = "Keymaps",
    })
    map("<leader>sc", function() require("telescope.builtin").commands() end, {
        desc = "Commands",
    })
    map("<leader>ss", function()
        local aerial_avail, _ = pcall(require, "aerial")
        if aerial_avail then
            require("telescope").extensions.aerial.aerial()
        else
            require("telescope.builtin").lsp_document_symbols()
        end
    end, { desc = "Symbols" })
    local project_avail, _ = pcall(require, "project_nvim")
    if project_avail then
        map("<leader>sp", function() require('telescope').extensions.projects.projects() end, {
            desc = "Project",
        })
    end
end

return M
