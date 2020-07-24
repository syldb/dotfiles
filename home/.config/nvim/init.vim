""" syldb's neovim config

""" Vim-Plug

call plug#begin()
Plug 'joshdick/onedark.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'nvie/vim-flake8'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
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
set encoding=utf-8
set title
set grepprg=git\ grep\ -n
filetype plugin indent on
set scrolloff=5 sidescrolloff=5
set incsearch ignorecase smartcase hlsearch
set list listchars=tab:>-,trail:~,extends:>,precedes:<,nbsp:+
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab autoindent

""" Nerdtree

let NERDTreeIgnore = ['\.pyc$', '^__pycache__$']
let NERDTreeMinimalUI = 1

""" FZF

" Hide status bar while using fzf commands
if has('nvim') || has('gui_running')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 | autocmd WinLeave <buffer> set laststatus=2
endif

" Customize fzf colors to match color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" GGrep command to use git grep with fzf
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)


""" Airline

let g:airline#extensions#tabline#enabled = 1

""" Custom functions

" Auto open quickfixes
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l* lwindow
augroup END

" Trim Whitespaces
function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\\\@<!\s\+$//e
    call winrestview(l:save)
endfunction

""" Custom bindings

let mapleader=","
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>t :call TrimWhitespace()<CR>
nnoremap œ :bn<CR>
"FZF
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>ap :Files<CR>
nnoremap <leader>p :GFiles<CR>
nnoremap <leader>g :GGrep<CR>
nnoremap <leader>f :Rg<CR>
nnoremap <leader>h :History<CR>
"Filepaths
nnoremap <leader>fp :let @+=expand("%")<CR>
nnoremap <leader>ffp :let @+=expand("%:p")<CR>
