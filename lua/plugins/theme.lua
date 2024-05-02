return {
    {
        "folke/tokyonight.nvim",
        enabled = false,
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
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
            italic_comments = true,
            hide_fillchars = true,
            borderless_telescope = false,
            terminal_colors = true,

            theme = {
                highlights = {
                    LineNr = { fg = "#5C6594" },
                },
            },
        },
        config = function(_, opts)
            require("cyberdream").setup(opts)
            vim.cmd("colorscheme cyberdream")
        end,
    },
}
