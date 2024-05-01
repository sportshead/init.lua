return {
    {
        "andweeb/presence.nvim",
        opts = {
            buttons = true,
        },
        build = "git apply ~/.config/nvim/patches/presence.nvim.patch",
    },
    "wakatime/vim-wakatime",
}
