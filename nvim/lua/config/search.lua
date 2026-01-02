-- lua/config/search.lua
local M = {}

function M.star_highlight_no_jump()
  local w = vim.fn.expand("<cword>")
  if w == nil or w == "" then
    return
  end

  -- Escape characters that have special meaning in Vim regex
  local escaped = vim.fn.escape(w, [[\.^$~\[\]*+?(){}|]])
  local pat = [[\<]] .. escaped .. [[\>]]

  -- Set last search pattern (same thing * does)
  vim.fn.setreg("/", pat)

  -- Ensure matches are highlighted
  vim.opt.hlsearch = true

  -- Make sure `n` goes forward and `N` goes backward after this
  vim.v.searchforward = 1

  -- Move cursor to the beginning of the *current* match (current word head)
  -- b: backward, c: accept current position, W: no wrap
  vim.fn.search(pat, "bcW")
end

return M

