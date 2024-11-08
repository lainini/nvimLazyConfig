vim.g.mapleader = " "

local keymap = vim.keymap

-- ------- 插入模式 ------- --
keymap.set("i", "ei", "<ESC>")

-- ------- 可视模式 ------- --
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ------- 正常模式 ------- --
-- 打开新窗口
keymap.set("n", "<leader>sw", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- ------- 插件 ------- --
-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- buffer切换
keymap.set("n", "<leader>r", ":bnext<CR>")
keymap.set("n", "<leader>l", ":bprevious<CR>")
