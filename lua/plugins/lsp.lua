return {
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
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "onsails/lspkind.nvim",

            "L3MON4D3/LuaSnip",
            "L3MON4D3/cmp-luasnip-choice",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args) require("luasnip").lsp_expand(args.body) end,
                },
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
            local function format_callback()
                local dir = vim.fn.expand("%:p:h")
                if
                    dir:match("projects/ultraviolet")
                    or dir:match("projects/vite%-plugin%-mediawiki%-userscript")
                    or dir:match("projects/mediawiki")
                then
                    -- wtf callbacks get removed when they return true??
                    -- neovim/neovim#17782
                    vim.cmd("silent! EslintFixAll")
                    return
                end
                vim.lsp.buf.format({
                    filter = function(client)
                        local lsp_blacklist = { "lua_ls", "vtsls", "eslint" }
                        return not vim.tbl_contains(lsp_blacklist, client.name)
                    end,
                })
            end
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            vim.api.nvim_clear_autocmds({ group = augroup })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                callback = format_callback,
            })

            -- https://lsp-zero.netlify.app/v3.x/blog/you-might-not-need-lsp-zero.html
            vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
            vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
            vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }

                    -- these will be buffer-local keybindings
                    -- because they only work if you have an active language server

                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                    vim.keymap.set({ "n", "x" }, "<F3>", format_callback, opts)
                    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                    vim.keymap.set("i", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                end,
            })

            local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
            local default_setup = function(server)
                if server == "tsserver" then return end
                require("lspconfig")[server].setup({
                    capabilities = lsp_capabilities,
                })
            end

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "vtsls",
                    "volar",
                    "gopls",
                    "lua_ls",
                    "harper_ls",
                    "emmet_language_server",
                    "yamlls",
                    "bashls",
                    "eslint",
                },
                handlers = {
                    default_setup,
                    lua_ls = function()
                        require("lspconfig").lua_ls.setup({
                            capabilities = lsp_capabilities,
                            settings = {
                                Lua = {
                                    runtime = {
                                        version = "LuaJIT",
                                    },
                                    diagnostics = {
                                        globals = { "vim" },
                                    },
                                    workspace = {
                                        library = {
                                            vim.env.VIMRUNTIME,
                                        },
                                    },
                                },
                            },
                        })
                    end,
                    gopls = function()
                        require("lspconfig").gopls.setup({
                            capabilities = lsp_capabilities,
                            settings = {
                                gopls = {
                                    gofumpt = true,
                                    staticcheck = true,
                                },
                            },
                        })
                    end,
                    emmet_language_server = function()
                        require("lspconfig").emmet_language_server.setup({
                            capabilities = lsp_capabilities,
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
                                "astro",
                                "mdx",
                            },
                        })
                    end,
                    vtsls = function()
                        require("lspconfig").vtsls.setup({
                            capabilities = lsp_capabilities,
                            filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
                            -- https://github.com/yioneko/vtsls/issues/148#issuecomment-2094004455
                            settings = {
                                vtsls = {
                                    tsserver = {
                                        globalPlugins = {
                                            {
                                                name = "@vue/typescript-plugin",
                                                location = require("mason-registry")
                                                    .get_package("vue-language-server")
                                                    :get_install_path()
                                                    .. "/node_modules/@vue/language-server",
                                                languages = { "vue" },
                                                configNamespace = "typescript",
                                                enableForWorkspaceTypeScriptVersions = true,
                                            },
                                        },
                                    },
                                },
                            },
                        })
                    end,
                    volar = function()
                        require("lspconfig").volar.setup({
                            capabilities = lsp_capabilities,
                            filetypes = { "vue" },
                        })
                    end,
                    eslint = function()
                        require("lspconfig").eslint.setup({
                            capabilities = lsp_capabilities,
                            handlers = {
                                ["eslint/noConfig"] = function()
                                    vim.notify("No eslint config found", vim.log.levels.WARN)
                                    return {}
                                end,
                            },
                        })
                    end,
                },
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
                    null_ls.builtins.formatting.shfmt,
                    null_ls.builtins.formatting.clang_format,
                },
            })
        end,
    },
}
