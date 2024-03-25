return {
    {
        "mbbill/undotree",
        keys = { {
            "<leader>u",
            "<cmd>UndotreeToggle<cr>",
        } },
    },
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            { "<leader>re", ":Refactor extract ", mode = "x" },
            { "<leader>rf", ":Refactor extract_to_file ", mode = "x" },

            { "<leader>rv", ":Refactor extract_var ", mode = "x" },

            { "<leader>ri", ":Refactor inline_var", mode = { "n", "x" } },

            { "<leader>rI", ":Refactor inline_func" },

            { "<leader>rb", ":Refactor extract_block" },
            { "<leader>rbf", ":Refactor extract_block_to_file" },
        },
        config = true,
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
        "chrishrb/gx.nvim",
        dev = true,
        keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
        cmd = { "Browse" },
        init = function()
            vim.g.netrw_nogx = 1 -- disable netrw gx
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
        submodules = false, -- not needed, submodules are required only for tests

        -- you can specify also another config if you want
        opts = {
            open_browser_app = "open", -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
            handlers = {
                plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
                github = true, -- open github issues
                brewfile = true, -- open Homebrew formulaes and casks
                package_json = true, -- open dependencies from package.json
                search = true, -- search the web/selection on the web if nothing else is found
            },
            handler_options = {
                search_engine = "duckduckgo",
            },
        },
    },
    {
        "olrtg/nvim-emmet",
        keys = {
            { "<leader>xe", function() require("nvim-emmet").wrap_with_abbreviation() end, mode = { "n", "v" } },
        },
    },
    {
        "zeioth/garbage-day.nvim",
        dependencies = "neovim/nvim-lspconfig",
        event = "VeryLazy",
        opts = {
            notifications = true,
        },
    },
}
