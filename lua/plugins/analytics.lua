return {
    {
        "andweeb/presence.nvim",
        event = "VeryLazy",
        opts = {
            buttons = true,
        },
        build = "git apply ~/.config/nvim/patches/presence.nvim.patch",
    },
    {
        "wakatime/vim-wakatime",
        event = "VeryLazy",
    },
}
