return {
  'maxmx03/solarized.nvim',
  optional = true,
  opts = {
    variant = 'autumn',
    on_highlights = function(colors, color)
      return {
        SpellBad = { undercurl = true, strikethrough = false },
        CursorLineGitBlame = { fg = "#4b5c6d", italic = true },
        -- semantic
        Parameter = { link = "Identifier" },
        CocSemTypeEnumMember = { fg = "#AD7FA8" },
        CocSemTypeNamespace = { fg = "DarkCyan" },
        CocSemTypeProperty = { fg = "DarkGrey" },
      }
    end,
  },
  config = function(_, opts)
    vim.o.termguicolors = true
    vim.o.background = 'dark'
    require('solarized').setup(opts)
    vim.cmd.colorscheme 'solarized'
  end,
}
