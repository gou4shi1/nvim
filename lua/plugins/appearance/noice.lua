return {
  "gou4shi1/noice.nvim",
  event = "VeryLazy",
  keys = {
    { "<Leader>nl", desc = "Noice Last Message", function() require("noice").cmd("last") end },
    { "<Leader>nh", desc = "Noice History",      function() require("noice").cmd("history") end },
    { "<Leader>na", desc = "Noice All",          function() require("noice").cmd("all") end },
    { "<Leader>nd", desc = "Dismiss All",        function() require("noice").cmd("dismiss") end },
    { "<Leader>np", desc = "Noice Picker",       function() require("noice").cmd("pick") end },
    { "<C-enter>",  desc = "Redirect Cmdline",   function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c" },
  },
  opts = {
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
    },
    messages = {
      view_search = false,
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
            { find = "%d more lines" },
            { find = "%d fewer lines" },
          },
        },
        view = "mini",
      },
    },
  },
  config = function(_, opts)
    -- HACK: noice shows messages from before it was enabled,
    -- but this is not ideal when Lazy is installing plugins,
    -- so clear the messages in this case.
    if vim.o.filetype == "lazy" then
      vim.cmd([[messages clear]])
    end
    require("noice").setup(opts)
  end,
}
