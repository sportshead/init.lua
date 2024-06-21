return {
    {
        "diogo464/kubernetes.nvim",
        lazy = true,
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            if vim.loop.os_uname().sysname == "Darwin" then
                vim.fn.system("orbctl config show | grep -q 'k8s.enable: true'")
                if vim.v.shell_error == 0 then
                    require("kubernetes").setup()

                    require("mason-lspconfig").setup_handlers({
                        yamlls = function()
                            require("lspconfig").yamlls.setup({
                                yaml = {
                                    schemas = {
                                        [require("kubernetes").yamlls_schema()] = "*.yaml",
                                    },
                                },
                            })
                        end,
                    })
                end
            end
        end,
        ft = { "yaml" },
    },
}
