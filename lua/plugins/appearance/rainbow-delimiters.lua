return {
  "HiPhish/rainbow-delimiters.nvim",
  submodules = false,
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
