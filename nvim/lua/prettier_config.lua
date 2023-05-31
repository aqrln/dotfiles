local prettier = require('prettier')

prettier.setup {
  bin = 'prettier',
  filetypes = {
    'css',
    'graphql',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'less',
    'markdown',
    'scss',
    'typescript',
    'typescriptreact',
    'yaml',
  },

  arrow_parens = 'always',
  bracket_spacing = true,
  embedded_language_formatting = 'auto',
  end_of_line = 'lf',
  html_whitespace_sensitivity = 'css',
  jsx_bracket_same_line = false,
  jsx_single_quote = false,
  print_width = 120,
  prose_wrap = 'preserve',
  quote_props = 'as-needed',
  semi = true,
  single_quote = false,
  tab_width = 2,
  trailing_comma = 'es5',
  use_tabs = false,
  vue_indent_script_and_style = false,
}

vim.api.nvim_set_keymap('n', '<space>pP', '<cmd>Prettier<CR>', {
  noremap = true,
  silent = true,
})
