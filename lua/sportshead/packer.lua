-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        -- or                          , branch = '0.1.x',
        requires = { { "nvim-lua/plenary.nvim" } },
    })

    use({
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({
                is_hidden_file = function(name)
                    if name == ".git" then return true end
                    if name == "node_modules" then return true end

                    return false
                end,
            })
        end,
    })

    use({
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                style = "moon",
                transparent = true,
            })
            vim.cmd([[colorscheme tokyonight-moon]])
        end,
    })

    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    use({ "nvim-treesitter/nvim-treesitter-context", requires = { { "nvim-treesitter/nvim-treesitter" } } })

    use({
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } },
    })

    use("mbbill/undotree")

    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            { "onsails/lspkind.nvim" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },

            -- Emmet
            { "olrtg/nvim-emmet" },

            -- Formatting
            { "nvimtools/none-ls.nvim" },
        },
    })

    use("tpope/vim-commentary")

    use({
        "akinsho/toggleterm.nvim",
        tag = "*",
        config = function()
            require("toggleterm").setup({
                direction = "float",
            })
        end,
    })

    use("nvim-tree/nvim-web-devicons")

    use({
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons" },
    })
    use("arkav/lualine-lsp-progress")

    use({
        "ThePrimeagen/refactoring.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
        },
    })

    use({
        "Exafunction/codeium.vim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "hrsh7th/nvim-cmp" },
        },
    })

    use({
        "andweeb/presence.nvim",
        config = function()
            require("presence"):setup({
                buttons = true,
            })
        end,
    })

    use({
        "folke/trouble.nvim",
        config = function() require("trouble").setup() end,
    })

    use("ThePrimeagen/vim-be-good")

    use({
        "norcalli/nvim-colorizer.lua",
        config = function() require("colorizer").setup() end,
    })

    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
        setup = function()
            vim.g.mkdp_filetypes = {
                "markdown",
            }
        end,
        ft = { "markdown" },
    })
end)
