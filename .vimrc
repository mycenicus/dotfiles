" Stop vim from pretending it's vi
set nocompatible

" Add (default) packages
" Allows to use gc to comment a line
packadd comment
" Removes highlight after some 'updatetime' (default is 4 seconds)
packadd nohlsearch
" Quickly highlight yanked text
packadd hlyank
let g:hlyank_invisual = v:true

" Vunde plugin manager
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'christoomey/vim-tmux-navigator'
call vundle#end()            " required
filetype plugin indent on    " required


" Plugin Options
" vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :<C-U>TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :<C-U>TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :<C-U>TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :<C-U>TmuxNavigateRight<cr>
" Disable tmux navigator when zooming the Vim pane
" let g:tmux_navigator_disable_when_zoomed = 1
" If the tmux window is zoomed, keep it zoomed when moving from Vim to another pane
" let g:tmux_navigator_preserve_zoom = 1


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

" Do not recognize numbers starting with a zero as octal
" For some reason is not a default
set nrformats-=octal

" Show tabs and trailing spaces
set list
" Show tabs and trailing spaces as different chars
set listchars=tab:>-,trail:-

" Show unfinished command
set showcmd

set hlsearch
" HL matches while you are still typing
set incsearch

" Store global marks after exiting
" set viminfo+=f1
" Remember 100 commands after exiting
" set viminfo+=:100

" INSERT Mode maps
" Allows to undo the <C-U> undo
inoremap <C-U> <C-G>u<C-U>

" NORMAL Mode maps
" Yank into "+ buffer
nnoremap <Y> "+y
" Paste but keep cursor' column. Useful when multiline editing
nnoremap gp m`p``j
" Do formatting with motion
nnoremap Q gq

" VISUAL Mode maps
" Yank visually selected text and search it in .c files (from usr_05.txt)
vnoremap _g y:exe "grep /" . escape(@", '\\/') . "/ *.c *.h"<CR>

" Enable syntax and plugins
syntax enable

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

" From usr_05.txt
" After opening a file jump to '" mark if it exists
autocmd BufReadPost *
   \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
   \ | exe "normal! g`\""
   \ | endif
" Removes making a new line a comment if the previous line is a comment
augroup NoAutoComment
   autocmd!
   autocmd FileType * setlocal formatoptions-=ro
augroup END
" Keep active cursor on line all buffers
augroup ActiveCursorline
    autocmd!
    autocmd WinEnter,BufWinEnter * setlocal cursorline
augroup END
" Create :DiffOrig command that allows you to show difference between current
" version of the file and original (when you just opened it)
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" Netrw settings. Can be opened via :Explore, with a prefixes :H, :V, :T
" Use mf, mt, mx commands if you want to interact with the files
" Don't keep current dir in buffer
let g:netrw_keepdir=0
" When opening netrw make window smaller (30%)
let g:netrw_winsize=30
let g:netrw_banner=0
" Hide dotfiles on load. Change it with gh
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" Allows copying dirs without using mx
let g:netrw_localcopydircmd='cp -r'
" tree view
let g:nertrw_liststyle=3

set complete=.^5,w^5,b^5,u^5,t^5,i^5
set autocomplete
" Enable omnicomplete
set omnifunc=syntaxcomplete#Complete

colorscheme highcontrast
