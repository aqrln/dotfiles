local max_lines = 10000

require('nvim-treesitter.configs').setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    'bash', 'c', 'cmake', 'comment', 'cpp', 'css', 'csv', 'dhall', 'diff', 'disassembly',
    'dockerfile', 'dot', 'fish', 'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore',
    'glsl', 'gn', 'gnuplot', 'go', 'gosum', 'gpg', 'graphql', 'haskell', 'hcl', 'html', 'http', 'ini',
    'javascript', 'jq', 'jsdoc', 'json', 'jsonc', 'just', 'kdl', 'latex', 'linkerscript', 'llvm', 'lua',
    'make', 'markdown', 'markdown_inline', 'nix', 'prisma', 'proto', 'python', 'query', 'regex',
    'rust', 'scss', 'sql', 'tmux', 'toml', 'tsx', 'typescript', 'vim', 'vimdoc', 'wgsl', 'yaml', 'zig',
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
    additional_vim_regex_highlighting = {},
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

require('nvim-ts-autotag').setup {
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false -- Auto close on trailing </
  },
  -- Also override individual filetype configs, these take priority.
  -- Empty by default, useful if one of the "opts" global settings
  -- doesn't work well in a specific filetype
  per_filetype = {}
}
