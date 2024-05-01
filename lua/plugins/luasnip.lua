return {
    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        lazy = true,
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snip/" })
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
}
