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
    cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
  },

  'editorconfig/editorconfig-vim',

  'windwp/nvim-autopairs',

  'tpope/vim-commentary',

  'tpope/vim-surround',

  'tpope/vim-repeat',

  'tpope/vim-unimpaired',

  'rebelot/kanagawa.nvim',

  'EdenEast/nightfox.nvim',

  -- use 'shaunsingh/solarized.nvim'
  'ishan9299/nvim-solarized-lua',

  'ellisonleao/gruvbox.nvim',

  { "catppuccin/nvim", name = "catppuccin" },

  'bluz71/vim-nightfly-guicolors',

  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end
  },

  'neovim/nvim-lspconfig',

  'folke/lsp-colors.nvim',

  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

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
    version = '^3',
    ft = { 'rust' },
  },

  'mfussenegger/nvim-dap',

  -- 'akinsho/bufferline.nvim',

  'LnL7/vim-nix',

  'direnv/direnv.vim',

  {
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    }
  },

  'nvim-orgmode/orgmode',
  
  'akinsho/org-bullets.nvim',

  'akinsho/git-conflict.nvim',

  {
    'j-hui/fidget.nvim',
    event = "LspAttach",
    tag = "legacy",
    config = function()
      require('fidget').setup()
    end
  },

  -- {
  --   'pwntester/octo.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-telescope/telescope.nvim',
  --     'nvim-tree/nvim-web-devicons',
  --   },
  --   config = function ()
  --     require('octo').setup()
  --   end
  -- },

  'b0o/schemastore.nvim',
})
