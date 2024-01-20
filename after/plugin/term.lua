local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

vim.keymap.set("n", "<leader>g", function()
    lazygit:toggle()
end)

vim.keymap.set("n", "<leader>t", '<cmd>exe v:count1 . "ToggleTerm"<cr>')

vim.keymap.set("t", "<C-q>", "<C-\\><C-n>")
