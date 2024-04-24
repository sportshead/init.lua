return {
    {
        "Exafunction/codeium.vim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            vim.g.codeium_no_map_tab = 1
            vim.g.codeium_tab_fallback = ""
        end,
    },
    {
        "sportshead/carbon-now.nvim",
        cmd = "CarbonNow",
        config = function()
            math.randomseed(os.time())
            require("carbon-now").setup({
                open_cmd = "open",
                options = {
                    theme = "panda-syntax",
                    bg = function() return "hsl(" .. math.random(0, 360) .. ", 70%, 72%)" end,
                    line_numbers = true,
                },
            })
        end,
    },
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim", -- required by telescope
            "MunifTanjim/nui.nvim",

            -- optional
            "nvim-treesitter/nvim-treesitter",
            "rcarriga/nvim-notify",
            "nvim-tree/nvim-web-devicons",
        },
        event = "BufEnter leetcode.nvim",
        opts = {
            -- configuration goes here
        },
    },
}
