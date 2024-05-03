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
