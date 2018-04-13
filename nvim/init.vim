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

" Support Node.js plugins
Plug 'neovim/node-host', { 'do': 'npm install' }

" Color schemes
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'

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
Plug 'rust-lang/rust.vim'
Plug 'OrangeT/vim-csharp'
Plug 'cespare/vim-toml'
Plug 'elzr/vim-json'

" Tmux integration
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tmux-plugins/vim-tmux'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'roxma/vim-tmux-clipboard'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'mhinz/vim-signify'

" Language Server
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-clang'
Plug 'zchee/deoplete-jedi'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'wellle/tmux-complete.vim'
Plug 'zchee/deoplete-go', { 'do': 'make' }

" Documentation
Plug 'Shougo/echodoc.vim'
Plug 'rhysd/rust-doc.vim'

" Save keystrokes
Plug 'easymotion/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" Substitutions improvement
Plug 'tpope/vim-abolish'

" Code comments
Plug 'tpope/vim-commentary'

" Linters integration
Plug 'w0rp/ale'

" File and buffer management
Plug 'scrooloose/nerdtree'
Plug 'danro/rename.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Undo tree
Plug 'sjl/gundo.vim'

" Improvements for Node.js
Plug 'moll/vim-node'

" Frontend development
Plug 'KabbAmine/vCoolor.vim'

" Clojure and Lisp
Plug 'tpope/vim-salve'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace'
Plug 'kovisoft/paredit'

" ReasonML
Plug 'reasonml-editor/vim-reason-plus'

" ASCII drawing
Plug 'vim-scripts/DrawIt'

" Maintain own working directories for tabs
Plug 'kana/vim-tabpagecd'

" Create and resize windows
Plug 'wellle/visual-split.vim'

" Search in project
Plug 'mileszs/ack.vim'

" Icons
Plug 'ryanoasis/vim-devicons'

call plug#end()

" ------------------------------------------------------------------------------
"  SETTINGS
" ------------------------------------------------------------------------------

" Enable filetype detection, plugins loading and automatic indentation
filetype plugin indent on

" Enable syntax highlighting and setup colorscheme
syntax on
set background=dark
set termguicolors
colorscheme gruvbox

" This is only needed for Molokai since the background color doesn't match the
" one that Molokai colorscheme for my terminal uses.
"
" highlight Normal ctermbg=none
" highlight NonText ctermbg=none
" highlight Normal guibg=none
" highlight NonText guibg=none

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
autocmd FileType cs     setlocal sw=4 sts=4 et

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

autocmd BufRead,BufNewFile .eslintrc set filetype=json
autocmd BufRead,BufNewFile .babelrc  set filetype=json

" Enable spell cheking for certain types of files
autocmd FileType gitcommit setlocal spell
autocmd FileType text      setlocal spell
autocmd FileType plaintex  setlocal spell
autocmd FileType tex       setlocal spell
autocmd FileType markdown  setlocal spell
autocmd FileType rst       setlocal spell

" Format Go sources automatically
" autocmd BufWritePost *.go !goimports -w %
" autocmd FileType go autocmd BufWritePre <buffer> !goimports -w %

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
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
elseif executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" vim-airline settings
let g:airline_theme = 'gruvbox'

" Chromatica settings
let g:chromatica#libclang_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
let g:chromatica#enable_at_startup = 1
let g:chromatica#responsive_mode = 1
let g:chromatica#highlight_feature_level = 1

" deoplete settings
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header = '/Library/Developer/CommandLineTools/usr/lib/clang'
let g:deoplete#sources#rust#racer_binary = expand('~/.cargo/bin/racer')
let g:deoplete#sources#rust#rust_source_path = $RUST_SRC_PATH
let g:deoplete#sources#rust#show_duplicates = 0

" ALE settings
let g:ale_linters = {
  \   'c':         ['cppcheck',  'clang'],
  \   'cpp':       ['clangtidy', 'cppcheck', 'cpplint', 'clang'],
  \   'gitcommit': ['proselint', 'vale'],
  \   'text':      ['proselint', 'vale']
  \ }

" LanguageClient settings

" Alternative language server for JavaScript:
"  \ 'javascript': ['flow-language-server', '--stdio'],
"  \ 'javascript.jsx': ['flow-language-server', '--stdio'],
"
let g:LanguageClient_serverCommands = {
  \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
  \ 'javascript': ['javascript-typescript-stdio'],
  \ 'javascript.jsx': ['javascript-typescript-stdio'],
  \ 'reason': ['ocaml-language-server', '--stdio'],
  \ 'ocaml': ['ocaml-language-server', '--stdio'],
  \ }

" ------------------------------------------------------------------------------
"  COMMANDS
" ------------------------------------------------------------------------------

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '
  \     . shellescape(<q-args>),
  \   1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" ------------------------------------------------------------------------------
"  KEYBINDINGS
" ------------------------------------------------------------------------------

" Setup a convenient leader key
let mapleader = ' '

" Clear search highlighting
nmap <leader>/ :nohlsearch<CR>

" Git keybindings
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gl :Gitv<CR>

" Run tests
nnoremap <leader>nt :VimuxRunCommand('npm test')<CR>
" LanguageClient keybindings
nnoremap <CR> :call LanguageClient_textDocument_hover()<CR>
nnoremap <leader>ld :call LanguageClient_textDocument_definition()<CR>
nnoremap <leader>lf :call LanguageClient_textDocument_formatting()<CR>
nnoremap <leader>lrr :call LanguageClient_textDocument_rename()<CR>
nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <leader>lrf :call LanguageClient_textDocument_references()<CR>
nnoremap <leader>lws :call LanguageClient_textDocument_workspace_symbol()<CR>

" Fix style
nnoremap <leader>jsf :!eslint --fix %<CR>
nnoremap <leader>rf :RustFmt<CR>

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

" Jump through the quickfix list
nnoremap <M-n> :cnext<CR>
nnoremap <M-p> :cprevious<CR>

" Open fzf window
nnoremap <leader>o :Files<CR>
nnoremap <leader>p :GFiles<CR>
nnoremap <leader>b :Buffers<CR>

" Some plugins setup their own keybindings, refer to their manuals to learn
" these keys.  E.g., C-{h,j,k,l} are used to seamlessly switch between Vim
" windows and tmux panes.
