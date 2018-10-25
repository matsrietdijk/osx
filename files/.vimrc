" eUse monokai as the default scheme
colorscheme monokai
" Change mapleader
let mapleader="\<Space>"
" Enable syntax highlighting
syntax on
" Enable mouse if possible
if has('nmouse')
  set mouse=a
endif
" Allow better mouse support (even after col 223)
if has("mouse_sgr")
  set ttymouse=sgr
else
  set ttymouse=xterm2
end
" Speed up Vim by not loading fish
set shell=/bin/bash\ -i
" Enable y/p with system clipboard
set clipboard^=unnamed,unnamedplus
" Enable line numbers
set relativenumber
" Disable line wrapping
set nowrap
" Use 4 spaces for tabs
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
" Swap splits default
set splitright
set splitbelow
" Allow backspace
set backspace=indent,eol,start
" Highlight matching parenthesis-like characters
set showmatch
" Show incomplete commands
set showcmd
" Highlight current line
set cursorline
" Disable swp files
set noswapfile
" Enable wildmenu
set wildmode=longest:list,full
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
" set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
" Auto read file when edited from outside
set autoread
" Auto write file when rugging commands
set autowrite
" Enable subdir finds
set path+=**
" Enable filetype detection, plugin en indent
filetype plugin indent on
" Enable autoindent
set autoindent
" Always show signcolumn
set signcolumn=yes
highlight SignColumn ctermbg=237
" Display extra whitespace
set list listchars=tab:>·,trail:·,nbsp:·
" Use The Silver Searcher
if executable('ag')
    set grepprg=ag\ --vimgrep
    let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
    " let g:ctrlp_use_caching=0
    let g:ackprg='ag --vimgrep'
endif
" CtrlP
let g:ctrlp_map=''
" NERDTree
let NERDTreeShowHidden=1
" EasyMotion
let g:EasyMotion_do_mapping=0
" Tcomment
let g:tcommentMaps=0
" Airline
let g:airline_theme='minimalist'
let g:airline_powerline_fonts=1
" GitGutter
let g:gitgutter_map_keys=0
" Fugitive
let g:fugitive_no_maps=1
" Leader mappings
nmap <Leader>/ :Ack!<Space>
nnoremap <Leader><Tab> :b#<Cr>

nmap <Leader>tn :NERDTreeToggle<Cr>
nmap <Leader>tl <Plug>(ale_toggle)
nmap <Leader>tr :set invnumber invrelativenumber<Cr>
nmap <Leader>tw :set list!<Cr>

nmap <Leader>pd :CtrlPCurWD<Cr>
nmap <Leader>pf :CtrlPCurFile<Cr>
nmap <Leader>pp :CtrlPRoot<Cr>
nmap <Leader>pI :CtrlPClearAllCaches<Cr>

nmap <Leader>fR :Rename<Cr>
nmap <Leader>fD :Delete<Cr>

nmap <Leader>bb :CtrlPBuffer<Cr>

nmap <Leader>nr :NERDTreeFind<Cr>

nmap <Leader>jf <Plug>(easymotion-overwin-f)
nmap <Leader>jj <Plug>(easymotion-s)

nmap <Leader>gb :GBlame<Cr>

xmap <Leader>; <Plug>TComment_gc
omap <Leader>; <Plug>TComment_gc
nmap <Leader>; <Plug>TComment_gc
nmap <Leader>;; <Plug>TComment_gcc
" Navigation movements
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
