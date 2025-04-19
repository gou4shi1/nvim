return {
  "gou4shi1/leap.nvim",
  keys = {
    { "s", mode = { "n", "x", "o" }, desc = "Jump to anywhere with 2-chars." },
  },
  opts = {
    equivalence_classes = { ' \t\r\n', '[{', ']}', '\'"`' },
  },
  config = function(_, opts)
    local leap = require("leap")
    for k, v in pairs(opts) do
      leap.opts[k] = v
    end
    vim.keymap.set('n', 's', '<Plug>(leap-anywhere)')
    vim.keymap.set({ 'x', 'o' }, 's', '<Plug>(leap)')
  end,
}
