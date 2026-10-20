return {
  "stevearc/conform.nvim",
  event = { "LazyFile" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>=",
      function()
        require("conform").format({ async = true })
      end,
      mode = "n",
      desc = "Format Buffer",
    },
    { "<leader>=", "gq", mode = "v", desc = "Format Selected" },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  opts = {
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      go = { "golines" },
      bzl = { "buildifier" },
      python = { "yapf" },
    },
    formatters = {
      golines = {
        prepend_args = { '--base-formatter=gofumpt', '--no-reformat-tags' },
      },
    },
  },
}
