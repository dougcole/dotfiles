set nocompatible
set nofoldenable
call pathogen#runtime_append_all_bundles()
syntax enable
filetype on
filetype indent on
filetype plugin on

set autoindent
set softtabstop=2
set tabstop=2 shiftwidth=2 expandtab
set smartindent

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set incsearch
"set ignore case
set ic
"but use smart search - override rc when capitalization exists in the search
"term
set scs
set hidden

set list                     " show whitespace
set listchars=tab:»·,trail:· " show tabs and trailing spaces
set listchars+=extends:»     " show a » when a line goes off the right
                             " edge of the screen
set listchars+=precedes:«    " show a « when a line goes off the left
                             " edge of the screen

"needed to setup compatibility with rvm
set shell=sh

"speed up macros
set lazyredraw

"kill old fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

let mapleader = ","

"Shorcuts to move around a split screen
map - <c-w>w
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l

set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P
set laststatus=2
set number

set background=dark
colorscheme solarized
setlocal spell spelllang=en_us

vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" GUI is running or is about to start.
" Maximize gvim window.
if has("gui_running")
  set lines=999 columns=999
endif

set directory=~/.vim/swapfiles,/var/tmp,/tmp,.

"Open files with <leader>f
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
" Open files, limited to the directory of the current file, with <leader>gf
" This requires the %% mapping found below.
map <leader>gf :CommandTFlush<cr>\|:CommandT %%<cr>
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gj :CommandTFlush<cr>\|:CommandT public/javascripts<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT rspec<cr>

"map a to :Ack
nnoremap <leader>a :Ack 

" shortcut to strip trailing whitespace
map <leader>s :s/\s\+$//g<CR>


""" Tabular
" sets ,= to align = and => lines
" sets ,; to align after the : in javscript objects
map <leader>= :Tabularize /=>\?<cr>
map <leader>; :Tabularize /:\zs /<cr> 
nnoremap <CR> :nohlsearch<cr>


function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature$') != -1
        exec ":!bundle exec cucumber " . a:filename
    else
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        elseif filereadable("Gemfile")
            exec ":!bundle exec rspec --color " . a:filename
        else
            exec ":!rspec --color " . a:filename
        end
    end
endfunction

function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  " Run the tests for the previously-marked file.
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
  if in_test_file
    call SetTestFile()
  elseif !exists("t:grb_test_file")
    return
  end
  call RunTests(t:grb_test_file . command_suffix)
endfunction
map <leader>t :call RunTestFile()<cr>
