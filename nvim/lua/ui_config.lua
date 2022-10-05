require('lualine').setup {
  options = {
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_c = {'filename'}, -- 'buffers' would be cool but doesn't work good when overflows
    lualine_x = {'filetype'},
  }
}

require('indent_blankline').setup {
  show_current_context = true,
  char = '│', -- could be fun to try something unconventional
  use_treesitter = true,
  enabled = false,
}

vim.api.nvim_set_keymap('n', '<M-i>', ':IndentBlanklineToggle<CR>', { noremap = true })

require('which-key').setup {
  icons = {
    separator = ''
  }
}

-- require('bufferline').setup {}
