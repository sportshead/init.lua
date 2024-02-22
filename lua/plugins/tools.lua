return {
    {
        "mbbill/undotree",
        keys = { {
            "<leader>u",
            "<cmd>UndotreeToggle<cr>",
        } },
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        opts = {
            enable_autocmd = false,
        },
        lazy = true,
    },
    {
        "numToStr/Comment.nvim",
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        config = function()
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            { "<leader>re",  ":Refactor extract ",             mode = "x" },
            { "<leader>rf",  ":Refactor extract_to_file ",     mode = "x" },

            { "<leader>rv",  ":Refactor extract_var ",         mode = "x" },

            { "<leader>ri",  ":Refactor inline_var",           mode = { "n", "x" } },

            { "<leader>rI",  ":Refactor inline_func" },

            { "<leader>rb",  ":Refactor extract_block" },
            { "<leader>rbf", ":Refactor extract_block_to_file" },
        },
        config = true,
    },
    {
        "Exafunction/codeium.vim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            vim.g.codeium_no_map_tab = 1
            vim.g.codeium_tab_fallback = ""
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = true,
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        "ThePrimeagen/vim-be-good",
        cmd = "VimBeGood",
    },
    {
        "tpope/vim-fugitive",
        cmd = { "G", "Git" },
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
        "aznhe21/actions-preview.nvim",
        keys = {
            { "gf", function() require("actions-preview").code_actions() end, mode = { "v", "n" } },
        },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },
}
