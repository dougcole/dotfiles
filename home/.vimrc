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

map - <c-w>w
map <c-j> :tabnext<Enter>
map <c-k> :tabprevious<Enter>
let g:proj_flags='igmst'
nmap  <F3> :NERDTree<Enter>
map <leader>t :FuzzyFinderTextMate<CR>
set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P

colorscheme railscasts
setlocal spell spelllang=en_us
cd ~/workspace/estately
set ic
set scs

vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
