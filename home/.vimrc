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
set hlsearch
set nospell

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
"render long lines without too much slowdown
set synmaxcol=140

"kill old fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

autocmd FileType ruby let b:dispatch = 'bundle exec rspec %'

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

vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" GUI is running or is about to start.
" Maximize gvim window.
if has("gui_running")
  set lines=999 columns=999
endif

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

set directory=~/.vim/swapfiles,/var/tmp,/tmp,.


"map a to :Ack
nnoremap <leader>a :Ack 

" shortcut to strip trailing whitespace
map <leader>s :s/\s\+$//g<CR>
nmap <leader>o o<esc>
nmap <leader>O O<esc>


""" Tabular
" sets ,= to align = and => lines
" sets ,; to align after the : in javscript objects
map <leader>= :Tabularize /=>\?<cr>
map <leader>; :Tabularize /:\zs /<cr>
map <leader>d :bp\|bd #<cr>
nnoremap <CR> :nohlsearch<cr>

nnoremap <silent> <Leader>+ :exe "vertical resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "vertical resize " . (winheight(0) * 2/3)<CR>



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

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

function! ListActiveBuffers()
  let bufferlist = []
  for l:bni in range(bufnr("$"), 1, -1)
    if buflisted(l:bni)
      call add(bufferlist, bufname(l:bni))
    endif
  endfor
  return "echo ".join(bufferlist, ' ')." | tr ' ' '\\n' "
endfunction
nnoremap <leader>b :exec SelectaCommand(ListActiveBuffers(), "", ":e")<cr>


" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call SelectaCommand("find * -type f -o -path 'vendor' -prune -type f -o -path 'tmp' -prune -type f", "", ":e")<cr>
