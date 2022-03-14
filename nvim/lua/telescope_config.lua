require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = 'smart_case',        -- 'ignore_case' or 'respect_case'
    }
  }
}

require('telescope').load_extension('fzf')

local prefix = '<space>'

local keybindings = {
  [' '] = 'builtin()',

  fr = 'resume()',
  ff = 'find_files()',
  fF = 'git_files()',
  fg = 'live_grep()',
  fG = 'grep_string()',
  fb = 'buffers()',
  fh = 'help_tags()',

  lr = 'lsp_references()',
  ls = 'lsp_document_symbols()',
  lS = 'lsp_dynamic_workspace_symbols()',
  la = 'lsp_code_actions()',
  lA = 'lsp_range_code_actions()',
  lD = 'diagnostics()',
  li = 'lsp_implementations()',
  ld = 'lsp_definitions()',
  lt = 'lsp_type_definitions()',
}

for key, method in pairs(keybindings) do
  vim.api.nvim_set_keymap('n',
    prefix .. key,
    '<cmd>lua require("telescope.builtin").' .. method .. '<cr>',
    { noremap = true, silent = true })
end
