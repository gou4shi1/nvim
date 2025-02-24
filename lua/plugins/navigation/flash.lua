return {
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = {
    -- s use leap.nvim instead
    -- { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Jump to any location across windows." },
    { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Jump to parent treesitter nodes." },
    { "<C-s>", mode = { "c" },           function() require("flash").toggle() end,     desc = "Toggle Flash Search" },
    {
      "<Leader>j",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump({
          search = { mode = "search", max_length = 0, wrap = false, },
          label = { after = { 0, 0 } },
          pattern = "^"
        })
      end,
      desc = "Jump to a line forward."
    },
    {
      "<Leader>k",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump({
          search = { mode = "search", max_length = 0, forward = false, wrap = false, },
          label = { after = { 0, 0 } },
          pattern = "^"
        })
      end,
      desc = "Jump to a line forward."
    },
  },
  opts = {
    modes = {
      char = {
        jump_labels = true,
        label = { exclude = "hjkliardxcv" },
        char_actions = function()
          return {
            [";"] = "next",
            [","] = "prev",
          }
        end,
      }
    },
  },
}
