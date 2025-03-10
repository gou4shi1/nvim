return {
  "neoclide/coc.nvim",
  branch = "release",
  dependencies = { "rafamadriz/friendly-snippets" },
  event = { "VeryLazy" },
  config = function()
    vim.g.coc_global_extensions = {
      'coc-lists', 'coc-yank', 'coc-snippets', 'coc-typos',
      'coc-clangd', 'coc-json', 'coc-yaml', 'coc-sh', 'coc-pyright', 'coc-go', 'coc-sql', 'coc-vimlsp', 'coc-lua',
      'coc-webview', 'coc-markdown-preview-enhanced', '@yaegassy/coc-marksman',
      'coc-tsserver', 'coc-eslint', 'coc-prettier', 'coc-styled-components',
    }

    -- format
    vim.g.coc_trim_trailing_whitespace = 1
    vim.g.coc_trim_final_newlines = 1
    -- config in format.lua
    -- vim.keymap.set("n", "<Leader>=", "<Plug>(coc-format)", { silent = true })
    -- vim.keymap.set("x", "<Leader>=", "<Plug>(coc-format-selected)", { silent = true })

    -- completion
    function _G.check_back_space()
      local col = vim.fn.col('.') - 1
      return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
    end

    local opts = { silent = true, expr = true, replace_keycodes = false }
    vim.keymap.set("i", "<TAB>",
      'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
    vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
    vim.keymap.set("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
      opts)

    -- snippets
    vim.api.nvim_create_user_command(
      "SnipFiles",
      "CocCommand snippets.openSnippetFiles",
      {}
    )
    vim.api.nvim_create_user_command(
      "SnipUser",
      "CocCommand snippets.editSnippets",
      {}
    )

    -- code action
    vim.keymap.set("n", "<localleader>d", "<Plug>(coc-fix-current)", { silent = true })
    vim.keymap.set("n", "<leader><leader>a", "<Plug>(coc-codeaction-cursor)", { silent = true })
    vim.keymap.set("x", "<leader><leader>a", "<Plug>(coc-codeaction-selected)", { silent = true })

    -- navigation
    -- <C-]> to jump to definition, <C-t> to jump back
    vim.o.tagfunc = "CocTagFunc"
    vim.keymap.set("n", "<leader>tr", "<Plug>(coc-references)", { silent = true })
    vim.keymap.set("n", "<leader>tu", "<Plug>(coc-references-used)", { silent = true })
    vim.keymap.set("n", "<leader>tt", "<Plug>(coc-type-definition)", { silent = true })
    vim.keymap.set("n", "<leader>ti", "<Plug>(coc-implementation)", { silent = true })

    -- hover
    local function show_docs()
      local cw = vim.fn.expand('<cword>')
      if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
      elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
      else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
      end
    end

    vim.keymap.set("n", "K", show_docs, { silent = true })

    vim.api.nvim_create_autocmd("CursorHold", {
      command = "silent call CocActionAsync('highlight')",
    })

    -- outline
    local function toggle_outline()
      local winid = vim.fn["coc#window#find"]("cocViewId", "OUTLINE")
      if winid == -1 then
        vim.fn.CocActionAsync("showOutline", 1)
      else
        vim.fn["coc#window#close"](winid)
      end
    end

    vim.keymap.set("n", "<Leader><Leader>t", toggle_outline, { silent = true, desc = "Toggle Outline" })

    -- rename
    vim.keymap.set("n", "<F2>", "<Plug>(coc-rename)", { silent = true })

    -- coc-clangd
    vim.keymap.set("n", "<leader>th", ":CocCommand clangd.switchSourceHeader<CR>", { silent = true })
    vim.keymap.set("n", "<leader>il", ":CocCommand document.toggleInlayHint<CR>", { silent = true })

    -- coc-markdown-preview-enhanced
    vim.keymap.set("n", "<leader>md", ":CocCommand markdown-preview-enhanced.openPreview<CR>", { silent = true })

    -- coc-typos
    vim.keymap.set("n", "[s", "<Plug>(coc-typos-prev)", { silent = true })
    vim.keymap.set("n", "]s", "<Plug>(coc-typos-next)", { silent = true })
    vim.keymap.set("n", "z=", "<Plug>(coc-typos-fix)", { silent = true })
  end,
}
