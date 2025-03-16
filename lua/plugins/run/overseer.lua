return {
  "stevearc/overseer.nvim",
  cmd = {
    "OverseerToggle",
    "OverseerRun",
    "OverseerRunCmd",
    "OverseerInfo",
    "OverseerBuild",
    "OverseerQuickAction",
    "OverseerTaskAction",
  },
  keys = {
    { "<F5>", "<cmd>OverseerToggle<cr>",     desc = "Task List" },
    { "<F6>", "<cmd>OverseerRun<cr>",        desc = "Run Task" },
    { "<F7>", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
  },
  opts = {},
}
