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
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
    },
    {
        "davidmh/mdx.nvim",
        config = true,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "petRUShka/vim-opencl",
    },
}
