-- clipboard
vim.keymap.set("v", "<Leader>y", '"+y', { silent = true, desc = "Yank to system clipboard." })
vim.keymap.set("n", "<Leader>p", '"+p', { silent = true, desc = "Paste from system clipboard." })

-- terminal
vim.keymap.set("t", "<localleader><localleader>", "<C-\\><C-n>", { silent = true, desc = "Exit insert mode in terminal." })

-- %% -> local path
vim.keymap.set(
  'c',
  '%%',
  "getcmdtype() == ':' ? expand('%:h').'/' : '%%'",
  { expr = true, noremap = true }
)
