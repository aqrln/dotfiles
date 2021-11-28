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
end)
