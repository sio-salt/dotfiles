-- keymap configuration

_G.Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  { mode = 'n', keys = '<Leader>e', desc = '+Explore' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  { mode = 'n', keys = '<Leader>g', desc = '+Git' },
}

-- Create `<Leader>` mappings
local nmap_leader = function(suffix, rhs, desc) vim.keymap.set('n', '<Leader>' .. suffix, rhs, { desc = desc }) end

-- insert
vim.keymap.set('i', '<C-f>', '<C-x><C-f>', { desc = 'Filepath Completion' })

-- normal
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>')

nmap_leader('ff', '<Cmd>lua require("conform").format({ lsp_fallback = true })<CR>', '[F]ormat [F]ile')
nmap_leader('w', '<C-w>', '[W]indow related keymap')
nmap_leader('bd', '<cmd>MiniBufremove.delete()<cr>', '[B]uffer [D]elete')

-- s for search
nmap_leader('sf', '<cmd>Pick files<cr>', '[S]earch [F]iles')
nmap_leader('so', '<cmd>Pick oldfiles<cr>', '[S]earch [O]ldfiles')
nmap_leader('sh', '<cmd>Pick help<cr>', '[S]earch [H]elps')
nmap_leader('sk', '<cmd>Pick keymaps<cr>', '[S]earch [K]eymaps')
nmap_leader('sc', '<cmd>Pick commands<cr>', '[S]earch [K]eymaps')
nmap_leader('sg', '<cmd>Pick grep_live<cr>', '[S]earch [g]rep_live')
nmap_leader('sG', '<cmd>Pick grep<cr>', '[S]earch [G]rep')
nmap_leader('sn', function()
  -- Pass options as a table to the builtin function
  require('mini.pick').builtin.files({
    tool = 'fd',
  }, {
    source = {
      wd = vim.fn.stdpath('config'),
    },
  })
end, '[S]earch [N]eovim configs')

-- e is for 'Explore' and 'edit'
local explore_at_file = '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>'
local explore_quickfix = function()
  for _, win_id in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.fn.getwininfo(win_id)[1].quickfix == 1 then return vim.cmd('cclose') end
  end
  vim.cmd('copen')
end

nmap_leader('ed', '<Cmd>lua MiniFiles.open()<CR>', 'Directory')
nmap_leader('ef', explore_at_file, 'File directory')
nmap_leader('ei', '<Cmd>edit $MYVIMRC<CR>', 'init.lua')
nmap_leader('en', '<Cmd>lua MiniNotify.show_history()<CR>', 'Notifications')
nmap_leader('es', '<Cmd>lua MiniSessions.select()<CR>', 'Sessions')
nmap_leader('eq', explore_quickfix, 'Quickfix')

-- g is for 'Git'
local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]
local git_log_buf_cmd = git_log_cmd .. ' --follow -- %'

nmap_leader('ga', '<Cmd>Git diff --cached<CR>', 'Added diff')
nmap_leader('gA', '<Cmd>Git diff --cached -- %<CR>', 'Added diff buffer')
nmap_leader('gc', '<Cmd>Git commit<CR>', 'Commit')
nmap_leader('gC', '<Cmd>Git commit --amend<CR>', 'Commit amend')
nmap_leader('gd', '<Cmd>Git diff<CR>', 'Diff')
nmap_leader('gD', '<Cmd>Git diff -- %<CR>', 'Diff buffer')
nmap_leader('gg', '<Cmd>lua Config.open_lazygit()<CR>', 'Git tab')
nmap_leader('gl', '<Cmd>' .. git_log_cmd .. '<CR>', 'Log')
nmap_leader('gL', '<Cmd>' .. git_log_buf_cmd .. '<CR>', 'Log buffer')
nmap_leader('go', '<Cmd>lua MiniDiff.toggle_overlay()<CR>', 'Toggle overlay')
nmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', 'Show at cursor')

vim.keymap.set("n", "*", function()
  require("config.search").star_highlight_no_jump()
end, { silent = true, desc = "* highlight only (no jump), move to word head" })

-- visual
vim.keymap.set('v', '<C-c>', '"+y')

-- normal & visual
vim.keymap.set({ 'n', 'v' }, 'S', '$')
vim.keymap.set({ 'n', 'v' }, 'ss', '^')
vim.keymap.set({ 'n', 'v' }, 'x', '"_x')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"0p')
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"0P')
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d')
vim.keymap.set({ 'n', 'v' }, '<C-Up>', '<C-a>')
vim.keymap.set({ 'n', 'v' }, '<C-Down>', '<C-x>')
vim.keymap.set({ 'n', 'v' }, '<C-x>', '<NOP>')
vim.keymap.set({ 'n', 'v' }, '<C-a>', 'ggVG')
vim.keymap.set({ 'n', 'v' }, '<leader>m', '%', { remap = true, desc = 'Jump to [M]atch pair' })

-- run current script file
vim.keymap.set('n', '<F5>', function()
  if vim.bo.modified then vim.cmd('write') end

  local filetype = vim.bo.filetype
  local filename = vim.fn.expand('%')

  local command = nil
  if filetype == 'python' then
    command = 'python ' .. vim.fn.shellescape(filename)
  elseif filetype == 'lua' then
    command = 'lua ' .. vim.fn.shellescape(filename)
  elseif filetype == 'javascript' then
    command = 'node ' .. vim.fn.shellescape(filename)
  elseif filetype == 'sh' then
    command = 'bash ' .. vim.fn.shellescape(filename)
  else
    print('Execute command is not defined for this file type: ' .. filetype)
    return
  end

  if command then vim.cmd('split | terminal ' .. command) end
end, { noremap = true, silent = true, desc = 'Run current file' })

vim.keymap.set(
  'n',
  '<F3>',
  -- Cycle number / relativenumber
  function()
    local number = vim.wo.number
    local relativenumber = vim.wo.relativenumber

    if not number and not relativenumber then
      -- OFF -> absolute
      vim.wo.number = true
      vim.wo.relativenumber = false
    elseif number and not relativenumber then
      -- absolute -> relative
      vim.wo.number = true
      vim.wo.relativenumber = true
    else
      -- relative -> OFF
      vim.wo.number = false
      vim.wo.relativenumber = false
    end
  end,
  { desc = 'Cycle line number modes' }
)

-- terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

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

-- copilot toggle
-- local copilot_on = true
-- vim.keymap.set(
--   'n',
--   '<leader>tcs',
--   function()
--     if copilot_on then
--       vim.cmd('Copilot disable')
--       print('Copilot OFF')
--     else
--       vim.cmd('Copilot enable')
--       print('Copilot ON')
--     end
--     copilot_on = not copilot_on
--   end,
--   { noremap = true, silent = true, desc = '[T]oggle [C]opilot [S]uggestion' }
-- )

-- vim.keymap.set(
--   { 'n', 'v' },
--   '<leader>tcc',
--   ':CopilotChatToggle<cr>',
--   { noremap = true, silent = true, desc = '[T]oggle [C]opilot [C]hat' }
-- )
