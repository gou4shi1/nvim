return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "saghen/blink.lib",
      "marcoSven/blink-cmp-yanky",
    },
    build = "nix build .#blink-cmp --out-link result && cp -Lf result/lib/libblink_cmp_fuzzy.so lib/ && rm -f result",
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
      snippets = {
        preset = "mini_snippets",
      },
      cmdline = {
        completion = {
          menu = {
            auto_show = function(ctx)
              return vim.fn.getcmdtype() == ":"
            end,
          },
        },
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
