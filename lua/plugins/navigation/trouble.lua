return {
  "folke/trouble.nvim",
  cmd = { "Trouble" },
  keys = {
    { "<leader><leader>l", "<cmd>Trouble loclist toggle<cr>",     desc = "Location List (Trouble)" },
    { "<leader><leader>q", "<cmd>Trouble qflist toggle<cr>",      desc = "Quickfix List (Trouble)" },
    { "<leader><leader>d", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    {
      "[q",
      function()
        if require("trouble").is_open() then
          require("trouble").prev({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Previous Trouble/Quickfix Item",
    },
    {
      "]q",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Next Trouble/Quickfix Item",
    },
  },
  opts = {},
}
