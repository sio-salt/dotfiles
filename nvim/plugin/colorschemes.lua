-- install vim colorscheme plugins
vim.pack.add({
  { src = 'https://github.com/rebelot/kanagawa.nvim.git' },
  { src = 'https://github.com/catppuccin/nvim.git', name = "catppuccin-nvim" },
  { src = 'https://github.com/folke/tokyonight.nvim.git' },
})

vim.cmd.colorscheme("kanagawa")
