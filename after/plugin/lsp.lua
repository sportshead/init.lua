local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
end)

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = { "tsserver", "gopls", "lua_ls", "ltex", "emmet_language_server", "yamlls" },
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
        yamlls = function()
            require("lspconfig").yamlls.setup({
                yaml = {
                    schemas = {
                        [require("kubernetes").yamlls_schema()] = "*.yaml",
                    },
                },
            })
        end,
    },
})

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.formatting.prettierd,
    },
})

vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
