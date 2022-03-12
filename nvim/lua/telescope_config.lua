require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- "ignore_case" or "respect_case"
    }
  }
}

require('telescope').load_extension('fzf')

local prefix = "<space>f"

local keybindings = {
  f = "find_files()",
  g = "live_grep()",
  b = "buffers()",
  h = "help_tags()",
}

for key, method in pairs(keybindings) do
  vim.api.nvim_set_keymap('n',
    prefix .. key,
    '<cmd>lua require("telescope.builtin").' .. method .. '<cr>',
    { noremap = true, silent = true })
end
