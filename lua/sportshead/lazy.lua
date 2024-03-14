local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

local function patch(git_string)
    git_string = git_string or "silent !git -C %s apply %s"

    return function()
        local config_dir = vim.fn.stdpath("config")
        local patches_dir = config_dir .. "/patches"

        for _, patch_file in ipairs(vim.fn.readdir(patches_dir)) do
            local plugin = patch_file:match("^(.+)%.patch$")
            if not plugin then
                vim.notify("Invalid patch file name: " .. patch_file, vim.log.levels.ERROR, { title = "Patcher" })
            else
                local plugin_dir = vim.fn.stdpath("data") .. "/lazy/" .. plugin
                vim.cmd(string.format(git_string, plugin_dir, patches_dir .. "/" .. patch_file))
            end
        end
    end
end

vim.api.nvim_create_autocmd("User", {
    pattern = "LazyUpdatePre",
    callback = patch("silent !git -C %s apply -R %s"),
})

vim.api.nvim_create_autocmd("User", {
    pattern = "LazyInstall",
    callback = patch(),
})

vim.api.nvim_create_autocmd("User", {
    pattern = "LazyUpdate",
    callback = patch(),
})
