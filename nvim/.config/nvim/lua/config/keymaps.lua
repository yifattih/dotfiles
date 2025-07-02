local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Clear search highlight
map("n", "<leader>h", ":nohlsearch<CR>", opts)

-- jj to escape insert mode
map("i", "jj", "<ESC>", opts)

-- Telescope bindings
map("n", "<leader>ff", "<CMD>Telescope find_files<CR>", opts)
map("n", "<leader>fg", "<CMD>Telescope live_grep<CR>", opts)
map("n", "<leader>fb", "<CMD>Telescope buffers<CR>", opts)
map("n", "<leader>fh", "<CMD>Telescope help_tags<CR>", opts)
map("n", "<leader>fm", "<CMD>Telescope noice<CR>", opts)

-- NERDTree
map("n", "<C-n>", ":NERDTreeToggle<CR>", opts)

-- Run file in tmux
map("n", "<leader>r", function()
  require("utils.tmux_runner").run_current_file()
end, opts)
