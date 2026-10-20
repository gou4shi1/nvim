return {
  'maxmx03/solarized.nvim',
  optional = true,
  opts = {
    variant = 'autumn',
    on_highlights = function(colors, color)
      return {
        SpellBad = { undercurl = true, strikethrough = false },
        -- git
        CursorLineGitBlame = { fg = "#4b5c6d", italic = true },
        DiffAdded = { fg = colors.git_add },
        DiffRemoved = { fg = colors.git_delete },
        -- semantic
        Parameter = { link = "Identifier" },
        ["@lsp.type.enumMember"] = { fg = "#AD7FA8" },
        ["@lsp.type.namespace"] = { fg = "DarkCyan" },
        ["@lsp.type.property"] = { fg = "DarkGrey" },
        -- reference
        -- LspReferenceText = { link = "CursorColumn" },
        LspReferenceRead = { link = "CursorColumn" },
        LspReferenceWrite = { link = "CursorColumn" },
        -- rainbow
        RainbowDelimiterBlue = { fg = "RoyalBlue3" },
        RainbowDelimiterOrange = { fg = "DarkOrange3" },
        RainbowDelimiterGreen = { fg = "SeaGreen3" },
        RainbowDelimiterRed = { fg = "FireBrick" },
        RainbowDelimiterYellow = { fg = "DarkOrchid3" },
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
