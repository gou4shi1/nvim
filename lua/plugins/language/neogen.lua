return {
  "danymat/neogen",
  cmd = "Neogen",
  keys = {
    {
      "<leader>do",
      function()
        require("neogen").generate()
      end,
      desc = "Generate Annotations (Neogen)",
    },
  },
  opts = {
    snippet_engine = "nvim"
  },
}
