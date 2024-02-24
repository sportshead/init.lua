return {
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        opts = {
            enable_autocmd = false,
        },
        lazy = true,
    },
    {
        "numToStr/Comment.nvim",
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        config = function()
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
    },
}
