syntax on
:set number relativenumber
:set tabstop=4 shiftwidth=4 expandtab
:set clipboard=unnamedplus
:set mouse=a
filetype plugin indent on

:set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40 

inoremap jj <ESC>

" :set statusline+=\ %F\ %M\ %Y\ %R
" :set statusline+=%=
" :set statusline+=\ row:\ %l\ col:\ %c\ percent:\ %p%%

call plug#begin()
    " UI Component Library for Neovim
    Plug 'MunifTanjim/nui.nvim'

    Plug 'nvim-lua/plenary.nvim'

    " Visuals & Navigation
    " Plug 'morhetz/gruvbox'
   " Plug 'Tsuzat/NeoSolarized.nvim', { 'branch': 'master' }
    Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

    " Files icons
    Plug 'ryanoasis/vim-devicons'

    " File explorer
    Plug 'preservim/nerdtree'

    " Fuzzy Finder
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

    " Notification manager
    Plug 'rcarriga/nvim-notify'
 
    " Replace the UI for messages, cmdline and the popupmenu
    Plug 'folke/noice.nvim'

    " Neovim statusline
    Plug 'nvim-lualine/lualine.nvim'

    " Statusline icons
    Plug 'nvim-tree/nvim-web-devicons'

    " Git integration
    Plug 'tpope/vim-fugitive'
    
    " Linting + Fixing (Python, Shell, Terraform)
    Plug 'dense-analysis/ale'

call plug#end()

lua require('noice').setup()

lua require('lualine').setup()

lua require('notify').setup({ background_colour = "#1a1b26", })

lua require('telescope').load_extension('noice')

:set termguicolors
:set background=dark
" colorscheme NeoSolarized
colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

"ALE settings"
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'python': ['black'],
\   'sh': ['shfmt'],
\   'terraform': ['terraform'],
\}

"Python indentation"
augroup python_settings
    autocmd!
    autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
augroup END

" Binding to clear the highlighting of search matches until the next search
nnoremap <leader>h :nohlsearch<CR>

" Binding to open fzf
" nnoremap <C-f> :Files<CR>
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <CMD>Telescope find_files<CR>
nnoremap <leader>fg <CMD>Telescope live_grep<CR>
nnoremap <leader>fb <CMD>Telescope buffers<CR>
nnoremap <leader>fh <CMD>Telescope help_tags<CR>
nnoremap <leader>fm <CMD>Telescope noice<CR>

"Toggle NERDTree"
nnoremap <C-n> :NERDTreeToggle<CR>

"Map leader+r to run current file in tmux pane below"
nnoremap <leader>r :call RunCurrentFileInTmux()<CR>

"Automatically run the current file in the tmux pane below"
function! RunCurrentFileInTmux()
    let l:filename = expand('%:p')
    let l:filetype = &filetype

    "Determine run command"
    if l:filetype ==# 'python'
        let l:cmd = 'python3 ' . shellescape(l:filename)
    elseif l:filetype ==# 'sh'
        let l:cmd = 'bash ' . shellescape(l:filename)
    elseif l:filetype ==# 'terraform'
        let l:cmd = 'terraform fmt ' . shellescape(l:filename) . ' && terraform apply -auto-approve'
    elseif l:filetype ==# 'lua'
        let l:cmd = 'lua ' . shellescape(l:filename)
    elseif l:filetype ==# 'javascript'
        let l:cmd = 'node ' . shellescape(l:filename)
    else
        echo "Unsupported filetype: " . l:filetype
        return
    endif

    "Check if only 1 pane exists and split if necessary"
    if system('tmux list-panes | wc -l') ==# "1\n"
        call system('tmux split-window -v -l 15')
        sleep 100m  " give tmux a bit of time to spawn the pane
    endif

    " Get bottom pane ID
    let l:bottom_pane = substitute(system("tmux list-panes -F '#{pane_id}' | tail -n1"), '\n', '', '')

    "Send command to bottom pane"
    call system("tmux send-keys -t " . l:bottom_pane . " 'clear' C-m")
    call system("tmux send-keys -t " . l:bottom_pane . " " . shellescape(l:cmd) . " C-m")

    "Return focus to original"
    call system("tmux select-pane -t 0")
endfunction
