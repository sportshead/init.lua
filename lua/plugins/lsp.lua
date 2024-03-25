return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            -- LSP Support
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            -- Autocompletion
            "hrsh7th/nvim-cmp",

            -- Snippets
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",

            -- Formatting
            "nvimtools/none-ls.nvim",
        },
    },
    {
        "L3MON4D3/cmp-luasnip-choice",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
        },
        opts = {
            auto_open = true, -- Automatically open nvim-cmp on choice node (default: true)
        },
        event = "InsertEnter",
    },

    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = true,
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "onsails/lspkind.nvim",

            "L3MON4D3/LuaSnip",
            "L3MON4D3/cmp-luasnip-choice",
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local luasnip = require("luasnip")

            cmp.setup({
                sources = {
                    { name = "path" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "luasnip", keyword_length = 2 },
                    { name = "buffer", keyword_length = 3 },
                },
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                    format = require("lspkind").cmp_format({
                        mode = "symbol", -- show only symbol annotations
                        maxwidth = 50, -- prevent the popup from showing more than provided characters
                        ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
                    }),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.close()
                        else
                            cmp.complete()
                        end
                    end),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            local entry = cmp.get_selected_entry()
                            if not entry then
                                cmp.confirm({ select = true })
                            else
                                cmp.confirm()
                            end
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            local codeium = vim.fn["codeium#Accept"]()
                            if codeium ~= "" and type(codeium) == "string" then
                                vim.api.nvim_feedkeys(codeium, "i", true)
                            end

                            fallback()
                        end
                    end, { "i", "s" }),
                }),
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "williamboman/mason-lspconfig.nvim" },
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(_, bufnr)
                local opts = { buffer = bufnr, remap = false }
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({ buffer = bufnr })
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end)

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "tsserver",
                    "gopls",
                    "lua_ls",
                    "ltex",
                    "emmet_language_server",
                    "yamlls",
                    "bashls",
                },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require("lspconfig").lua_ls.setup(lua_opts)
                    end,
                    gopls = function()
                        require("lspconfig").gopls.setup({
                            settings = {
                                gopls = {
                                    gofumpt = true,
                                    staticcheck = true,
                                },
                            },
                        })
                    end,
                    ltex = function()
                        require("lspconfig").ltex.setup({
                            settings = {
                                ltex = {
                                    language = "en-GB",
                                    ["ltex-ls"] = {
                                        logLevel = "config",
                                    },
                                },
                            },
                        })
                    end,
                    emmet_language_server = function()
                        require("lspconfig").emmet_language_server.setup({
                            filetypes = {
                                "css",
                                "eruby",
                                "html",
                                "javascript",
                                "javascriptreact",
                                "less",
                                "sass",
                                "scss",
                                "pug",
                                "typescriptreact",
                                "vue",
                            },
                        })
                    end,
                },
            })

            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            vim.api.nvim_clear_autocmds({ group = augroup })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                callback = function()
                    vim.lsp.buf.format({
                        filter = function(client) return client.name ~= "lua_ls" and client.name ~= "tsserver" end,
                    })
                end,
            })
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.prettierd,
                    null_ls.builtins.formatting.shfmt
                },
            })
        end,
    },
}
