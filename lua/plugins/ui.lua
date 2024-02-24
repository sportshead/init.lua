return {
    {
        "norcalli/nvim-colorizer.lua",
        config = true,
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        "aznhe21/actions-preview.nvim",
        keys = {
            { "gf", function() require("actions-preview").code_actions() end, mode = { "v", "n" } },
        },
    },
    {
        "rcarriga/nvim-notify",
        config = function() vim.notify = require("notify") end,
    },
}
