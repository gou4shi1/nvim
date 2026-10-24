return {
  "nvim-mini/mini.surround",
  keys = {
    { "<leader>sa", desc = "Add Surrounding",                mode = { "n", "v" } },
    { "<leader>sd", desc = "Delete Surrounding" },
    { "<leader>sr", desc = "Replace Surrounding" },
    { "<leader>sf", desc = "Find Surrounding (to the right)" },
    { "<leader>sF", desc = "Find Surrounding (to the left)" },
    { "<leader>sh", desc = "Highlight Surrounding" },
  },
  opts = {
    mappings = {
      add = "<leader>sa",
      delete = "<leader>sd",
      replace = "<leader>sr",
      find = '<leader>sf',
      find_left = '<leader>sF',
      highlight = '<leader>sh',
    },
  },
}
