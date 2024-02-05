return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "moon",
            transparent = true,
            on_colors = function(colors) colors.fg_gutter = "#5C6594" end,
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
}
