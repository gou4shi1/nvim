return {
  "snacks.nvim",
  keys = {
    { "<Leader>q",  function() Snacks.bufdelete() end,       desc = "Delete buffers without disrupting windows." },
    { "<Leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete all buffers except the current one." },
    { "<Leader>gb", function() Snacks.git.blame_line() end,  desc = "Git Blame Line." },
  },
  opts = {
    indent = { enabled = true },
    scope = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    styles = {
      notification = {
        focusable = false,
      },
    },
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
  config = function(_, opts)
    local notify = vim.notify
    require("snacks").setup(opts)
    -- HACK: restore vim.notify after snacks setup and let noice.nvim take over
    -- this is needed to have early notifications show up in noice history
    if LazyVim.has("noice.nvim") then
      vim.notify = notify
    end
  end,
}
