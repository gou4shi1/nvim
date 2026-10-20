return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      servers = {
        clangd = {},
        pyright = {},
        gopls = {
          settings = { gopls = { semanticTokens = true } },
        },
        lua_ls = {
          settings = {
            Lua = {
              codeLens = { enable = false },
              workspace = { checkThirdParty = false },
            },
          },
        },
        ts_ls = {},
        eslint = {},
        jsonls = {},
        yamlls = {},
        bashls = {},
        vimls = {},
        sqls = {},
        marksman = {},
        typos_lsp = {},
        nil_ls = {
          settings = { ["nil"] = { formatting = { command = { "nixpkgs-fmt" } } } },
        },
        asm_lsp = {
          cmd = { "asm-lsp" },
          filetypes = { "asm" },
        },
      },
    },
    config = function(_, opts)
      for server, sopts in pairs(opts.servers) do
        if type(sopts) == "table" and next(sopts) then
          vim.lsp.config(server, sopts)
        end
        vim.lsp.enable(server)
      end
      vim.lsp.codelens.enable(true)
    end,
    keys = {
      {
        "<localleader>d",
        function()
          vim.lsp.buf.code_action({
            context = { only = { "quickfix" } },
            filter = function(a) return a.isPreferred end,
            apply = true,
          })
        end, { desc = "Quickfix Current" } },
      {
        "<leader>ih",
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
        end,
        desc = "Toggle Inlay Hints",
      },
      {
        "<leader>cl",
        function()
          vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled({ bufnr = 0 }), { bufnr = 0 })
        end,
        desc = "Toggle Code Lens",
      },
      {
        "grh",
        function()
          vim.lsp.buf.execute({
            command = "textDocument/switchSourceHeader",
            arguments = { vim.uri_from_bufnr(0) },
          })
        end,
        desc = "Switch Source/Header",
      },
    },
  },
  -- fzf override lsp-defaults
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "grr",    "<cmd>FzfLua lsp_references<cr>",             desc = "References" },
      { "gri",    "<cmd>FzfLua lsp_implementations<cr>",        desc = "Implementations" },
      { "grt",    "<cmd>FzfLua lsp_typedefs<cr>",               desc = "Type Definitions" },
      { "gru",    "<cmd>FzfLua lsp_incoming_calls<cr>",         desc = "Function Users" },
      { "<C-f>d", "<cmd>FzfLua lsp_document_diagnostics<cr>",   desc = "Diagnostics (Buffer)" },
      { "<C-f>t", "<cmd>FzfLua lsp_document_symbols<cr>",       desc = "Document Symbols" },
      { "<C-f>s", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "Workspace Symbols" },
    },
  },
}
