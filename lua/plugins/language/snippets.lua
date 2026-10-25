return {
  {
    "nvim-mini/mini.snippets",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = function()
      local mini_snippets = require("mini.snippets")
      return {
        snippets = { mini_snippets.gen_loader.from_lang() },
        expand = {
          -- Hide empty tabstop markers, they linger as undeletable virtual text
          insert = function(snippet)
            return mini_snippets.default_insert(snippet, { empty_tabstop = "", empty_tabstop_final = "" })
          end,
        },
      }
    end,
  },
}
