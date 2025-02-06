return {
  'maxmx03/solarized.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    variant = 'autumn',
  },
  config = function(_, opts)
    vim.o.termguicolors = true
    vim.o.background = 'dark'
    require('solarized').setup(opts)
    vim.cmd.colorscheme 'solarized'
  end,
}
