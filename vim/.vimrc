syntax on " (activates syntax highlighting)
" colo iwtb " (uses the iwtb colorscheme)
"
filetype plugin on " (Vim recognizes which highlighting based on the extension)

:set laststatus=2 " (activates status bar)

:set history=1000 " (saves the last 1000 commands that were used)

:set number " (activates line numbers)

" color desert
:set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40 

inoremap jj <ESC>

:set statusline+=\ %F\ %M\ %Y\ %R
:set statusline+=%=
:set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
