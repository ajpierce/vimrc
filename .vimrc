syntax on               " Turn on syntax hilighting
colorscheme holokai     " Color scheme: http://vimcolors.com/?utf8=%E2%9C%93&bg=dark&colors=any
let mapleader = ","     " Bind the comma key as a trigger for calling functions
set hlsearch            " Higlight your search terms
set encoding=utf-8      " For reading and writing 日本語

" Replace tabs with spaces, and make tabbing behavior intelligent
" I keep my tabs at 4 spaces, per the Python standard.
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
set smartindent
set autoindent
set ci

" Four-space tabs are a fine default, but there are some languages where
" two-space tabs are standard. For Ruby, HTML, and CSS, use two-space tabs.
if has("autocmd")
    autocmd FileType html,htmldjango,less,scss,css,ruby setlocal ts=2 sts=2 sw=2
endif

" Syntax highlighting for Less and Markdown filetypes
au BufNewFile,BufRead *.less set filetype=less
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" -- PLUGIN MANAGEMENT --
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

set nocompatible              " Be iMproved, required
filetype off                  " Required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'          " Let Vundle manage Vundle (required)
Plugin 'godlygeek/tabular'          " Requirement for vim-markdown
Plugin 'plasticboy/vim-markdown'    " Markdown syntax highlighting
Plugin 'kien/ctrlp.vim'             " Full-path fuzzy file/buffer/etc. finder

" All of your Plugins must be added before the following line
call vundle#end()            " Required
filetype plugin indent on    " Required

" Disable folding of markdown files
let g:vim_markdown_folding_disabled=1

" Invoke CtrlP for fuzzy-searching
nmap <leader>b :CtrlPBuffer<CR>|" Open any file already in the buffer
nmap <leader>f :CtrlP<CR>|      " Open any file in the current (or sub)directory

" -- WINDOW MANAGEMENT --
nmap <leader>w :wincmd v<CR>    " Split the screen vertically
nmap <leader>x :wincmd q<CR>    " Quit a window split
nmap <leader>q :wincmd h<CR>    " Jump to the left window
nmap <leader>e :wincmd l<CR>    " Jump to the right window
nmap <leader>a :bprev<CR>       " Switch to the previous buffer
nmap <leader>d :bnext<CR>       " Switch to the next buffer

" With smart tabbing and indenting, pasting text into VIM can cause formatting
" problems. I bind the F2 key to toggle 'paste mode' in VIM.
set pastetoggle=<F2>

" This function toggles relative line numbering. This is super handy for
" deleting or moving chunks of code, because you can see exactly how many
" lines you need to modify.
function! NumberToggle()
    if(&relativenumber == 1)
        set number
        set nonumber
    else
        set relativenumber
    endif
endfunc

" Remember when we bound mapleader to comma earlier? Press comma and
" then r to toggle relative line numbering.
nnoremap <F8> :call NumberToggle()<cr>
nmap <leader>r <F8>

" This function will draw a vertical red bar across column 80. This is handy
" if you're trying to adhere to coding standards that dictate your code should
" be readable in an 80-character console. Turn it on or off with F9 or ,v
function! LineLimitToggle()
    if(&colorcolumn == 80)
        set colorcolumn=0
    else
        set colorcolumn=80
    endif
endfunc

nnoremap <F9> :call LineLimitToggle()<cr>
nmap <leader>v <F9>

" Toggle English spell check in the current document with F10 or ,s
function! SpellToggle()
    if(&spell == 1)
        set nospell
    else
        set spell spelllang=en_us
    endif
endfunc

nnoremap <F10> :call SpellToggle()<cr>
nmap <leader>s <F10>

" Remove trailing whitespace from lines
function! RemoveTrailingWhitespace()
    exe "normal mz"
    :%s/\s\+$//ge
    exe "normal `z"
endfunc
noremap <leader>c :call RemoveTrailingWhitespace()<cr>

" -- STATUS LINE --
" Filename [filetype] [selected char encoding] [column, line] [%of file]
set statusline=%t%m%r%h%w\ %y\ [\%03.3b,\%02.2B]\ [c=%02v,l=%03l/%03L]\ [%p%%]
