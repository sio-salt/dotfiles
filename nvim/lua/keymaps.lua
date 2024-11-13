-- keymap configuration

-- Ctrl+Shift+l
-- map('n', '<cs-l>', [[<cmd>lua print('ctrl+shift+l')<cr>]], { noremap = true })

vim.keymap.set('i', '<C-l>', '<Left>')
vim.keymap.set('i', '<cs-l>', '<C-Left>')

vim.keymap.set('n', '<C-a>', 'ggVG')
vim.keymap.set('n', '<C-Up>', '<C-a>')
vim.keymap.set('n', '<C-Down>', '<C-x>')
vim.keymap.set('n', '<c-e>', ':Neotree toggle <CR>')

-- loop window
vim.keymap.set('n', '<C-w>l', function()
  if vim.fn.winnr('l') ~= 0 then
    vim.cmd('wincmd l')
  else
    vim.cmd('wincmd |')
  end
end)
vim.keymap.set('n', '<C-w>h', function()
  if vim.fn.winnr('h') ~= 0 then
    vim.cmd('wincmd h')
  else
    vim.cmd('wincmd $')
  end
end)

vim.keymap.set('n', '<leader>pr', function()
  -- Save the file if it has been modified
  if vim.bo.modified then vim.cmd('write') end

  -- Get the file type
  local filetype = vim.bo.filetype
  local filename = vim.fn.shellescape(vim.fn.expand('%'))

  -- Determine the execution command based on the file type
  if filetype == 'python' then
    vim.cmd('!' .. 'python ' .. filename)
  elseif filetype == 'javascript' then
    vim.cmd('!' .. 'node ' .. filename)
  elseif filetype == 'ruby' then
    vim.cmd('!' .. 'ruby ' .. filename)
  elseif filetype == 'sh' then
    vim.cmd('!' .. 'bash ' .. filename)
  else
    print('Execute command is not defined for this file type: ' .. filetype)
  end
end, { noremap = true, silent = true, desc = 'Run current file' })

vim.keymap.set('v', '<C-c>', '+yy')

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
