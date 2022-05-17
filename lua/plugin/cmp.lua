local luasnip = require('luasnip')
local cmp = require('cmp')

cmp.setup({
    preselect = cmp.PreselectMode.Item,
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = require('lspkind').cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        }),
        -- format = function(_, vim_item)
        --    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
        --    return vim_item
        -- end,
    },
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
    duplicates = {
        nvim_lsp = 1,
        luasnip = 1,
        cmp_tabnine = 1,
        buffer = 1,
        path = 1,
    },
    confirm_opts = { behavior = cmp.ConfirmBehavior.Insert, select = true },
    window = {
        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
    },
    experimental = { ghost_text = false, native_menu = false },
    mapping = {
        ["<Up>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select,
        }),
        ["<Down>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select,
        }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable,
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm({ select = true })
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = "nvim_lua" },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'nvim_lsp_signature_help' },
    },
    completion = { completeopt = 'menu,menuone,noinsert' },
})
