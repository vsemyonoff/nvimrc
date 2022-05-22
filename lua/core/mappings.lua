local M = {}

local wk = require('which-key')

local neotreeToggle = function()
    local root = vim.lsp.buf.list_workspace_folders()[1]
    require('neo-tree/command').execute({ toggle = true, dir = root or "~" })
end

M.setup = function()
    wk.register({
        ["/"] = {
            function() require("Comment.api").toggle_current_linewise() end,
            "Comment",
        },
        ["\\"] = { neotreeToggle, "NeoTree" },
        d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
        f = { name = "File", n = { "<cmd>enew<cr>", "New" } },
        g = { name = "Git", s = { "<cmd>Neogit<cr>", "Status/commit" } },
        o = { "<cmd>AerialToggle right<cr>", "Outline" },
        t = { "<cmd>ToggleTerm<cr>", "Terminal" },
        w = {
            name = "Workspace",
            l = {
                "<cmd>SessionManager! load_last_session<cr>", --
                "Load",
            },
            s = { "<cmd>SessionManager! save_current_session<cr>", "Save" },
            d = {
                "<cmd>SessionManager! delete_session<cr>", --
                "Delete",
            },
            f = {
                "<cmd>SessionManager! load_session<cr>", --
                "Search",
            },
            L = {
                "<cmd>SessionManager! load_current_dir_session<cr>",
                "Load local",
            },
        },
    }, { prefix = "<leader>" })

    wk.register({ --
        ["<A-t>"] = { "<cmd>tabe<cr>", "New tab" },
        ["<A-w>"] = { "<cmd>bd<cr>", "Close tab" },
        ["<A-{>"] = { "<cmd>BufferLineCyclePrev<cr>", "Previous tab" },
        ["<A-}>"] = { "<cmd>BufferLineCycleNext<cr>", "Next tab" },
        ["<C-l>"] = { "<cmd>nohlsearch<cr>", "Clear highlights" },
    })

    wk.register({
        ["<leader>/"] = {
            "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>",
            "Comment region",
        },
        ["<"] = { "<gv", "Shift region left" },
        [">"] = { ">gv", "Shift region right" },
    }, { mode = "v" })

    wk.register({ --
        ["<leader>t"] = { "<cmd>ToggleTerm<cr>", "Terminal" },
        ["<esc>"] = { "<cmd>ToggleTerm<cr>", "Terminal" },
    }, { mode = "t" })
end

return M
