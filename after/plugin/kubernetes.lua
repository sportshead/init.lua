if vim.loop.os_uname().sysname == "Darwin" then
    vim.fn.system("orbctl status")
    if vim.v.shell_error == 0 then
        vim.fn.packadd("kubernetes.nvim")
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
