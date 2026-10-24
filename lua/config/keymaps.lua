-- terminal
vim.keymap.set("t", "<localleader><localleader>", "<C-\\><C-n>", { silent = true, desc = "Exit insert mode in terminal." })

-- %% -> local path
vim.keymap.set(
  'c',
  '%%',
  "getcmdtype() == ':' ? expand('%:h').'/' : '%%'",
  { expr = true, noremap = true }
)
