local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
        ["<c-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<c-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<c-d>"] = cmp.mapping.scroll_docs(-4),
        ["<c-f>"] = cmp.mapping.scroll_docs(4),
        ["<c-e>"] = cmp.mapping.abort(),

        ["<c-l>"] = cmp.mapping( cmp.mapping.confirm { select = false, },
            { "i", "c" }
        ),

        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        ["<c-j>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { "i", "s", }
        ),

        ["<c-k>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { "i", "s", }
        ),
    }),

    sources = cmp.config.sources({
        { name = 'cmp_git' },
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'emmet_vim' },
    }, {
        { name = 'path' },
        { name = 'buffer', keyword_length = 5 },
    }),

    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.menu = ({
                luasnip = "[Snip]",
                nvim_lsp = "[LSP]",
                buffer = "[Buff]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
    },

    experimental = {
        ghost_text = false,
    },
})

-- Git files
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' },
    }, {
        { name = 'buffer', keyword_length = 5 },
    })
})

-- Search
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Command line
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
