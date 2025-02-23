return {
  'maxmx03/solarized.nvim',
  optional = true,
  opts = {
    variant = 'autumn',
  },
  config = function(_, opts)
    vim.o.termguicolors = true
    vim.o.background = 'dark'
    require('solarized').setup(opts)
    vim.cmd.colorscheme 'solarized'

    vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true })
    vim.api.nvim_set_hl(0, "CursorLineGitBlame", { fg = "#4b5c6d", italic = true })
  end,
}
