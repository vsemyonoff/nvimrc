require("project_nvim").setup({
    patterns = { ".git", ".project", "Makefile" },
    ignore_lsp = { "efm" },
})

require('telescope').load_extension('projects')
