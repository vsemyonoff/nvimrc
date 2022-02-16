require('telescope').load_extension('project')

require('utils').nmap(
    '<leader>pp',
    ":lua require'telescope'.extensions.project.project{ change_dir = true }<CR>",
    {noremap = true, silent = true}
)
