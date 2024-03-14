return {
    {
        "andweeb/presence.nvim",
        opts = {
            buttons = true,
        },
        build = "sleep 10 && git apply ~/.config/nvim/patches/presence.nvim.patch",
    },
    "wakatime/vim-wakatime",
}
