return {
  {
    "snacks.nvim",
    opts = {
      bigfile = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      scope = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      -- scroll = { enabled = true },
    }
  },

  {
    "snacks.nvim",
    opts = {
      dashboard = {
        sections = {
          { title = "Keys",           padding = 1 },
          { section = "keys",         padding = 1 },
          { title = "MRU",            padding = 1 },
          { section = "recent_files", padding = 1, limit = 8 },
          { title = "MRU ",           padding = 1, file = vim.fn.fnamemodify(".", ":~") },
          { section = "recent_files", padding = 1, limit = 8,                           cwd = true },
          { title = "Projects",       padding = 1 },
          { section = "projects" },
          {
            section = "terminal",
            cmd = "pokeget random; sleep .1",
            hl = "header",
            random = 100, -- cache 100 pokemons for each folder
            pane = 2,
            indent = 4,
            height = 30,
          },
        },
      },
    },
  },
}
