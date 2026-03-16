" Editor Settings
set fillchars+=stl:\ ,stlnc:\
syntax on
filetype off
filetype plugin indent on
set number
set bs=2
set pastetoggle=<F2>
set clipboard=unnamed
set relativenumber
set nocompatible
let mapleader=";"
:imap jj <Esc>
autocmd Filetype python nnoremap <buffer> <F5> :w<CR>:vert ter python3 "%"<CR>

 " Airline Settings
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
set guifont=Meslo\ LG\ L\ for\ Powerline
set laststatus=2
set encoding=utf-8
set t_Co=256
set termencoding=utf-8

" Tab Settings
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set shiftround

" Load Pathogen
execute pathogen#infect()

" NerdTree Settings
let g:NERDTreeGitStatusShowIgnored = 1
nnoremap <leader>q :Sbd<CR>
nnoremap <leader>qm :Sbdm<CR>
map <C-n> <plug>NERDTreeTabsToggle<CR>
nmap <silent> <C-n> :call g:WorkaroundNERDTreeToggle()<CR>

function! g:WorkaroundNERDTreeToggle()
  try | NERDTreeToggle | catch | silent! NERDTree | endtry
endfunction

" EasyMotion Settings
map <Leader><Leader> <Plug>(easymotion-w)

" Show Whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Window Key Binding
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Color scheme
color wombat256mod

" Ctrl-p
set rtp+=/opt/homebrew/opt/fzf
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
