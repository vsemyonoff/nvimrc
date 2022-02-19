local cmp = require('cmp')

cmp.setup {
    formatting = {
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = require("lspkind").presets.default[vim_item.kind] ..
                                " " .. vim_item.kind
            -- set a name for each source
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                ultisnips = "[UltiSnips]",
                nvim_lua = "[Lua]",
                cmp_tabnine = "[TabNine]",
                look = "[Look]",
                path = "[Path]",
                spell = "[Spell]",
                calc = "[Calc]",
                emoji = "[Emoji]"
            })[entry.source.name]
            return vim_item
        end
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true
                })
            else
                fallback()
            end
        end, {'i', 's'})
    },
    snippet = {
        expand = function(args)
            require('snippy').expand_snippet(args.body)
        end
    },
    sources = {
        {name = 'buffer'}, {name = 'nvim_lsp'}, {name = 'snippy'},
        {name = "nvim_lua"}, {name = 'look'}, {name = 'path'}, {name = 'calc'},
        {name = 'spell'}, {name = 'emoji'}
    },
    completion = {completeopt = 'menu,menuone,noinsert'}
}
