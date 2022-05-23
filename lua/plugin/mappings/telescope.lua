local M = {}

M.setup = function()
    local telescope = require('telescope/builtin')
    local map = require('core/utils').nmap
    local wk = require('which-key')

    wk.register({
        f = { name = "File" },
        g = { name = "Git" },
        s = { name = "Search" },
    }, { prefix = "<leader>" })

    -- File
    map("<leader>fb", telescope.buffers, { desc = "Switch" })
    map("<leader>ff", telescope.find_files, { desc = "Open" })
    map("<leader>fm", telescope.marks, { desc = "Bookmarks" })
    map("<leader>fr", telescope.oldfiles, { desc = "Recent" })

    -- Git
    map("<leader>gb", telescope.git_branches, { desc = "Branchs" })
    map("<leader>gc", telescope.git_commits, { desc = "Commits" })

    -- Search
    map("<leader>sw", telescope.live_grep, { desc = "Words" })
    map("<leader>sh", telescope.help_tags, { desc = "Help" })
    map("<leader>sm", telescope.man_pages, { desc = "Man" })
    map("<leader>sn", require('telescope').extensions.notify.notify, {
        desc = "Notifications",
    })
    map("<leader>sr", telescope.registers, { desc = "Registers" })
    map("<leader>sk", telescope.keymaps, { desc = "Keymaps" })
    map("<leader>sc", telescope.commands, { desc = "Commands" })
    map("<leader>ss", function()
        local aerial_avail, _ = pcall(require, "aerial")
        if aerial_avail then
            require('telescope').extensions.aerial.aerial()
        else
            telescope.lsp_document_symbols()
        end
    end, { desc = "Symbols" })
    local project_avail, _ = pcall(require, 'project_nvim')
    if project_avail then
        map("<leader>sp", function()
            require('telescope').extensions.projects.projects()
        end, { desc = "Project" })
    end
end

return M
