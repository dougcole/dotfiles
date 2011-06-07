set nocompatible
set nofoldenable
call pathogen#runtime_append_all_bundles()
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

set clipboard=unnamed

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

"STOLEN from https://www.destroyallsoftware.com/file-navigation-in-vim.html
function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo
    exec ":!bundle exec rspec " . a:filename
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_spec_file = match(expand("%"), '_spec.rb$') != -1
    if in_spec_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

" Run this file
map <leader>t :call RunTestFile()<cr>
" Run only the example under the cursor
map <leader>T :call RunNearestTest()<cr>
" Run all test files
map <leader>a :call RunTests('spec')<cr>
