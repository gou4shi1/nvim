return {
  { "folke/lazy.nvim", version = "*" },
  {
    "LazyVim/LazyVim",
    version = "*",
    lazy = false,
    priority = 10000,
    config = function()
      _G.LazyVim = require("lazyvim.util")
    end,
  },
  {
    'maxmx03/solarized.nvim',
    lazy = false,
    priority = 9000,
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
  },
}
