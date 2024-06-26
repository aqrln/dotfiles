local telescope = require('telescope')
local actions = require('telescope.actions')
local trouble = require('trouble.sources.telescope')

telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },

    ['ui-select'] = {
      require('telescope.themes').get_dropdown {}
    },
  },

  defaults = {
    mappings = {
      i = {
        ['<c-j>'] = trouble.open,
      },
      n = {
        ['<c-j>'] = trouble.open,
      },
    },
  },

  pickers = {
    buffers = {
      mappings = {
        i = {
          ['<c-d>'] = actions.delete_buffer,
        },
        n = {
          ['<c-d>'] = actions.delete_buffer,
        },
      },
    },
  },
}

telescope.load_extension('fzf')
telescope.load_extension('ui-select')

local prefix = '<space>'

local keybindings = {
  [' '] = 'builtin()',

  bb = 'buffers()',

  fr = 'resume()',
  ff = 'find_files({ hidden = true })',
  fF = 'find_files({ hidden = true, no_ignore = true, no_ignore_parent = true })',
  fg = 'live_grep()',
  fG = 'grep_string()',
  fb = 'buffers()',
  fh = 'help_tags()',

  flr = 'lsp_references()',
  fls = 'lsp_document_symbols()',
  flS = 'lsp_dynamic_workspace_symbols()',
  flD = 'diagnostics()',
  fli = 'lsp_implementations()',
  fld = 'lsp_definitions()',
  flt = 'lsp_type_definitions()',
}

for key, method in pairs(keybindings) do
  vim.api.nvim_set_keymap('n',
    prefix .. key,
    '<cmd>lua require("telescope.builtin").' .. method .. '<cr>',
    { noremap = true, silent = true })
end
