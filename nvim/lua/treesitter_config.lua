local max_lines = 10000

require('orgmode').setup_ts_grammar()

require('nvim-treesitter.configs').setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    'bash', 'c', 'cpp', 'javascript', 'json', 'lua', 'make', 'nix', 'org',
    'prisma', 'rust', 'sql', 'toml', 'typescript', 'vim', 'yaml', 'zig',
  },
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
    additional_vim_regex_highlighting = {'org'},
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

  playground = {
    enable = false,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
}
