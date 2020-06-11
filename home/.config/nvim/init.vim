""" syldb's neovim config

""" Vim-Plug

call plug#begin()
Plug 'joshdick/onedark.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'nvie/vim-flake8'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'google/vim-searchindex'
Plug 'preservim/nerdcommenter'
call plug#end()

""" Python3 VirtualEnv

let g:python3_host_prog = expand('~/.config/nvim/env/bin/python')

""" Coloring

syntax on
color onedark

""" Editor config

set updatetime=100
set mouse=a
set hidden
set confirm
set number
set grepprg=git\ grep\ -n
filetype plugin on
" Invisible chars
set listchars=tab:>-,trail:~,extends:>,precedes:<
set list
" Tabs
set expandtab
setlocal tabstop=2
setlocal shiftwidth=2

""" NERDTree

" Open on directories
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Quit nvim if only nerdtree is open
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeMinimalUI = 1

""" Quickfixes

" Auto open
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l* lwindow
augroup END

""" Custom bindings

:let mapleader = ","
nmap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>g :silent grep! <cword><CR>
"Splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"Filepaths
nnoremap <leader>fp :let @+=expand("%")<CR>
nnoremap <leader>ffp :let @+=expand("%:p")<CR>
"Buffers
nnoremap <leader>bl :ls<CR>
nnoremap <leader>bg :buffers<CR>:buffer<Space>
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bc :bd<CR>
nnoremap <leader>< :e#<CR>
