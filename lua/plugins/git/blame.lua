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
