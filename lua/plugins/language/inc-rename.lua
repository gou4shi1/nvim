return {
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    keys = {
      {
        "grn",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Incremental Rename",
      },
    },
    opts = {},
  },

  {
    "gou4shi1/noice.nvim",
    optional = true,
    opts = {
      presets = {
        inc_rename = true,
      },
    },
  },
}
