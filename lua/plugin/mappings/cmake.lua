local M = {}

M.setup = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local wk = require('which-key')

    wk.register({
        b = {
            name = "Build",
            B = { "<cmd>CMakeBuildAll<cr>", "Build all targets" },
            C = { "<cmd>CMake configure<cr>", "Configure project" },
            O = { "<cmd>CMake open_build_dir<cr>", "Open build folder" },
            T = { "<cmd>CMake select_build_type<cr>", "Select build type" },
            a = { "<cmd>CMake set_target_arguments<cr>", "Set target arguments" },
            b = { "<cmd>CMakeBuild<cr>", "Build target" },
            c = { "<cmd>CMakeClean<cr>", "Clean target" },
            d = { "<cmd>CMake build_and_debug<cr>", "Debug target" },
            r = { "<cmd>CMake build_and_run<cr>", "Run target" },
            t = { "<cmd>CMake select_target<cr>", "Select target" },
            ["<C-esc>"] = { "<cmd>CMake cancel<cr>", "Stop current build" },
        },
    }, { prefix = "<leader>", buffer = bufnr })
end

return M
