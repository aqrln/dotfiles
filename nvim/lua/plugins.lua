local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
  'folke/lazy.nvim',

  {
    'tpope/vim-dispatch',
    lazy = true,
    cmd = { 'Dispatch', 'Make', 'Focus', 'Start' }
  },

  'editorconfig/editorconfig-vim',

  'windwp/nvim-autopairs',

  'tpope/vim-commentary',

  'tpope/vim-surround',

  'tpope/vim-repeat',

  'tpope/vim-unimpaired',

  'tpope/vim-abolish',

  'rebelot/kanagawa.nvim',

  'EdenEast/nightfox.nvim',

  -- use 'shaunsingh/solarized.nvim'
  'ishan9299/nvim-solarized-lua',

  {
    'ellisonleao/gruvbox.nvim',
    config = true
  },

  {
    "catppuccin/nvim",
    name = "catppuccin"
  },

  'bluz71/vim-nightfly-guicolors',

  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end
  },

  'neovim/nvim-lspconfig',

  'folke/neoconf.nvim',

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
  },

  'nvim-treesitter/playground',

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    }
  },

  'nvim-telescope/telescope-ui-select.nvim',

  'gpanders/editorconfig.nvim',

  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },

  {
    'sindrets/diffview.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons'
    }
  },

  {
    'TimUntersberger/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    }
  },

  'tpope/vim-fugitive',

  'rhysd/git-messenger.vim',

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true }
  },

  'L3MON4D3/LuaSnip',

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      -- { 'tzachar/cmp-tabnine', build = './install.sh' },
    }
  },

  'onsails/lspkind-nvim',

  -- 'lukas-reineke/indent-blankline.nvim',

  'pantharshit00/vim-prisma',

  'folke/which-key.nvim',

  'nvimtools/none-ls.nvim',

  'MunifTanjim/prettier.nvim',

  'nvim-tree/nvim-tree.lua',

  {
    'mrcjkb/rustaceanvim',
    lazy = false,
  },

  'mfussenegger/nvim-dap',

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
  },

  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" }
  },

  {
    "microsoft/vscode-js-debug",
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && rm -rf out && mv dist out && git checkout .",
  },

  -- 'akinsho/bufferline.nvim',

  'LnL7/vim-nix',

  'direnv/direnv.vim',

  {
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    }
  },

  -- 'nvim-orgmode/orgmode',

  -- 'akinsho/org-bullets.nvim',

  'akinsho/git-conflict.nvim',

  {
    'j-hui/fidget.nvim',
    event = "LspAttach",
    tag = "legacy",
    config = function()
      require('fidget').setup()
    end
  },

  'b0o/schemastore.nvim',

  {
    'stevearc/oil.nvim',
    opts = {
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      view_options = {
        show_hidden = true,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "NoahTheDuke/vim-just",
    ft = { "just" },
  },

  'compnerd/arm64asm-vim',

  'pest-parser/pest.vim',

  'github/copilot.vim',
  -- {
  --   'zbirenbaum/copilot.lua',
  --   opts = {
  --     filetypes = {
  --       yaml = true,
  --       markdown = true,
  --       help = false,
  --       gitcommit = true,
  --       gitrebase = false,
  --       ["."] = true,
  --     },
  --   },
  -- },

  'folke/neodev.nvim',

  'yioneko/nvim-vtsls',

  'windwp/nvim-ts-autotag',

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  "marilari88/neotest-vitest",

  {
    "davidmh/mdx.nvim",
    config = true,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = "claude",
      auto_suggestions_provider = "claude",
      behaviour = {
        -- auto_suggestions = true,
      },
    },
    build = (function()
      if vim.fn.has("unix") and vim.fn.system("uname -s") == "Linux\n" and
          vim.fn.system("grep -qi nixos /etc/os-release; echo $?") == "0\n" then
        return "nix-shell -p pkg-config openssl --run 'OPENSSL_STATIC=1 make BUILD_FROM_SOURCE=true'"
      else
        return "make BUILD_FROM_SOURCE=true"
      end
    end)(),
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      -- "zbirenbaum/copilot.lua",      -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
  },

  'whiteinge/diffconflicts',
})
