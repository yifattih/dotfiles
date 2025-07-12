-- Author: Yifattih
-- A good portion of this configuration comes from:
-- https://github.com/radleylewis/nvim-lite/blob/youtube_demo/init.lua
-- ===========================================================================
-- GENERAL OPTIONS
-- ===========================================================================

local option = vim.opt

-- Basic settings
option.number = true         -- Line numbers
option.relativenumber = true -- Relative line numbers
option.cursorline = true     -- Highlight current line
-- option.wrap = false          -- Don't wrap lines
option.scrolloff = 10        -- Keep 10 lines above/below cursor
option.sidescrolloff = 8     -- Keep 8 columns left/right of cursor
option.textwidth = 79
option.linebreak = true

-- Indentation
option.tabstop = 2        -- Tab width
option.shiftwidth = 2     -- Indent width
option.softtabstop = 2    -- Soft tab stop
option.expandtab = true   -- Use spaces instead of tabs
option.smartindent = true -- Smart auto-indenting
option.autoindent = true  -- Copy indent from current line

-- Search settings
option.ignorecase = true -- Case insensitive search
option.smartcase = true  -- Case sensitive if uppercase in search
option.hlsearch = false  -- Don't highlight search results
option.incsearch = true  -- Show matches as you type

-- Visual settings
option.termguicolors = true                      -- Enable 24-bit colors
option.signcolumn = "yes"                        -- Always show sign column
option.colorcolumn = "79"                        -- Show column at 79 characters
option.showmatch = true                          -- Highlight matching brackets
option.matchtime = 2                             -- How long to show matching bracket
option.cmdheight = 1                             -- Command line height
option.completeopt = "menuone,noinsert,noselect" -- Completion option
option.showmode = false                          -- Don't show mode in command line
option.pumheight = 10                            -- Popup menu height
option.pumblend = 10                             -- Popup menu transparency
option.winblend = 0                              -- Floating window transparency
option.conceallevel = 0                          -- Don't hide markup
option.concealcursor = ""                        -- Don't hide cursor line markup
option.lazyredraw = true                         -- Don't redraw during macros
option.synmaxcol = 300                           -- Syntax highlighting limit

-- File handling
option.backup = false                            -- Don't create backup files
option.writebackup = false                       -- Don't create backup before writing
option.swapfile = false                          -- Don't create swap files
option.undofile = true                           -- Persistent undo
option.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory
option.updatetime = 300                          -- Faster completion
option.timeoutlen = 500                          -- Key timeout duration
option.ttimeoutlen = 0                           -- Key code timeout
option.autoread = true                           -- Auto reload files changed outside vim
option.autowrite = false                         -- Don't auto save

-- Behavior settings
option.hidden = true                   -- Allow hidden buffers
option.errorbells = false              -- No error bells
option.backspace = "indent,eol,start"  -- Better backspace behavior
option.autochdir = false               -- Don't auto change directory
option.iskeyword:append("-")           -- Treat dash as part of word
option.path:append("**")               -- include subdirectories in search
option.selection = "exclusive"         -- Selection behavior
option.mouse = "a"                     -- Enable mouse support
option.clipboard:append("unnamedplus") -- Use system clipboard
option.modifiable = true               -- Allow buffer modifications
option.encoding = "UTF-8"              -- Set encoding

-- Cursor settings
option.guicursor =
"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Folding settings
option.foldmethod = "expr"                          -- Use expression for folding
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folding
option.foldlevel = 99                               -- Start with all folds open

-- Split behavior
option.splitbelow = true -- Horizontal splits go below
option.splitright = true -- Vertical splits go right

-- Tab display settings
vim.opt.showtabline = 1 -- Always show tabline (0=never, 1=when multiple tabs, 2=always)
vim.opt.tabline = ''    -- Use default tabline (empty string uses built-in)

-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append(
    {
        "*.o",
        "*.obj",
        "*.pyc",
        "*.class",
        "*.jar"
    }
)

-- Better diff options
vim.opt.diffopt:append("linematch:60")

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000
