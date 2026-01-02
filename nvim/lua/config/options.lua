-- options

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 0  -- 0 means equal to tabstop

vim.o.scrolloff = 5
vim.o.cursorline = true
vim.o.wrap = false
vim.o.breakindent = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.autocomplete = true
vim.o.confirm = true
vim.o.inccommand = 'split'
vim.o.winborder = "rounded"
vim.o.undofile = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }


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
end
