"
" load plug-in system
" -------------------
call pathogen#infect()
set encoding=utf-8
"
" editor settings
" ---------------

set nocompatible     " need no vi
set backspace=indent,eol,start

set number           " use line-numbering (each line prefixed with absolute line-number)
set relativenumber   " use line-numbering (relative position)

set browsedir=buffer " when opening a new file from the menu, default to the directory of the currently open buffer
set confirm          " ask to confirm if some file is not saved instead of failing immediately
set hidden           " allow switching to other buffer without saving the current one first
set switchbuf=usetab,newtab " when opening a buffer, prefer switching to window
                    " that that has already opened that buffer, even if that
                    " window is in another tab, and alternatively open a new tab
                    " to open the buffer

set hlsearch        " by default, higlight searches, switch with <C-L> 
set ignorecase      " Use case insensitive search, except when using capital letters
set smartcase
set incsearch       " While typing a search command, show immediately where the so far typed pattern matches.

set nostartofline   " when moving around, don't reset to start of line
set scrolloff=3

let &showbreak = '►► ' " prefix for wrapped lines
set wrap            " display-only line-wrapping
set linebreak       " only break line at <breakat> chars
set nolist          " disable printing of unprintable characters, as this breaks linebreak for some reason

set tabstop=4       " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.
set expandtab
set autoindent

set wildmenu        " people say this improves the tab-completion; let's see
set showcmd         " show partial commands in the last line of the screen

set laststatus=2    " Always display the status line, even if only one window is displayed
set statusline=%02n\ %-20f\ %m%r[%{&fileencoding?&fileencoding:&encoding}][%{&ff}]%h%q%w%y%=\ %10.(%l,%c%V\ %P%)

set clipboard=unnamed  " sync the anonymous register to the clipboard; use
                       " unnamedplus to sync with X Window clipboard,
                       " unnamed to sync with selection buffer (non-win
                       " only)

set background=dark
syntax on            " syntax highlighting
filetype plugin indent on  " determine file-type for indentation and plug-ins by name and possibly contents

" Show trailing whitespace (only after some text, ignore blank lines), and spaces before a tab:
" for some reason that doesn't work as I want it to
" highlight ExtraWhitespace ctermbg=red guibg=red
" autocmd Syntax * syn match ExtraWhitespace  /\S\zs\s\+$\| \+\ze\t/

" Show tabs and trailing whitespace
" set list listchars=tab:→\ ,trail:·,eol:¶
set list listchars=tab:→\ ,trail:·

"
" markdown settings
" ---------------------
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

"
" one global session
" ------------------

set sessionoptions-=options " Don't persist options and mappings because it can corrupt sessions.
set sessionoptions-=folds   " do not store folds
let g:session_autoload='yes'
let g:session_autosave='yes'

"
" key/mouse bindings
" ------------------

" deactivate accidental ex mode
nnoremap Q <nop>
" map Y to act as y$ instead of yy (from cursor to end of line instead of all of current line, like D and C)
map Y y$
set mouse=a  " activate mouse in all modes
nmap <C-Tab> :tabnext<CR>
nmap <C-S-Tab> :tabprevious<CR>

"
" gvim settings
" -------------

" colorscheme solarized
" colorscheme base16-default
" colorscheme base16-solarized

if has("gui_running")
    colorscheme base16-default
    " colorscheme base16-solarized
    " colorscheme solarized
    " colorscheme desert

    " set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    if has("gui_gtk2")
        set guifont=Inconsolata\ 11
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h12
    elseif has("gui_win32")
        set guifont=Consolas:h10:cANSI
    endif
endif

"
" stuff
" -----

" automatically reload .vimrc whenever it changes
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

autocmd FileType make setlocal noexpandtab
autocmd FileType go setlocal noexpandtab

function! ScaleFontUp()
  let gf_size_whole = matchstr(&guifont, '\(\:h\)\@<=\d\+')
  let gf_size_frac = matchstr(&guifont, '\(\:h\d\+\.\)\@<=\d\=')
  let font_size = gf_size_whole * 10 + gf_size_frac
  let font_size = font_size + 5
  let gf_size_whole = font_size / 10
  let gf_size_frac = font_size - gf_size_whole * 10
  let new_font_size = ':h'.gf_size_whole.'.'.gf_size_frac.':'
  let &guifont = substitute(&guifont, '\:h.\{-}\:', new_font_size, '')
endfunction

function! ScaleFontDown()
  let gf_size_whole = matchstr(&guifont, '\(\:h\)\@<=\d\+')
  let gf_size_frac = matchstr(&guifont, '\(\:h\d\+\.\)\@<=\d\=')
  let font_size = gf_size_whole * 10 + gf_size_frac
  let font_size = font_size - 5
  let gf_size_whole = font_size / 10
  let gf_size_frac = font_size - gf_size_whole * 10
  let new_font_size = ':h'.gf_size_whole.'.'.gf_size_frac.':'
  let &guifont = substitute(&guifont, '\:h.\{-}\:', new_font_size, '')
endfunction

nmap <C-S-F11> :call ScaleFontDown()<CR>
nmap <C-S-F12> :call ScaleFontUp()<CR>

