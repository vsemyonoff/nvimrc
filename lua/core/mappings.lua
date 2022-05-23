local M = {}

local utils = require('core/utils')
local wk = require('which-key')

local neotreeToggle = function()
    local root = utils.project_root()
    if root == "" then
        root = "~"
    end
    require('neo-tree/command').execute({ toggle = true, dir = root })
end

M.setup = function()
    wk.register({
        ["/"] = {
            function() require("Comment.api").toggle_current_linewise() end,
            "Comment",
        },
        ["\\"] = { neotreeToggle, "NeoTree" },
        b = {
            name = "Build",
            N = { "<cmd>CMake create_project<cr>", "New CMake project" },
        },
        d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
        f = { name = "File", n = { "<cmd>enew<cr>", "New" } },
        g = { name = "Git", s = { "<cmd>Neogit<cr>", "Status/commit" } },
        o = { "<cmd>AerialToggle right<cr>", "Outline" },
        t = { "<cmd>ToggleTerm<cr>", "Terminal" },
    }, { prefix = "<leader>" })

    wk.register({ --
        ["<A-t>"] = { "<cmd>tabe<cr>", "New tab" },
        ["<A-w>"] = { "<cmd>Bdelete<cr>", "Close tab" },
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
        ["<C-esc>"] = { "<cmd>ToggleTerm<cr>", "Terminal close" },
    }, { mode = "t" })
end

return M
