local opt = vim.opt
local g = vim.g

-- 行号
opt.number = true
opt.relativenumber = true

-- 缩进
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- 防止包裹
opt.wrap = false

-- 光标
opt.cursorline = true

-- 启用鼠标
opt.mouse:append("a")

-- 系统剪贴版
opt.clipboard:append("unnamedplus")
g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
  cache_enabled = 0,  -- 可选，设为0以确保每次都从系统剪贴板获取最新内容
}

-- 默认新窗口位置
opt.splitright = true
opt.splitbelow = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true

-- 外观
opt.termguicolors = true
opt.signcolumn = "yes"

-- tokyonight配置
vim.cmd[[colorscheme tokyonight-night]]

-- nvim-treesitter配置
require"nvim-treesitter.configs".setup{
  -- 添加解析的语言
  ensure_installed = { "vim", "vimdoc", "lua", "bash", "c", "javascript", "json", "python", "html", "css", "scss"},
  highlight = { enable = true },
  indent = { enable = true },
}

-- lualin配置
require("lualine").setup({
  options = {
    theme = "tokyonight"
  }
})

-- nvimtree配置
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()

-- mason的lsp配置
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup({
    ensure_installed = {
      "lua_ls",
    },
})
-- 使得lsp与自动补全结合
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require("lspconfig").lua_ls.setup {
    capabilities = capabilities,
}

-- comment配置
require("Comment").setup()

-- buffer加载
vim.opt.termguicolors = true
require("bufferline").setup {
    options = {
        -- 使用 nvim 内置lsp
        diagnostics = "nvim_lsp",
        -- 左侧让出 nvim-tree 的位置
        offsets = {{
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left"
        }}
    }
}

-- autopairs配置
local npairs_ok, npairs = pcall(require, "nvim-autopairs")
if not npairs_ok then
  return
end

npairs.setup {
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
  },
  fast_wrap = {
    map = '<M-e>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'Search',
    highlight_grey='Comment'
  },
}
-- 配置这个使得自动补全会把括号带上
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

-- gitsigns配置
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- telescope配置
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- indent-blankline配置
require("ibl").setup({
  indent = {
    char = "│",
  },
})
