local function root_dir(opts)
  opts = vim.tbl_extend("force", {
    cwd = false,
    subdirectory = true,
    parent = true,
    other = true,
    icon = "󱉭 ",
    color = function()
      return { fg = Snacks.util.color("Special") }
    end,
  }, opts or {})

  local function get()
    local cwd = LazyVim.root.cwd()
    local root = LazyVim.root.get({ normalize = true })
    local name = vim.fs.basename(root)

    if root == cwd then
      -- root is cwd
      return opts.cwd and name
    elseif root:find(cwd, 1, true) == 1 then
      -- root is subdirectory of cwd
      return opts.subdirectory and name
    elseif cwd:find(root, 1, true) == 1 then
      -- root is parent directory of cwd
      return opts.parent and name
    else
      -- root and cwd are not related
      return opts.other and name
    end
  end

  return {
    function()
      return (opts.icon and opts.icon) .. get()
    end,
    cond = function()
      return type(get()) == "string"
    end,
    color = opts.color,
  }
end

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
          root_dir(),
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = { left = 1, right = 0 }
          },
          {
            LazyVim.lualine.pretty_path(),
            padding = { left = 0, right = 1 },
          },
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
          {
            "diff",
            source = function()
              local summary = vim.b.minidiff_summary
              return summary
                  and {
                    added = summary.add,
                    modified = summary.change,
                    removed = summary.delete,
                  }
            end,
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
