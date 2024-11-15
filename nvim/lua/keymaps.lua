-- keymap configuration

-- Ctrl+Shift+l
-- map('n', '<cs-l>', [[<cmd>lua print('ctrl+shift+l')<cr>]], { noremap = true })

vim.keymap.set('i', '<C-l>', '<Left>')
vim.keymap.set('i', '<cs-l>', '<C-Left>')

vim.keymap.set('n', '<C-a>', 'ggVG')
vim.keymap.set('n', '<C-Up>', '<C-a>')
vim.keymap.set('n', '<C-Down>', '<C-x>')
vim.keymap.set('n', '<c-w>L', ':Neotree toggle <CR>')
-- vim.keymap.set('n', '<c-e>', ':Neotree toggle <CR>')
vim.keymap.set('n', '<C-e>', function()
  if vim.bo.filetype == 'neo-tree' then
    vim.cmd('Neotree close')
  else
    vim.cmd('Neotree focus')
  end
end, { noremap = true, silent = true })

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

-- vim.keymap.set('n', '<F5>', function()
--   -- Save the file if it has been modified
--   if vim.bo.modified then vim.cmd('write') end
--
--   -- Get the file type
--   local filetype = vim.bo.filetype
--   local filename = vim.fn.shellescape(vim.fn.expand('%'))
--
--   -- Determine the execution command based on the file type
--   if filetype == 'python' then
--     vim.cmd('!' .. 'python ' .. filename)
--   elseif filetype == 'javascript' then
--     vim.cmd('!' .. 'node ' .. filename)
--   elseif filetype == 'ruby' then
--     vim.cmd('!' .. 'ruby ' .. filename)
--   elseif filetype == 'sh' then
--     vim.cmd('!' .. 'bash ' .. filename)
--   else
--     print('Execute command is not defined for this file type: ' .. filetype)
--   end
-- end, { noremap = true, silent = true, desc = 'Run current file' })

vim.keymap.set('n', '<F5>', function()
  -- Save the file if it has been modified
  if vim.bo.modified then vim.cmd('write') end

  -- Get the file type
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand('%')

  -- Determine the execution command based on the file type
  local command = nil
  if filetype == 'python' then
    command = 'python ' .. vim.fn.shellescape(filename)
  elseif filetype == 'javascript' then
    command = 'node ' .. vim.fn.shellescape(filename)
  elseif filetype == 'ruby' then
    command = 'ruby ' .. vim.fn.shellescape(filename)
  elseif filetype == 'sh' then
    command = 'bash ' .. vim.fn.shellescape(filename)
  else
    print('Execute command is not defined for this file type: ' .. filetype)
    return
  end

  -- Open a terminal and execute the command
  if command then vim.cmd('split | terminal ' .. command) end
end, { noremap = true, silent = true, desc = 'Run current file' })

vim.keymap.set('v', '<C-c>', '"+y')

vim.keymap.set({ 'n', 'v' }, 'S', '$')
vim.keymap.set({ 'n', 'v' }, 'ss', '^')
vim.keymap.set({ 'n', 'v' }, 'x', '"_x')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"0p')
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d')
vim.keymap.set({ 'n', 'v' }, '<leader>m', '%')

-- Map <F2> to toggle 'mouse' setting
vim.keymap.set({ 'i', 'n', 'v' }, '<F2>', function()
  if vim.o.mouse == 'a' then
    vim.o.mouse = ''
    print('Mouse disabled')
  else
    vim.o.mouse = 'a'
    print('Mouse enabled')
  end
end)
