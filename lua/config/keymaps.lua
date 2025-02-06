-- clipboard
vim.keymap.set("v", "<Leader>y", '"+y', { silent = true, desc = "Yank to system clipboard." })
vim.keymap.set("n", "<Leader>p", '"+p', { silent = true, desc = "Paste from system clipboard." })

-- %% -> local path
vim.keymap.set(
  'c',
  '%%',
  "getcmdtype() == ':' ? expand('%:h').'/' : '%%'",
  { expr = true, noremap = true }
)
