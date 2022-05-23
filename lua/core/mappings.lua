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
        ["/"] = { require("Comment.api").toggle_current_linewise, "Comment" },
        ["\\"] = { neotreeToggle, "NeoTree" },
        b = {
            name = "Build",
            N = { "<cmd>CMake create_project<cr>", "New CMake project" },
        },
        d = { utils.quickfix_toggle, "Quickfix toggle" },
        f = { name = "File", n = { "<cmd>enew<cr>", "New" } },
        g = { name = "Git", s = { "<cmd>Neogit<cr>", "Status/commit" } },
        l = { name = "LSP", I = { "<cmd>LspInstallInfo<cr>", "LSP installer" } },
        o = { "<cmd>AerialToggle right<cr>", "Outline" },
        t = { "<cmd>ToggleTerm<cr>", "Terminal" },
    }, { prefix = "<leader>" })

    wk.register({ --
        -- Tabs
        ["<a-t>"] = { "<cmd>enew<cr>", "New tab" },
        ["<a-w>"] = { "<cmd>Bdelete<cr>", "Close tab" },
        ["<a-{>"] = { "<plug>(cokeline-focus-prev)", "Previous tab" },
        ["<a-}>"] = { "<plug>(cokeline-focus-next)", "Next tab" },
        ["<c-l>"] = { "<cmd>nohlsearch<cr>", "Clear highlights" },
        -- Windows
        ["<a-left>"] = { "<c-w>h", "Window left" },
        ["<a-down>"] = { "<c-w>j", "Window down" },
        ["<a-up>"] = { "<c-w>k", "Window up" },
        ["<a-right>>"] = { "<c-w>l", "Window right" },
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
        ["<c-esc>"] = { "<cmd>ToggleTerm<cr>", "Terminal close" },
    }, { mode = "t" })
end

return M
