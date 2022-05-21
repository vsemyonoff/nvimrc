require('orgmode').setup_ts_grammar()
require('orgmode').setup({
    org_agenda_files = { '~/Documents/Schedule/**/*' },
    org_default_notes_file = '~/Documents/Schedule/todo.org',
})

-- Register completion source
local cmp = require("cmp")
local cfg = cmp.get_config()
cfg.sources = cmp.config.sources({ { name = "orgmode" }, { name = 'luasnip' } },
                                 { { name = 'buffer' }, { name = 'path' } })
cmp.setup(cfg)
