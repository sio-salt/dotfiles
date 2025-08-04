return {
  -- LSP も indent-blankline も buffer-local 値を参照する

  { -- ① インデント幅を filetype 毎に設定
    'LazyVim/LazyVim', -- ダミー。どのプラグインより先に実行させたいだけ
    init = function()
      local indent_by_ft = {
        python = 4,
        lua = 4,
        javascript = 4,
        typescript = 4,
        json = 4,
        rust = 4,
        cpp = 4,
        sh = 4,
      }

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(evt)
          local width = indent_by_ft[evt.match]
          if not width then return end
          -- Set buffer-local options
          vim.o.shiftwidth = width
          vim.o.tabstop = width
          vim.o.softtabstop = width
          vim.o.expandtab = true
        end,
      })
    end,
  },

  { -- ② indent-blankline.nvim の追加設定（必要なら）
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = '│', -- Guide character
      show_current_context = true,
      use_treesitter = true,
    },
  },
}
