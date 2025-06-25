" ~/.vimrc
syntax on
set number relativenumber
set tabstop=4 shiftwidth=4 expandtab
set clipboard=unnamedplus
set mouse=a
set background=dark
filetype plugin indent on

:set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40 

inoremap jj <ESC>

:set statusline+=\ %F\ %M\ %Y\ %R
:set statusline+=%=
:set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

call plug#begin('~/.vim/plugged')

" Visuals & Navigation
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Git integration
Plug 'tpope/vim-fugitive'

" Linting + Fixing (Python, Shell, Terraform)
Plug 'dense-analysis/ale'

call plug#end()

colorscheme gruvbox

" ALE settings
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'python': ['black'],
\   'sh': ['shfmt'],
\   'terraform': ['terraform'],
\}

" Python indentation
au FileType python setlocal expandtab shiftwidth=4 softtabstop=4

" Toggle NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

