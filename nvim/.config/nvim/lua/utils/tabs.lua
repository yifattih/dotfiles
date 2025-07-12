-- Author: Yifattih
-- A good portion of this configuration comes from:
-- https://github.com/radleylewis/nvim-lite/blob/youtube_demo/init.lua
-- ===========================================================================
-- TABS
-- ===========================================================================

-- Transparent tabline appearance
vim.cmd([[hi TabLineFill guibg=NONE ctermfg=242 ctermbg=NONE]])

-- Function to open file in new tab
local function open_file_in_tab()
    vim.ui.input(
        {
            prompt = 'File to open in new tab: ',
            completion = 'file'
        },
        function(input)
            if input and input ~= '' then
                vim.cmd('tabnew ' .. input)
            end
        end
    )
end

-- Function to duplicate current tab
local function duplicate_tab()
    local current_file = vim.fn.expand('%:p')
    if current_file ~= '' then
        vim.cmd('tabnew ' .. current_file)
    else
        vim.cmd('tabnew')
    end
end

-- Function to close tabs to the right
local function close_tabs_right()
    local current_tab = vim.fn.tabpagenr()
    local last_tab = vim.fn.tabpagenr('$')

    for i = last_tab, current_tab + 1, -1 do
        vim.cmd(i .. 'tabclose')
    end
end

-- Function to close tabs to the left
local function close_tabs_left()
    local current_tab = vim.fn.tabpagenr()

    for i = current_tab - 1, 1, -1 do
        vim.cmd('1tabclose')
    end
end



-- Function to close buffer but keep tab if it's the only buffer in tab
local function smart_close_buffer()
    local buffers_in_tab = #vim.fn.tabpagebuflist()
    if buffers_in_tab > 1 then
        vim.cmd('bdelete')
    else
        -- If it's the only buffer in tab, close the tab
        vim.cmd('tabclose')
    end
end

return {
    open_file_in_tab = open_file_in_tab,
    duplicate_tab = duplicate_tab,
    smart_close_buffer = smart_close_buffer,
    close_tabs_right = close_tabs_right,
    close_tabs_left = close_tabs_left,
}
