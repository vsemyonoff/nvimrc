local luasnip = require('luasnip')
local cmp = require('cmp')

local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

cmp.setup({
    preselect = cmp.PreselectMode.Item,
    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = require('lspkind').cmp_format(),
    },
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
    duplicates = {
        nvim_lsp = 1, --
        nvim_lua = 1,
        luasnip = 1,
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
            elseif has_words_before() then
                cmp.complete()
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
    sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = 'luasnip' } },
                                 { { name = 'buffer' }, { name = 'path' } }),
    completion = { completeopt = 'menu,menuone,noinsert' },
})

cmp.setup.filetype('lua', {
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = 'luasnip' },
    }, { { name = 'buffer' }, { name = 'path' } }),
})
