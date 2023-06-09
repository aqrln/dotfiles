require('gitsigns').setup {}

require('diffview').setup {
  -- use_icons = false,
  -- signs = {
  --   fold_closed = ">",
  --   fold_open = "v",
  -- }
}

require('neogit').setup {
  disable_commit_confirmation = true,

  integrations = {
    diffview = true
  },

  signs = {
    section = { "", "" },
    item = { "", "" },
    hunk = { "", "" },
  },
}

require('git-conflict').setup {}

vim.api.nvim_set_keymap('n', '<space>gg', ':Neogit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>gm', ':GitMessenger<CR>', { noremap = true, silent = true })
