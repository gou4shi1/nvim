-- clipboard
vim.keymap.set("v", "<Leader>y", '"+y', { silent = true, desc = "Yank to system clipboard." })
vim.keymap.set("n", "<Leader>p", '"+p', { silent = true, desc = "Paste from system clipboard." })

-- snippet
vim.keymap.set({ 'i', 's' }, '<C-j>', function()
  if vim.snippet.active({ direction = 1 }) then
    return '<cmd>lua vim.snippet.jump(1)<cr>'
  else
    return '<C-j>'
  end
end, { expr = true })
vim.keymap.set({ 'i', 's' }, '<C-k>', function()
  if vim.snippet.active({ direction = -1 }) then
    return '<cmd>lua vim.snippet.jump(-1)<cr>'
  else
    return '<C-k>'
  end
end, { expr = true })

-- terminal
vim.keymap.set("t", "<localleader><localleader>", "<C-\\><C-n>", { silent = true, desc = "Exit insert mode in terminal." })

-- %% -> local path
vim.keymap.set(
  'c',
  '%%',
  "getcmdtype() == ':' ? expand('%:h').'/' : '%%'",
  { expr = true, noremap = true }
)

-- TODO: remove after v0.11.0
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
