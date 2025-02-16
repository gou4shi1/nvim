return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
    { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
    { "[B",         "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer prev" },
    { "]B",         "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer next" },
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle Pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete Buffers to the Right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete Buffers to the Left" },
  },
  opts = {
    options = {
      separator_style = "slant",
      always_show_bufferline = false,
      close_command = function(n) Snacks.bufdelete(n) end,
      right_mouse_command = function(n) Snacks.bufdelete(n) end,
      diagnostics = "coc",
      offsets = {
        { filetype = "snacks_layout_box" },
      },
    },
    highlights = function()
      local background_color = "#00313e"           -- tint(normal_bg, 30)
      local separator_background_color = "#003746" -- tint(normal_bg, 15)
      return {
        trunc_marker = {
          bg = separator_background_color,
        },
        fill = {
          bg = separator_background_color,
        },
        group_separator = {
          bg = separator_background_color,
        },
        group_label = {
          fg = separator_background_color,
        },
        tab = {
          bg = background_color,
        },
        tab_close = {
          bg = background_color,
        },
        close_button = {
          bg = background_color,
        },
        background = {
          bg = background_color,
        },
        buffer = {
          bg = background_color,
        },
        numbers = {
          bg = background_color,
        },
        diagnostic = {
          bg = background_color,
        },
        hint = {
          bg = background_color,
        },
        hint_diagnostic = {
          bg = background_color,
        },
        info = {
          bg = background_color,
        },
        info_diagnostic = {
          bg = background_color,
        },
        warning = {
          bg = background_color,
        },
        warning_diagnostic = {
          bg = background_color,
        },
        error = {
          bg = background_color,
        },
        error_diagnostic = {
          bg = background_color,
        },
        modified = {
          bg = background_color,
        },
        duplicate = {
          bg = background_color,
        },
        separator_selected = {
          fg = separator_background_color,
        },
        separator_visible = {
          fg = separator_background_color,
        },
        separator = {
          fg = separator_background_color,
          bg = background_color,
        },
        tab_separator = {
          fg = separator_background_color,
          bg = background_color,
        },
        tab_separator_selected = {
          fg = separator_background_color,
        },
        pick = {
          bg = background_color,
        },
        offset_separator = {
          bg = separator_background_color,
        }
      }
    end,
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
