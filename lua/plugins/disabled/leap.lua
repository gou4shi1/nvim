return {
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    "ggandor/leap.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Jump to anywhere with 2-chars." },
    },
    opts = {
      safe_labels = {},
      equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      vim.keymap.set('n', 's', '<Plug>(leap-anywhere)')
      vim.keymap.set({ 'x', 'o' }, 's', '<Plug>(leap)')
    end,
  },
  {
    "ggandor/flit.nvim",
    keys = function()
      local ret = {}
      for _, key in ipairs({ "f", "F", "t", "T" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" } }
      end
      return ret
    end,
    opts = { labeled_modes = "nv" },
  },
}
