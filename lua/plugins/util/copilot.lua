return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        auto_trigger = true,
      }
    },
  },
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      strategies = {
        chat = {
          opts = {
            completion_provider = "coc",
          },
        },
      },
    },
    keys = {
      { "<leader>cc", "<cmd>CodeCompanion<cr>", desc = "Trigger CodeCompanion" },
    },
  },
}
