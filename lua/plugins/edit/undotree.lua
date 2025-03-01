return {
  "jiaoshijie/undotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader><leader>u", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle Undo Tree" },
  },
  opts = {},
}
