require('nvim-tree').setup {
  hijack_netrw = false,
  git = {
    ignore = false,
  },
}

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<space>to', '<cmd>NvimTreeOpen<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>tc', '<cmd>NvimTreeClose<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>tf', '<cmd>NvimTreeFindFile<CR>', opts)
