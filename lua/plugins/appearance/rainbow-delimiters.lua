return {
  "HiPhish/rainbow-delimiters.nvim",
  event = "VeryLazy",
  config = function()
    vim.g.rainbow_delimiters = {
      highlight = {
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterRed',
        -- 'RainbowDelimiterYellow',
        -- 'RainbowDelimiterViolet',
        -- 'RainbowDelimiterCyan',
      },
    }
  end,
}
