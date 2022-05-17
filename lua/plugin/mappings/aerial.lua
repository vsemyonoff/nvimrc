local M = {}

M.setup = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<cr>", {
            buffer = bufnr,
            desc = "Jump backwards in Aerial",
        })
        vim.keymap.set("n", "}", "<cmd>AerialNext<cr>", {
            buffer = bufnr,
            desc = "Jump forwards in Aerial",
        })
        -- Jump up the tree with '[[' or ']]'
        vim.keymap.set("n", "[[", "<cmd>AerialPrevUp<cr>", {
            buffer = bufnr,
            desc = "Jump up and backwards in Aerial",
        })
        vim.keymap.set("n", "]]", "<cmd>AerialNextUp<cr>", {
            buffer = bufnr,
            desc = "Jump up and forwards in Aerial",
        })
end

return M
