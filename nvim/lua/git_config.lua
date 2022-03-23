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

vim.api.nvim_set_keymap('n', '<space>g', ':Neogit<CR>', { noremap = true, silent = true })
