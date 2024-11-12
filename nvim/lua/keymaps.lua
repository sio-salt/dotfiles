-- keymap configuration

vim.keymap.set('n', 'S', '$')
vim.keymap.set('n', 'ss', '^')

vim.keymap.set('n', '<C-a>', 'ggVG')
vim.keymap.set('n', '<C-Up>', '<C-a>')
vim.keymap.set('n', '<C-Down>', '<C-x>')

vim.keymap.set('n', '<leader>r', function()
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

vim.keymap.set({ 'n', 'v' }, 'x', '"_x')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"0p')
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d')
vim.keymap.set({ 'n', 'v' }, '<leader>m', '%')
