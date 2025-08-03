-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- my keymap configuration

vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', '<C-a>', 'ggVG')
vim.keymap.set('n', '<c-w>L', ':Neotree toggle <CR>')

vim.keymap.set('n', '<C-w>l', function()
    local count = vim.v.count1
    local current_win = vim.fn.winnr()
    local total_wins = vim.fn.winnr('$')
    local new_win = ((current_win - 1 + count) % total_wins) + 1
    vim.cmd(new_win .. 'wincmd w')
end, { noremap = true, silent = true })

vim.keymap.set('n', '<C-w>h', function()
    local count = vim.v.count1
    local current_win = vim.fn.winnr()
    local total_wins = vim.fn.winnr('$')
    local new_win = ((current_win - 1 - count + total_wins) % total_wins) + 1
    vim.cmd(new_win .. 'wincmd w')
end, { noremap = true, silent = true })

-- run current script file
vim.keymap.set('n', '<F5>', function()
    if vim.bo.modified then vim.cmd('write') end

    local filetype = vim.bo.filetype
    local filename = vim.fn.expand('%')

    local command = nil
    local filetypes = { 'python', 'lua', 'sh' }

    for i, ft in pairs(filetype) do
        if ft == vim.bo.filetype then command = ft .. vim.fn.shellescape(filename) end
    end

    if filetype == 'javascript' then
        command = 'node' .. vim.fn.shellescape(filename)
    else
        print('Execute command is not defined for this file type: ' .. filetype)
        return
    end

    if command then vim.cmd('split | terminal ' .. command) end
end, { noremap = true, silent = true, desc = 'Run current file' })

-- copilot toggle
-- local copilot_on = true
-- vim.keymap.set('n', '<leader>tcs', function()
--     if copilot_on then
--         vim.cmd('Copilot disable')
--         print('Copilot OFF')
--     else
--         vim.cmd('Copilot enable')
--         print('Copilot ON')
--     end
--     copilot_on = not copilot_on
-- end, { noremap = true, silent = true, desc = '[T]oggle [C]opilot [S]uggestion' })

vim.keymap.set('v', '<C-c>', '"+y')

vim.keymap.set({ 'n', 'v' }, 'S', '$')
vim.keymap.set({ 'n', 'v' }, 'ss', '^')
vim.keymap.set({ 'n', 'v' }, 'x', '"_x')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"0p')
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"0P')
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d')
vim.keymap.set({ 'n', 'v' }, '<C-a>', '<Nop>')
vim.keymap.set({ 'n', 'v' }, '<C-Up>', '<C-a>')
vim.keymap.set({ 'n', 'v' }, '<C-x>', '<Nop>')
vim.keymap.set({ 'n', 'v' }, '<C-Down>', '<C-x>')

-- toggle auto suggestion
-- vim.keymap.set(
--   { 'n', 'v' },
--   '<leader>tas',
--   function() require('cmp').toggle_autocomplete() end,
--   { desc = '[T]oggle [A]uto [S]uggestion' }
-- )

vim.keymap.set({ 'n', 'v' }, '<leader>m', '%', { desc = '[J]ump to [M]atching braces' })

-- vim.keymap.set(
--     { 'n', 'v' },
--     '<leader>tcc',
--     ':CopilotChatToggle<CR>',
--     { noremap = true, silent = true, desc = '[T]oggle [C]opilot [C]hat' }
-- )

-- Map <F2> to toggle 'mouse' setting
vim.o.mouse = ''
vim.keymap.set({ 'i', 'n', 'v' }, '<F2>', function()
    if vim.o.mouse == 'a' then
        vim.o.mouse = ''
        print('Mouse disabled')
    else
        vim.o.mouse = 'a'
        print('Mouse enabled')
    end
end)

-- Set up clipboard for win32yank usage (system clipboard)
if vim.fn.has('win32') == 1 or vim.fn.has('wsl') == 1 then
    vim.g.clipboard = {
        name = 'myClipboard',
        copy = {
            ['+'] = 'win32yank.exe -i', -- Use win32yank for copying to +
            ['*'] = 'win32yank.exe -i', -- Use win32yank for copying to *
        },
        paste = {
            ['+'] = 'win32yank.exe -o', -- Use win32yank for pasting from +
            ['*'] = 'win32yank.exe -o', -- Use win32yank for pasting from *
        },
        cache_enabled = 1,
    }
else
    -- linux
end
