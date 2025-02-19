return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<Leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Keymaps (which-key)",
    },
    {
      "<C-w><Space>",
      function()
        require("which-key").show({ keys = "<C-w>", loop = true })
      end,
      desc = "Window Hydra Mode (which-key)",
    },
  },
  opts = {
    preset = "helix",
    spec = {
      { "[",         group = "prev" },
      { "]",         group = "next" },
      { "<leader>b", group = "buffer" },
      { "<leader>n", group = "notice" },
      { "<Leader>t", group = "to" },
    },
  },
}
