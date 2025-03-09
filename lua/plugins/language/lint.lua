return {
  "mfussenegger/nvim-lint",
  event = "LazyFile",
  opts = {
    events = { "BufReadPost", "BufWritePost", "InsertLeave" },
    linters_by_ft = {
      proto = { "buf_lint" },
    },
    linters = {
      buf_lint = {
        append_args = { "--disable-symlinks" },
      },
    },
  },
  config = function(_, opts)
    local lint = require("lint")
    for name, linter in pairs(opts.linters) do
      if type(linter) == "table" and type(lint.linters[name]) == "table" then
        lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
        if type(linter.append_args) == "table" then
          lint.linters[name].args = lint.linters[name].args or {}
          vim.list_extend(lint.linters[name].args, linter.append_args)
        end
      else
        lint.linters[name] = linter
      end
    end
    lint.linters_by_ft = opts.linters_by_ft

    local function debounce(ms, fn)
      local timer = vim.uv.new_timer()
      return function()
        timer:start(ms, 0, function()
          timer:stop()
          vim.schedule(fn)
        end)
      end
    end

    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = debounce(100, lint.try_lint),
    })
  end,
}
