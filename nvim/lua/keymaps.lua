-- keymap configuration

-- Ctrl+Shift+l
-- map('n', '<cs-l>', [[<cmd>lua print('ctrl+shift+l')<cr>]], { noremap = true })

-- vim.keymap.set('i', '<C-l>', '<Left>')
-- vim.keymap.set('i', '<cs-l>', '<C-Left>')

vim.keymap.set('n', '<C-a>', 'ggVG')
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

-- run current script file
vim.keymap.set('n', '<F5>', function()
  if vim.bo.modified then vim.cmd('write') end

  local filetype = vim.bo.filetype
  local filename = vim.fn.expand('%')

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

  if command then vim.cmd('split | terminal ' .. command) end
end, { noremap = true, silent = true, desc = 'Run current file' })

-- copilot toggle
local copilot_on = true
vim.keymap.set(
  'n',
  '<leader>tcs',
  function()
    if copilot_on then
      vim.cmd('Copilot disable')
      print('Copilot OFF')
    else
      vim.cmd('Copilot enable')
      print('Copilot ON')
    end
    copilot_on = not copilot_on
  end,
  { noremap = true, silent = true, desc = '[T]oggle [C]opilot [S]uggestion' }
)

vim.keymap.set('v', '<C-c>', '"+y')

vim.keymap.set({ 'n', 'v' }, 'S', '$')
vim.keymap.set({ 'n', 'v' }, 'ss', '^')
vim.keymap.set({ 'n', 'v' }, 'x', '"_x')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"0p')
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"0P')
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d')
vim.keymap.set({ 'n', 'v' }, '<C-Up>', '<C-a>')
vim.keymap.set({ 'n', 'v' }, '<C-Down>', '<C-x>')

-- toggle auto suggestion
-- vim.keymap.set(
--   { 'n', 'v' },
--   '<leader>tas',
--   function() require('cmp').toggle_autocomplete() end,
--   { desc = '[T]oggle [A]uto [S]uggestion' }
-- )

vim.keymap.set(
  { 'n', 'v' },
  '<leader>m',
  '%',
  { desc = '[J]ump to [M]atching braces' }
)

vim.keymap.set(
  { 'n', 'v' },
  '<leader>tcc',
  ':CopilotChatToggle<CR>',
  { noremap = true, silent = true, desc = '[T]oggle [C]opilot [C]hat' }
)

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
