-- other plugins
local now_if_args, later = _G.Config.now_if_args, MiniDeps.later

-- mason ======================================================================
later(function()
  vim.pack.add({ 'https://github.com/mason-org/mason.nvim' })
  require('mason').setup()
end)

-- Formatting =================================================================
later(function()
  vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

  require('conform').setup({
    -- Map of filetype to formatters
    formatters_by_ft = {
      javascript = { 'prettier' },
      json = { 'prettier' },
      lua = { 'stylua' },
      python = { 'ruff' },
    },
  })
end)

-- snippets ===================================================================
later(function() vim.pack.add({ 'https://github.com/rafamadriz/friendly-snippets' }) end)
