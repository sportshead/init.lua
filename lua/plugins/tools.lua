return {
    {
        "ThePrimeagen/vim-be-good",
        cmd = "VimBeGood",
    },
    {
        "chrishrb/gx.nvim",
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
                git_remotes = { "upstream", "origin" },
            },
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
