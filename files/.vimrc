" Use monokai as the default scheme
colorscheme monokai
" Enable syntax highlighting
syntax on
" Enable mouse if possible
if has('mouse')
  set mouse=a
endif
" Use bash for external commands
set shell=/bin/bash
" Enable line numbers
set number
" Use 2 spaces for tabs
set expandtab
set tabstop=2
set shiftwidth=2
" Enable wildmenu
set wildmode=longest,list
set wildmenu
" Ignore cases when searching
set ignorecase
set smartcase
" Highligh search results
set hlsearch
" Highlight search match when typing
set incsearch
" Show status bar with custom format
set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
" Auto read file when edited from outside
set autoread
