require('telescope').load_extension('project')

require('core/utils').nmap('<leader>pp',

                           ":lua require'telescope'.extensions.project.project{ change_dir = true }<CR>")
