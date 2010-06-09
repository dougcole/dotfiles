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

map - <c-w>w
set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P

colorscheme railscasts
setlocal spell spelllang=en_us
cd ~/workspace/estately


vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
