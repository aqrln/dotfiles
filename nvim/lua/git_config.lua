require('gitsigns').setup {}

require('diffview').setup {
  -- use_icons = false,
  -- signs = {
  --   fold_closed = ">",
  --   fold_open = "v",
  -- }
}

require('neogit').setup {
  integrations = {
    diffview = true
  }
}

vim.api.nvim_set_keymap('n', '<space>g', ':Neogit<CR>', { noremap = true, silent = true })
