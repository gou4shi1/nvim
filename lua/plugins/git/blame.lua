return {
  {
    "f-person/git-blame.nvim",
    event = { "VeryLazy" },
    opts = {
      message_template = "    <author> • <date> • <summary>",
      date_format = "%r",
      virtual_text_column = 20,
      highlight_group = "CursorLineGitBlame",
      set_extmark_options = {
        hl_mode = "combine",
      },
    },
    config = function(_, opts)
      require("gitblame").setup(opts)
      -- Disable virtual text in insert mode, re-enable in normal mode
      vim.api.nvim_create_autocmd({ "InsertEnter" }, {
        callback = function()
          vim.cmd("GitBlameDisable")
        end,
      })
      vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        callback = function()
          vim.cmd("GitBlameEnable")
        end,
      })
    end,
  },

  {
    "FabijanZulj/blame.nvim",
    cmd = "BlameToggle",
    keys = {
      { "<Leader>gB", "<cmd>BlameToggle<cr>", desc = "Git Blame File" },
    },
    opts = {
      date_format = "%Y.%m.%d",
      blame_options = { '-w' },
    },
  },
}
