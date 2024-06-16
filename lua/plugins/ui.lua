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
    {
        "stevearc/dressing.nvim",
        config = true,
    },
    {
        "andythigpen/nvim-coverage",
        config = true,
        cmd = {
            "Coverage",
            "CoverageLoad",
            "CoverageLoadLcov",
            "CoverageShow",
            "CoverageHide",
            "CoverageToggle",
            "CoverageClear",
            "CoverageSummary",
        },
    },
}
