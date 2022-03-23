local max_lines = 1000

require('nvim-treesitter.configs').setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",
  sync_install = false,
  ignore_install = {},

  highlight = {
    enable = true,

    disable = function(lang, bufnr)
      return vim.api.nvim_buf_line_count(bufnr) > max_lines
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,

    disable = function(lang, bufnr)
      return vim.api.nvim_buf_line_count(bufnr) > max_lines or lang ~= "prisma"
    end,
  },

  incremental_selection = {
    enable = true,

    disable = function(lang, bufnr)
      return vim.api.nvim_buf_line_count(bufnr) > max_lines
    end,

    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

