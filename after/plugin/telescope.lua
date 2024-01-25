local builtin = require("telescope.builtin")

require("telescope").setup({
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    },
})
require("telescope").load_extension("fzf")

-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#find-files-from-project-git-root-with-fallback
local function get_git_root() return vim.fn.system("git rev-parse --show-toplevel"):gsub("%s+$", "") end
local function find_files()
    local opts = {}
    local root = get_git_root()

    if vim.v.shell_error == 0 then opts = { cwd = root } end
    if root == os.getenv("HOME") then opts = { no_ignore = true } end

    builtin.find_files(opts)
end
local function live_grep()
    local opts = {}
    local root = get_git_root()

    if vim.v.shell_error == 0 then opts = { cwd = root } end

    builtin.live_grep(opts)
end

vim.keymap.set("n", "<leader>pf", find_files, {})
vim.keymap.set("n", "<leader>pg", live_grep, {})
vim.keymap.set("n", "<leader>.", function() builtin.find_files({ cwd = vim.fn.expand("%:p:h") }) end)
vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
vim.keymap.set("n", "<leader>pp", builtin.git_files, {})
