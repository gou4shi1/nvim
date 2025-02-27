return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "Neotree",
  keys = {
    {
      "-",
      function()
        local dir = vim.fn.expand("%:h")
        local file = vim.fn.expand('%:p')
        local cwd = vim.uv.cwd()
        if dir == nil or dir == "" then
          dir = cwd
        end
        if file == nil or file == "" then
          file = cwd
        end
        require('neo-tree.command').execute({
          position = "current",
          dir = dir,
          reveal_file = file,
          reveal_force_cwd = true,
        })
      end,
      desc = "File Explorer (Current File)",
    },
    {
      "<Leader><Leader>f",
      function()
        require("neo-tree.command").execute({ dir = LazyVim.root(), toggle = true })
      end,
      desc = "File Explorer (Root Dir)",
    },
    {
      "<leader>ge",
      function()
        require("neo-tree.command").execute({ source = "git_status", toggle = true })
      end,
      desc = "Git Explorer",
    },
  },
  init = function()
    -- to hijack netrw with lazy loading
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
      desc = "Start neo-tree with directory",
      once = true,
      callback = function()
        if package.loaded["neo-tree"] then
          return
        else
          local stats = vim.uv.fs_stat(vim.fn.argv(0))
          if stats and stats.type == "directory" then
            require("neo-tree")
          end
        end
      end,
    })
  end,
  opts = {
    commands = {
      navigate_up_reveal_parent = function(state)
        local fs = require("neo-tree.sources.filesystem")
        local utils = require("neo-tree.utils")
        local parent_path, _ = utils.split_path(state.path)
        if not utils.truthy(parent_path) then
          return
        end
        local path_to_reveal = nil
        local node = state.tree:get_node()
        if node then
          path_to_reveal = node:get_parent_id()
        end
        if state.search_pattern then
          fs.reset_search(state, false)
        end
        fs._navigate_internal(state, parent_path, path_to_reveal, nil, false)
      end,
      set_root_or_open = function(state)
        local fsc = require("neo-tree.sources.filesystem.commands")
        local node = state.tree:get_node()
        if node.type == "directory" then
          fsc.set_root(state)
        else
          fsc.open(state)
        end
      end,
      copy_path_to_system_clipboard = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        vim.fn.setreg("+", path, "c")
      end,
      open_with_system_app = function(state)
        require("lazy.util").open(state.tree:get_node().path, { system = true })
      end,
    },
    default_component_configs = {
      indent = { with_expanders = true },
    },
    window = {
      mappings = {
        ["h"] = "close_node",
        ["l"] = "open",
        ["-"] = "navigate_up_reveal_parent",
        ["<CR>"] = "set_root_or_open",
        ["/"] = "noop",
        ["<Leader>/"] = "fuzzy_finder",
        ["<Leader>y"] = "copy_path_to_system_clipboard",
        ["<Leader><CR>"] = "open_with_system_app",
      },
      fuzzy_finder_mappings = {
        ["<C-j>"] = "move_cursor_down",
        ["<C-k>"] = "move_cursor_up",
      },
    },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = { visible = true },
      hijack_netrw_behavior = "open_current",
    },
    git_status = {
      window = {
        position = "float",
      },
    },
  },
}
