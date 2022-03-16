local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'tpope/vim-dispatch',
    opt = true,
    cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
  }

  use 'editorconfig/editorconfig-vim'

  use 'jiangmiao/auto-pairs'

  use 'tpope/vim-commentary'

  use 'tpope/vim-surround'

  use 'tpope/vim-repeat'

  use 'tpope/vim-unimpaired'

  use 'rebelot/kanagawa.nvim'

  use 'ggandor/lightspeed.nvim'

  use 'neovim/nvim-lspconfig'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    }
  }

  use 'gpanders/editorconfig.nvim'

  use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }

  use {
    'sindrets/diffview.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons'
    }
  }

  use {
    'TimUntersberger/neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    }
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use 'L3MON4D3/LuaSnip'

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      { 'tzachar/cmp-tabnine', run = './install.sh' },
    }
  }

  use 'onsails/lspkind-nvim'
end)
