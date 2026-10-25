-- Shell builds are killed after lazy's git.timeout (2 min), too short for a cold nix store to fetch the toolchain.
local function nix_build(plugin)
  local cmd = "nix build .#blink-cmp --out-link result && mkdir -p lib && cp -Lf result/lib/libblink_cmp_fuzzy.so lib/ && rm -f result"
  local proc = require("lazy.manage.process").spawn({ "sh", "-c", cmd }, { cwd = plugin.dir, timeout = 30 * 60 * 1000 })
  proc:wait()
  if proc.code ~= 0 or proc.signal ~= 0 then
    error(proc.data)
  end
end

return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "saghen/blink.lib",
      "marcoSven/blink-cmp-yanky",
    },
    build = nix_build,
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
      sources = {
        default = { "lsp", "path", "buffer", "snippets", "yank" },
        providers = {
          yank = {
            name = "yank",
            module = "blink-yanky",
          },
        },
      },
      completion = {
        menu = {
          draw = { treesitter = { "lsp" } },
        },
        documentation = {
          auto_show = true,
        },
      },
      cmdline = {
        keymap = {
          preset = "cmdline",
          ["<Left>"] = false,
          ["<Right>"] = false,
        },
        completion = {
          list = { selection = { preselect = false } },
          menu = {
            auto_show = function(ctx)
              return vim.fn.getcmdtype() == ":"
            end,
          },
        },
      },
      snippets = {
        preset = "mini_snippets",
      },
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "snippet_forward", "fallback" },
        ["<C-k>"] = { "snippet_backward", "fallback" },
      },
    },
  },
}
