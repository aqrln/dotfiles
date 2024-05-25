lua require('plugins')
lua require('lsp_config')
lua require('dap_config')
lua require('treesitter_config')
lua require('telescope_config')
lua require('git_config')
lua require('ui_config')
lua require('cmp_config')
lua require('prettier_config')
lua require('tree_config')
lua require('autopairs_config')
lua require('orgmode_config')
lua require('neovide_config')

set number
set nowrap

set mouse=a
set termguicolors
" colorscheme kanagawa
" set bg=light
" colorscheme solarized
set bg=dark
colorscheme gruvbox
" colorscheme catppuccin

set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

set hidden
set autowrite

set undofile

set splitbelow
set splitright

set path+=**
set wildignore=*.o,*.pyc,*.class,*/.git/*,*/node_modules/*,.DS_Store

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m,%f:%l:%m

augroup init
    autocmd!

    autocmd FileType text setlocal textwidth=80

    autocmd FileType json            setlocal sw=2 sts=2
    autocmd FileType lua             setlocal sw=2 sts=2
    autocmd FileType javascript      setlocal sw=2 sts=2
    autocmd FileType typescript      setlocal sw=2 sts=2
    autocmd FileType typescriptreact setlocal sw=2 sts=2
    autocmd FileType prisma          setlocal sw=2 sts=2
    autocmd FileType hcl             setlocal sw=2 sts=2
    autocmd FileType go              setlocal noet

    autocmd BufRead,BufNewFile *.gyp       set filetype=python et ts=2 sw=2
    autocmd BufRead,BufNewFile *.gypi      set filetype=python et ts=2 sw=2
    autocmd BufRead,BufNewFile DEPS        set filetype=python et ts=2 sw=2
    autocmd BufRead,BufNewFile .eslintrc   set filetype=json
    autocmd BufRead,BufNewFile .babelrc    set filetype=json
    autocmd BufRead,BufNewFile .prettierrc set filetype=json
    autocmd BufRead,BufNewFile .envrc      set filetype=bash
    autocmd BufRead,BufNewFile *.wat       set filetype=wast

    autocmd FileType gitcommit  setlocal spell
    autocmd FileType html       setlocal spell
    autocmd FileType markdown   setlocal spell
    autocmd FileType plaintex   setlocal spell
    autocmd FileType rst        setlocal spell
    autocmd FileType rust       setlocal spell
    autocmd FileType tex        setlocal spell
    autocmd FileType text       setlocal spell
    autocmd FileType typescript setlocal spell
augroup END

let mapleader = "\<Space>"

" Switch between buffers
nnoremap <silent> <C-n> :bn<CR>
nnoremap <silent> <C-p> :bp<CR>

" Grep for files
nnoremap <C-s> :copen<CR>:grep<Space>
nnoremap <leader>K :grep "\b<C-R><C-W>\b"<CR>:cw<CR>

" Open and close quickfix/location lists
nnoremap <M-c> :copen<CR>
nnoremap <M-C> :cclose<CR>
nnoremap <M-l> :lopen<CR>
nnoremap <M-L> :lclose<CR>

nnoremap ]c :cnext<CR>
nnoremap [c :cprev<CR>

nnoremap <silent> <M-h> :nohl<CR>

nnoremap <M-s> :w<CR>
" nnoremap <space>w :w<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <silent> - :Oil<CR>

nnoremap <space>q :quit<CR>

nnoremap <space>y "+y
vnoremap <space>y "+y
nnoremap <space>p "+p
vnoremap <space>p "+p
