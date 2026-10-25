-- Clear search highlighting once the cursor leaves the match
-- (replaces is.vim: n/N keep highlights, any move off the match clears them)
vim.api.nvim_create_autocmd("CursorMoved", {
  group = vim.api.nvim_create_augroup("auto_nohlsearch", { clear = true }),
  callback = function()
    -- schedule: v:hlsearch is restored across function boundaries,
    -- so :nohlsearch must run outside the autocmd callback
    vim.schedule(function()
      if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
        vim.cmd("nohlsearch")
      end
    end)
  end,
})

-- Restore cursor to its last position when reopening a file (replaces vim-lastplace)
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("restore_last_place", { clear = true }),
  callback = function(args)
    -- the view set during BufReadPost is reset before the window is shown, so defer to BufWinEnter
    vim.api.nvim_create_autocmd("BufWinEnter", {
      buffer = args.buf,
      once = true,
      callback = function()
        local ft = vim.bo[args.buf].filetype
        if vim.bo[args.buf].buftype ~= "" or ft:match("commit") or ft:match("rebase") then
          return
        end
        local line = vim.api.nvim_buf_get_mark(args.buf, '"')[1]
        local last = vim.api.nvim_buf_line_count(args.buf)
        if line <= 1 or line > last then
          return
        end
        if vim.fn.line("w$") == last then
          vim.cmd('keepjumps normal! g`"')
        elseif last - line > (vim.fn.line("w$") - vim.fn.line("w0")) / 2 - 1 then
          vim.cmd('keepjumps normal! g`"zz')
        else
          -- near the end: scroll to the bottom first so the window is filled with context
          vim.cmd('keepjumps normal! Gg`"')
        end
        if vim.fn.foldclosed(".") ~= -1 then
          vim.cmd("normal! zvzz")
        end
      end,
    })
  end,
})
