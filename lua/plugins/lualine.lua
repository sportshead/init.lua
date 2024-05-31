return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "linrongbin16/lsp-progress.nvim",
        },
        config = function()
            -- https://github.com/ThePrimeagen/harpoon/blob/2cd4e03372f7ee5692c8caa220f479ea07970f17/lua/harpoon/list.lua#L7C1-L21C4
            local function index_of(items, element, config)
                local equals = config and config.equals or function(a, b) return a == b end
                local index = -1
                for i, item in ipairs(items) do
                    if equals(element, item) then
                        index = i
                        break
                    end
                end

                return index
            end

            local function harpoonStatusLine()
                local harpoon = require("harpoon")
                local list = harpoon:list()

                local item = list.config.create_list_item(list.config)
                local index = index_of(list.items, item, list.config)
                if index == -1 then return "" end

                return index
            end

            -- https://github.com/Exafunction/codeium.vim#show-codeium-status-in-statusline
            local function codeiumStatusLine()
                return "{…}" .. vim.api.nvim_call_function("codeium#GetStatusString", {})
            end

            require("lualine").setup({
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = {
                        {
                            "filename",
                            newfile_status = true,
                            path = 1,
                        },
                        function()
                            return require("lsp-progress").progress({
                                spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
                                spin_update_time = 150,
                            })
                        end,
                    },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = {
                        {
                            harpoonStatusLine,
                            icon = "󰛢",
                        },
                        codeiumStatusLine,
                    },
                    lualine_z = { "progress", "location" },
                },
            })

            vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
            vim.api.nvim_create_autocmd("User", {
                group = "lualine_augroup",
                pattern = "LspProgressStatusUpdated",
                callback = require("lualine").refresh,
            })
        end,
    },
    {
        "linrongbin16/lsp-progress.nvim",
        config = true,
    },
}
