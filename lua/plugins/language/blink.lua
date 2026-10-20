return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = { "saghen/blink.lib" },
    build = "nix build .#blink-cmp --out-link result && cp -Lf result/lib/libblink_cmp_fuzzy.so lib/ && rm -f result",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
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
