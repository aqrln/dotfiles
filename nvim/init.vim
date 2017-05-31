" ------------------------------------------------------------------------------
"  Neovim configuration.
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
"  PLUGINS
" ------------------------------------------------------------------------------

" First installation:
"   $ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   $ nvim +PlugInstall

call plug#begin('~/.local/share/nvim/plugged')

" Color schemes
Plug 'tomasr/molokai'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Syntax highlighting
Plug 'othree/html5.vim'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'lervag/vimtex'
Plug 'pangloss/vim-javascript'
Plug 'fleischie/vim-styled-components'
Plug 'arakashic/chromatica.nvim', { 'do': ':UpdateRemotePlugins' }

" Tmux integration
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'airblade/vim-gitgutter'

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-clang'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'zchee/deoplete-jedi'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'wellle/tmux-complete.vim'

" Save keystrokes
Plug 'easymotion/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" Substitutions improvement
Plug 'tpope/vim-abolish'

" Code comments
Plug 'scrooloose/nerdcommenter'

" Linters integration
Plug 'w0rp/ale'

" File and buffer management
Plug 'scrooloose/nerdtree'
Plug 'wincent/Command-T', {
  \   'do': 'cd ruby/command-t && ruby extconf.rb && make'
  \ }
Plug 'danro/rename.vim'

" Undo tree
Plug 'sjl/gundo.vim'

" Improvements for Node.js
Plug 'moll/vim-node'

" ASCII drawing
Plug 'vim-scripts/DrawIt'

" Maintain own working directories for tabs
Plug 'kana/vim-tabpagecd'

" Create and resize windows
Plug 'wellle/visual-split.vim'

" Search in project
Plug 'mileszs/ack.vim'

" LaTeX live reload
Plug 'donRaphaco/neotex', { 'for': 'tex', 'do': ':UpdateRemotePlugins' }

call plug#end()

" ------------------------------------------------------------------------------
"  SETTINGS
" ------------------------------------------------------------------------------

" Enable filetype detection, plugins loading and automatic indentation
filetype plugin indent on

" Enable syntax highlighting and setup colorscheme
syntax on
colorscheme molokai
set background=dark
set termguicolors

" Make status line informative
set ruler
set showmode
set showcmd

" Line numbers
set number
autocmd WinEnter,FocusGained * :setlocal number relativenumber
autocmd WinLeave,FocusLost   * :setlocal number norelativenumber

" Search settings
set incsearch
set hlsearch
set ignorecase
set smartcase
set gdefault

" Let files be opened over unsaved buffers
set hidden

" Restore the cursor position
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Move and delete through the lines
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]

" Text width and line wrapping
set nowrap
autocmd FileType text setlocal textwidth=80

" Enable mouse
set mouse=a
set mousehide

" Indentation settings
set shiftwidth=2
set softtabstop=2
set tabstop=2
set smarttab
set expandtab
set shiftround
autocmd FileType python setlocal sw=4 sts=4 et

" Disable bells
set novisualbell
set noerrorbells
set vb t_vb=

" File saving and reading
set autowrite
set autoread
set nobackup
set nowritebackup
set noswapfile

" Open new windows right and below
set splitbelow
set splitright

" Always show the status line
set laststatus=2

" Make commands and undo history bigger
set history=1000
set undolevels=1000

" File and path autocompletion
set path+=**
set wildignore=*.o,*.pyc,*.class,*.d,*/.git/*,*/node_modules/*,.DS_Store
set wildmenu

" Custom filetypes
autocmd BufRead,BufNewFile *.gyp  set filetype=python et ts=2 sw=2
autocmd BufRead,BufNewFile *.gypi set filetype=python et ts=2 sw=2
autocmd BufRead,BufNewFile DEPS   set filetype=python et ts=2 sw=2

" Enable spell cheking for certain types of files
autocmd FileType gitcommit setlocal spell
autocmd FileType text      setlocal spell
autocmd FileType plaintex  setlocal spell
autocmd FileType tex       setlocal spell

" Enable alternative keyboard layout (C-^ to switch)
set keymap=russian-jcukenmac
set iminsert=0
set imsearch=0

" delimitMate settings
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1

" Gundo settings
let g:gundo_right = 1
let g:gundo_close_on_revert = 1

" Markdown settings
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = [
  \ 'js=javascript', 'javascript', 'c', 'cpp', 'python', 'html',
  \ 'sh', 'bash=sh', 'console=sh'
  \ ]

" JavaScript settings
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

" ack.vim settings
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" vim-airline settings
let g:airline_theme = 'molokai'

" Chromatica settings
let g:chromatica#libclang_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
let g:chromatica#enable_at_startup = 1
let g:chromatica#responsive_mode = 1
let g:chromatica#highlight_feature_level = 1

" deoplete settings
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header = '/Library/Developer/CommandLineTools/usr/lib/clang'
let g:tern#filetypes = ['javascript', 'jsx', 'javascript.jsx']
let g:deoplete#sources#rust#rust_source_path = $RUST_SRC_PATH

" ALE settings
let g:ale_linters = {
  \   'c':         ['cppcheck',  'clang'],
  \   'cpp':       ['clangtidy', 'cppcheck', 'cpplint', 'clang'],
  \   'gitcommit': ['proselint', 'vale'],
  \   'text':      ['proselint', 'vale']
  \ }

" ------------------------------------------------------------------------------
"  KEYBINDINGS
" ------------------------------------------------------------------------------

" Setup a convenient leader key
let mapleader = ','

" Clear search highlighting
nmap <leader>/ :nohlsearch<CR>

" Git keybindings
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gl :Gitv<CR>

" Run tests
nnoremap <leader>nt :VimuxRunCommand('npm test')<CR>

" Fix style
nnoremap <leader>jsf :!eslint --fix %<CR>

" Run the file
nnoremap <leader>nj :VimuxRunCommand('node ' . bufname('%'))<CR>
nnoremap <leader>p3 :VimuxRunCommand('python3.6 ' . bufname('%'))<CR>
nnoremap <leader>pr :VimuxRunCommand('python ' . bufname('%'))<CR>
nnoremap <leader>lx :VimuxRunCommand('lualatex -pdf ' . bufname('%'))<CR>

" Show the undo tree
nnoremap <leader>u :GundoToggle<CR>

" Easier keyboard mappings for keyboard layout switching
inoremap <M-Space> <C-^>
nnoremap <M-Space> a<C-^><Esc>

" Some plugins setup their own keybindings, refer to their manuals to learn
" these keys.  E.g., C-{h,j,k,l} are used to seamlessly switch between Vim
" windows and tmux panes.
