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
end)
