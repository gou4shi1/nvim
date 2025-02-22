return {
  {
    "ibhagwan/fzf-lua",
    opts = function(_, opts)
      local fzf = require("fzf-lua")
      local config = fzf.config

      -- Toggle root dir / cwd
      config.defaults.actions.files["ctrl-r"] = function(_, ctx)
        local o = vim.deepcopy(ctx.__call_opts)
        o.buf = ctx.__CTX.bufnr
        o.root = o.root == false
        if o.root then
          o.cwd = LazyVim.root({ buf = o.buf })
        else
          o.cwd = nil
        end
        fzf[ctx.__INFO.cmd](o)
      end
      config.set_action_helpstr(config.defaults.actions.files["ctrl-r"], "toggle-root-dir")

      return {
        "hide",
        "default-title",
        fzf_colors = true,
        winopts = {
          width = 0.8,
          height = 0.8,
          row = 0.5,
          col = 0.5,
          preview = {
            horizontal = "right:50%",
            vertical   = "down:50%",
          },
        },
        files = {
          cwd_prompt = false,
        },
        buffers = {
          formatter = "path.filename_first",
          path_shorten = 10,
          winopts = {
            width = 0.6,
            height = 0.5,
            preview = {
              hidden = true,
            },
          },
        },
        grep = {
          file_icons = false,
          winopts = {
            width = 0.9,
          },
        },
        keymap = {
          builtin = {
            ["<C-u>"] = "preview-page-up",
            ["<C-d>"] = "preview-page-down",
          },
          fzf = {
            ["ctrl-u"] = "preview-page-up",
            ["ctrl-d"] = "preview-page-down",
            ["ctrl-b"] = "half-page-up",
            ["ctrl-f"] = "half-page-down",
            ["ctrl-p"] = "jump",
            ["ctrl-q"] = "select-all+accept", -- to quickfix
          },
        },

        -- configure vim.ui.select
        ui_select = function(fzf_opts, items)
          return vim.tbl_deep_extend("force", fzf_opts, {
            prompt = " ",
            winopts = {
              title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
              title_pos = "center",
            },
          }, fzf_opts.kind == "codeaction" and {
            winopts = {
              layout = "vertical",
              width = 0.5,
              -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
              height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
              preview = {
                layout = "vertical",
                vertical = "down:15,border-top",
              },
            },
          } or {
            winopts = {
              width = 0.5,
              -- height is number of items, with a max of 80% screen height
              height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
            },
          })
        end,
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          vim.ui.select = function(...)
            require("lazy").load({ plugins = { "fzf-lua" } })
            local opts = LazyVim.opts("fzf-lua") or {}
            require("fzf-lua").register_ui_select(opts.ui_select or nil)
            return vim.ui.select(...)
          end
        end,
      })
    end,
    cmd = "FzfLua",
    keys = {
      { "<c-j>",      "<c-j>",                                  ft = "fzf",                    mode = "t", nowait = true },
      { "<c-k>",      "<c-k>",                                  ft = "fzf",                    mode = "t", nowait = true },
      { "<C-f>f",     "<cmd>FzfLua files root=false<cr>",       desc = "Files (cwd)" },
      { "<C-f>p",     "<cmd>FzfLua git_files<cr>",              desc = "Files (project)" },
      { "<C-f>m",     "<cmd>FzfLua oldfiles cwd_only=true<cr>", desc = "Recent (cwd)" },
      { "<C-f>b",     "<cmd>FzfLua buffers<cr>",                desc = "Buffers" },
      { "<C-f>l",     "<cmd>FzfLua blines<cr>",                 desc = "Lines" },
      { "<C-f>w",     "<cmd>FzfLua grep_cword root=false<cr>",  desc = "Grep (cword)" },
      { "<C-f>r",     "<cmd>FzfLua live_grep root=false<cr>",   desc = "Grep (cwd)" },
      { "<C-f>r",     "<cmd>FzfLua grep_visual root=false<cr>", desc = "Grep Selection (cwd)", mode = "v" },
      { "<C-f>q",     "<cmd>FzfLua quickfix<cr>",               desc = "Quickfix List" },
      { "<C-f>:",     "<cmd>FzfLua command_history<cr>",        desc = "Command History" },
      { "<C-f>/",     "<cmd>FzfLua search_history<cr>",         desc = "Search History" },
      { "<C-f>'",     "<cmd>FzfLua marks<cr>",                  desc = "Marks" },
      { "<C-f>k",     "<cmd>FzfLua keymaps<cr>",                desc = "Keymaps" },
      { "<C-f>v",     "<cmd>FzfLua commands<cr>",               desc = "Vim Commands" },
      { "<C-f>h",     "<cmd>FzfLua help_tags<cr>",              desc = "Help Tags" },
      { "<C-f><C-f>", "<cmd>FzfLua resume<cr>",                 desc = "Resume" },
      { "<leader>gl", "<cmd>FzfLua git_commits<cr>",            desc = "Git Log" },
      { "<leader>gs", "<cmd>FzfLua git_status<cr>",             desc = "Git Status" },
    },
  },

  {
    "antoinemadec/coc-fzf",
    dependencies = { "junegunn/fzf", "junegunn/fzf.vim" },
    event = "VeryLazy",
    cmd = "CocFzfList",
    keys = {
      { "<C-f>d", "<cmd>CocFzfList diagnostics --current-buf<cr>", desc = "Diagnostics" },
      { "<C-f>t", "<cmd>CocFzfList outline<cr>",                   desc = "Outline" },
      { "<C-f>s", "<cmd>CocFzfList symbols<cr>",                   desc = "Symbols" },
      { "<C-f>y", "<cmd>CocFzfList yank<cr>",                      desc = "Yank History" },
      { "<C-f>c", "<cmd>CocFzfList commands<cr>",                  desc = "Coc Commands" },
    },
  },
}
