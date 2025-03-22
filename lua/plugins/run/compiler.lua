return {
  "Zeioth/compiler.nvim",
  dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
  keys = {
    { "<F8>", "<cmd>CompilerOpen<cr>", desc = "Build && Run" },
  },
  opts = {},
}
