set nocompatible
set nofoldenable
syntax on
filetype on
filetype indent on
filetype plugin on

set autoindent
set shiftwidth=2
set softtabstop=2
set smartindent
set incsearch
"set ignore case
set ic
"but use smart search - override rc when capitalization exists in the search
"term
set scs
set hidden

"Shorcuts to move around a split screen
map - <c-w>w
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l

set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P

colorscheme railscasts
setlocal spell spelllang=en_us
cd ~/workspace/estately


vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" GUI is running or is about to start.
" Maximize gvim window.
if has("gui_running")
  set lines=999 columns=999
endif

