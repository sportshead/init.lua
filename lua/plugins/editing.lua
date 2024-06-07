return {
    {
        "mbbill/undotree",
        keys = { {
            "<leader>u",
            "<cmd>UndotreeToggle<cr>",
        } },
    },
    {
        "olrtg/nvim-emmet",
        keys = {
            { "<leader>xe", function() require("nvim-emmet").wrap_with_abbreviation() end, mode = { "n", "v" } },
        },
    },
    {
        "johnfrankmorgan/whitespace.nvim",
        event = "BufReadPost",
        opts = {
            -- `highlight` configures which highlight is used to display
            -- trailing whitespace
            highlight = "DiffDelete",

            -- `ignored_filetypes` configures which filetypes to ignore when
            -- displaying trailing whitespace
            ignored_filetypes = { "TelescopePrompt", "Trouble", "help" },

            -- `ignore_terminal` configures whether to ignore terminal buffers
            ignore_terminal = true,

            -- `return_cursor` configures if cursor should return to previous
            -- position after trimming whitespace
            return_cursor = true,
        },
        keys = {
            { "<leader>t", function() require("whitespace-nvim").trim() end },
        },
    },
}
