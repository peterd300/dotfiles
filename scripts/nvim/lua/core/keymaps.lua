local map = vim.keymap.set



-- open filetree plugin
map("n", "<leader>e", ":Ex<CR>", { desc = "File explorer (netrw)" })

map("n", "<leader>w", ":w<CR>", { desc = "Save" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>e", ":Ex<CR>", { desc = "File explorer (netrw)" })

-- move between splits easily
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
