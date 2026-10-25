return {
  {
    "zbirenbaum/copilot.lua",
    dependencies = { "copilotlsp-nvim/copilot-lsp" },
    cmd = "Copilot",
    event = vim.fn.filereadable(vim.fn.expand("~/.config/github-copilot/apps.json")) == 1
        and "InsertEnter"
      or nil,
    opts = {
      suggestion = {
        auto_trigger = true,
      },
      nes = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept_and_goto = "<M-l>",
          dismiss = "<Esc>",
        },
      },
    },
    config = function(_, opts)
      -- Upstream validate() misdetects keymap modes (compares action names with keys),
      -- reporting NES normal-mode keys as duplicates of insert-mode suggestion keys.
      require("copilot.keymaps").validate = function(config)
        local logger = require("copilot.logger")
        local seen = {}
        local check = function(keymap, mode_of)
          for action, key in pairs(keymap or {}) do
            if key then
              local id = mode_of(action) .. ":" .. key
              if seen[id] then
                logger.error("Duplicate keymap detected: " .. id .. ", please review your configuration.")
              end
              seen[id] = true
            end
          end
        end
        check(config.suggestion.keymap, function() return "i" end)
        check(config.nes.keymap, function() return "n" end)
        check(config.panel.keymap, function(action) return action == "open" and "i" or "n" end)
      end
      require("copilot").setup(opts)
    end,
  },
  {
    "folke/sidekick.nvim",
    opts = {
      nes = { enabled = false },
      cli = {
        mux = {
          enabled = true,
          backend = "zellij",
        },
      },
    },
    keys = {
      {
        "<leader>cc",
        function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
        desc = "Sidekick Toggle Claude",
      },
      {
        "<leader>cd",
        function() require("sidekick.cli").close() end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>ct",
        function() require("sidekick.cli").send({ msg = "{this}" }) end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>cf",
        function() require("sidekick.cli").send({ msg = "{file}" }) end,
        desc = "Send File",
      },
      {
        "<leader>cv",
        function() require("sidekick.cli").send({ msg = "{selection}" }) end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>cp",
        function() require("sidekick.cli").prompt() end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
    },
  },
}
