return {
    {
        "stevearc/oil.nvim",
        opts = {
            view_options = {
                is_hidden_file = function(name)
                    if name == ".git" then return true end
                    if name == "node_modules" then return true end

                    return false
                end,
            },
        },
        keys = {
            { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
        },
        lazy = false,
    },
}
