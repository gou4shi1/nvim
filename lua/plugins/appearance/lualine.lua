return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.showmode = false
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- PERF: we don't need this lualine require madness
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    vim.o.laststatus = vim.g.lualine_laststatus

    local opts = {
      options = {
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { "snacks_dashboard" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          LazyVim.lualine.root_dir(),
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = { left = 1, right = 0 }
          },
          { LazyVim.lualine.pretty_path() },
          {
            'b:coc_current_function',
            color = {
              gui = 'italic',
              fg = Snacks.util.color("Function"),
            },
          },
          {
            'g:coc_status',
            color = {
              fg = Snacks.util.color("Comment"),
            },
          },
        },

        lualine_x = {
          Snacks.profiler.status(),
          {
            function() return require("noice").api.status.search.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.search.has() end,
            color = function() return { fg = Snacks.util.color("Keyword") } end,
          },
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = function() return { fg = Snacks.util.color("Constant") } end,
          },
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn  = " ",
              info  = " ",
              hint  = " ",
            },
          },
        },
        lualine_y = {
          { "progress", padding = { left = 1, right = 0 }, separator = " " },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = { "encoding" },
      },
      extensions = { "lazy", "fzf" },
    }

    return opts
  end,
}
