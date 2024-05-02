return {
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = {
                "markdown",
            }
        end,
        ft = { "markdown" },
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
        ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "astro", "html" },
        config = function()
            -- https://lsp-zero.netlify.app/v3.x/guide/configure-volar-v2.html
            require("typescript-tools").setup({
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                    "vue",
                },
                settings = {
                    tsserver_plugins = {
                        "@vue/typescript-plugin",
                    },
                },
                on_attach = function(client) client.server_capabilities.semanticTokensProvider = false end,
            })
        end,
    },
    {
        "davidmh/mdx.nvim",
        config = true,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "petRUShka/vim-opencl",
    },
    {
        "sportshead/cie.nvim",
        -- dir = "~/projects/cie/cie.nvim",
        config = true,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        lazy = false,
    },
}
