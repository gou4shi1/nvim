return {
  "haya14busa/vim-asterisk",
  keys = {
    -- smartcase
    { "*",   "<Plug>(asterisk-*)",   mode = { "n", "x" }, desc = "improved *" },
    { "#",   "<Plug>(asterisk-#)",   mode = { "n", "x" }, desc = "improved #" },
    { "g*",  "<Plug>(asterisk-g*)",  mode = { "n", "x" }, desc = "improved g*" },
    { "g#",  "<Plug>(asterisk-g#)",  mode = { "n", "x" }, desc = "improved g#" },
    -- stay cursor
    { "z*",  "<Plug>(asterisk-z*)",  mode = { "n", "x" }, desc = "stay cursor z*" },
    { "gz*", "<Plug>(asterisk-gz*)", mode = { "n", "x" }, desc = "stay cursor gz*" },
    { "z#",  "<Plug>(asterisk-z#)",  mode = { "n", "x" }, desc = "stay cursor z#" },
    { "gz#", "<Plug>(asterisk-gz#)", mode = { "n", "x" }, desc = "stay cursor gz#" },
  },
  config = function()
    -- keep relative cursor position across matches.
    vim.g["asterisk#keeppos"] = 1
  end,
}
