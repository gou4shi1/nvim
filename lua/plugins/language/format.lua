return {
  "stevearc/conform.nvim",
  event = { "LazyFile" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>=",
      function()
        if vim.bo.formatexpr:match("^Coc") then
          vim.fn.CocActionAsync('format')
        else
          require("conform").format({ async = true })
        end
      end,
      mode = "n",
      desc = "Format Buffer",
    },
    { "<leader>=", "gq", mode = "v", desc = "Format Selected" },
  },
  opts = {
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      go = { "golines" },
      bzl = { "buildifier" },
    },
    formatters = {
      golines = {
        prepend_args = { '--base-formatter=gofumpt', '--no-reformat-tags' },
      },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)

    vim.api.nvim_create_autocmd({ "FileType", "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("conform", { clear = true }),
      callback = function()
        if opts.formatters_by_ft[vim.bo.filetype] then
          vim.bo.formatexpr = "v:lua.require'conform'.formatexpr()"
        else
          vim.bo.formatexpr = "CocAction('formatSelected') && 0"
        end
      end,
    })
  end,
}
