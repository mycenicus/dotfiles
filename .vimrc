" Stop vim from pretending it's vi
set nocompatible

" Basic settings
set number
set relativenumber
" Tabulation
set tabstop=3
set shiftwidth=3
" Insert spaces not tabs
set expandtab
" Set bottom status line
set laststatus=2
set matchpairs+=":"

" Remove annoying bell sound
set belloff="all"
" Hacky way to disable visual bell
set vb
set t_vb=

set linebreak
set breakindent
set textwidth=80
" Sets autoindent for source code files
set cindent shiftwidth=3

" Show tabs and trailing spaces
set list
" Show tabs and trailing spaces as different chars
set listchars=tab:>-,trail:-

" Show unfinished command
set showcmd

set hlsearch
" HL matches while you are still typing
set incsearch

" INSERT Mode maps
" Allows to undo the <C-U> undo
inoremap <C-U> <C-G>u<C-U>

" NORMAL Mode maps
" Disable highlighted search
nmap <C-H> :nohlsearch<CR>
" Yank into "+ buffer
nnoremap <Y> "+y

" VISUAL Mode maps
" Yank visually selected text and search it in .c files
vnoremap _g y:exe "grep /" . escape(@", '\\/') . "/ *.c *.h"<CR>

" Enable syntax and plugins
syntax enable
filetype plugin indent on

" search down into subfolders via "find
" provides tab-completion for all file-realted tasks
" also allows basic pattern recognition by * (use tab, shift-tab)
" allows fuzzy search
set path+=**

" should be activated by default, but you can never be too careful
set wildmenu

" Make session store window size
set sessionoptions+=resize

" For :set list
hi SpecialKey ctermfg=Darkgray
" Gets really helpful when you have multiple windows
hi StatusLine ctermfg=Darkgray ctermbg=White

" For tmux compatability
set background=dark
set t_Co=256
" After opening a file jump to '" mark if it exists
autocmd BufReadPost *
   \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
   \ | exe "normal! g`\""
   \ | endif
" Create :DiffOrig command that allows you to show difference between current
" version of the file and original (when you just opened it
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" Netrw settings. Can be opened via :Explore, with a prefixes :H, :V, :T
" Use mf, mt, mx commands if you want to interact with the files
" Don't keep current dir in buffer
let g:netrw_keepdir=0
" When opening netrw make window smaller (30%)
let g:netrw_winsize=30
let g:netrw_banner=0
" Hide dotfiles on load
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" Allows copying dirs without using mx
let g:netrw_localcopydircmd='cp -r'
" Highlight marked files in the same way search does
" hi! link netrwMarkFile Search
" tree view
let g:nertrw_liststyle=3

" Enable omnicomplete
set omnifunc=syntaxcomplete#Complete

