"-----------------------------------------------------------
"                      user interface
"-----------------------------------------------------------
set syntax=c
syntax on
set number
set nocompatible
set laststatus=2               " bottom status bar, 2=always

" colours for light background / dark foreground:
"set background=light
" otherwise:
"set background=dark

" Try to show 3 lines/2 cols of context when scrolling
set scrolloff=3
set sidescrolloff=2

" line numbers
set numberwidth=3
" F10 toggles line numbers on the left
map <F10> :set invnumber<CR>



"-----------------------------------------------------------
"                    detect filetypes
"-----------------------------------------------------------

filetype plugin on
filetype indent on



"-----------------------------------------------------------
"                indentation, tabulations
"-----------------------------------------------------------

set smartindent   " auto indentation

set tabstop=2     " 1 tab == 2 spaces
set shiftwidth=2  " 1 indent == 2 spaces
set shiftround    " use multiples of 'shiftwidth'
set expandtab     " write spaces instead of tabs

" If you want to indent text:
" <Esc>         go to normal mode
" >>            indent current line once to the right
" <<            indent current line once to the left
" 3>>           indent 3 lines once to the right
"
" To select lines before indenting them:
" <Esc>
" <Shift>-V
" <down> or j or } or any other movement
" >
"
" Reminder: dot (.) repeats the last action.
" So, to indent 5 lines 3 times on the right:
" 5>>..



"-----------------------------------------------------------
"                    moving around
"-----------------------------------------------------------

" when pasting text or code with the mouse (middle-click):
" F11 toggles 'smart' indent:
map <F11> :set invpaste<CR>
set pastetoggle=<F11>  " also work in insert mode



"-----------------------------------------------------------
"                  search and replace
"-----------------------------------------------------------

set ignorecase " searches are case-insensitive
set smartcase  " unless we type an upper-case character

set incsearch  " show the `best match so far'
set hlsearch   " highlight search

" shortcut for 'replace all': just type ;;
noremap ;; :%s:::g<Left><Left><Left>



"-----------------------------------------------------------
"                        comments
"-----------------------------------------------------------

" usage example (try it right now):
"
" <Esc>           go to normal mode
" <Shift>-V       go to visual mode, full lines selection
" <down> or }     select any number of lines. Then, type either:
"
" ,/              comment each selected line with //           (C, Java)
" ,#              comment each selected line with #            (shell)
" ,<              comment each selected line with <!-- ... --> (XML)
" ,c              remove single-line comments on each selected line
" ,u              remove multi-line comments on each selected line

" single-line comments:
map <silent> ,# :s/^/#/<CR><Esc>:nohlsearch<CR>
map <silent> ,/ :s/^/\/\//<CR><Esc>:nohlsearch<CR>
map <silent> ,> :s/^/> /<CR><Esc>:nohlsearch<CR>
map <silent> ," :s/^/\"/<CR><Esc>:nohlsearch<CR>
map <silent> ,% :s/^/%/<CR><Esc>:nohlsearch<CR>
map <silent> ,! :s/^/!/<CR><Esc>:nohlsearch<CR>
map <silent> ,; :s/^/;/<CR><Esc>:nohlsearch<CR>
map <silent> ,- :s/^/--/<CR><Esc>:nohlsearch<CR>
map <silent> ,d :s/^/dnl /<CR><Esc>:nohlsearch<CR>
" uncomment
map <silent> ,c :s:\(^\s*\)\(//\\|--\\|> \\|[#"%!;]\\|dnl \):\1:e<CR><Esc>:nohlsearch<CR>

" multi-line comments:
map <silent> ,* :s/^\(.*\)$/\/\* \1 \*\//<CR><Esc>:nohlsearch<CR>
map <silent> ,( :s/^\(.*\)$/\(\* \1 \*\)/<CR><Esc>:nohlsearch<CR>
map <silent> ,< :s/^\(.*\)$/<!-- \1 -->/<CR><Esc>:nohlsearch<CR>
" uncomment
map <silent> ,u :s:\(^\s*\)\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$:\1\3:e<CR><Esc>:nohlsearch<CR>



"-----------------------------------------------------------
"                  shortcuts you should know
  "-----------------------------------------------------------
  "
  " K                reaches the man page for the current word
" g Ctrl-G         counts words, lines and chars
" :Explore | :Ex | :n <some_dir>      to explore directories
"

