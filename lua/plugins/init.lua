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
}
