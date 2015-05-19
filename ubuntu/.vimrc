set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'raimondi/delimitmate'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/tComment'

call vundle#end()
filetype plugin indent on

" Automatically reload .vimrc when saved
augroup reload_vimrc " {
	autocmd!
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Enable 256 colors in terminal
set t_Co=256

" Enable syntax highlighting
syntax enable

" Enable Solarized Dark
set background=dark
colorscheme solarized

" Remap Escape key to home row
imap jk <esc>

" Remap leader key to space bar
let mapleader=" "

" Navigate by visual rather than actual lines
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Open new split panes to right and bottom
set splitbelow
set splitright

" Always use vertical diffs
set diffopt+=vertical

" Enable Airline Powerline symbols
let g:airline_powerline_fonts = 1

" Remap CtrlP to CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Fix GitGutter column color
highlight clear SignColumn

" Comment and uncomment lines
nnoremap <leader>c :TComment<CR>

" Toggle Gundo
nnoremap <leader>g :GundoToggle<CR>

" Clear search highlighting
nnoremap <leader>h :noh<CR>

" Toggle NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

" Save file
nnoremap <leader>s :w<CR>

" Save file and quit
nnoremap <leader>q :wq<CR>

" Strip whitespace
nnoremap <leader>w :StripWhitespace<CR>

" Check for syntax errors on open
let g:syntastic_check_on_open = 1

" Assign syntax checkers to specific filetypes
let g:syntastic_javascript_checkers = ['jshint']

" Stop html-tidy from finding false errors in Handlebars files
let g:syntastic_filetype_map = { 'html.handlebars': 'handlebars' }

" Use 'HTML Tidy for HTML5' instead of 'HTML Tidy'
let g:syntastic_html_tidy_exec = 'tidy5'

" Automatically recognize filetypes by extension
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile, *.hbs set filetype=html.handlebars syntax=mustache

" Enable spellchecking for Markdown
autocmd fileType markdown setlocal spell

" Disable highlighting of non-capitalized terms
set spellcapcheck=

" Core non-plugin Vim settings
set autoindent
set autoread
set backspace=indent,eol,start
set backupdir=$HOME/.vim/tmp/backup
set clipboard=unnamed
set complete-=i
set directory=$HOME/.vim/tmp/swap
set encoding=utf8
set fileformats+=unix,mac,dos
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set nofoldenable
set noshowmode
set nrformats-=octal
set number
set relativenumber
set ruler
set shiftwidth=2
set showcmd
set showmatch
set softtabstop=2
set smartcase
set smartindent
set smarttab
set tabstop=2
set ttimeout
set ttimeoutlen=100
set ttyfast
set undodir=$HOME/.vim/tmp/undo
set undofile
set undolevels=1000
set undoreload=1000
set wildmenu
set wildmode=list:longest,full