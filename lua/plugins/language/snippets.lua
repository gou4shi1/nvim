return {
  {
    "nvim-mini/mini.snippets",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = function()
      local mini_snippets = require("mini.snippets")
      return {
        snippets = { mini_snippets.gen_loader.from_lang() },
      }
    end,
  },
}
