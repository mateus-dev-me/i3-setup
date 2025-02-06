require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v"}, "<C-q>", "<cmd> q <cr>")
map({ "n", "i", "v"}, "<C-s>", "<cmd> w <cr>")
map({ "n", "i", "v"}, "<C-f>", "<cmd> Telescope find_files <cr>")
map({ "n", "i", "v"}, "<C-p>", "<cmd> Telescope grep_string <cr>")

-- vim move
require('move').setup({})
map({"n", "v"}, "<C-j>", "<cmd> MoveLine 1 <cr>")
map({"n",  "v"}, "<C-k>", "<cmd> MoveLine -1 <cr>")




