return {
  "tummetott/unimpaired.nvim",
  event = 'VeryLazy',
  opts = {
    keymaps = {
      -- config in buffline.lua
      bprevious = false,
      bnext = false,
    },
  },
  config = function(_, opts)
    require("unimpaired").setup(opts)

    -- Port missing functionalities from unimpaired.vim
    -- Section: Put
    local function putline(how, map)
      local body = vim.fn.getreg(vim.v.register)
      local regtype = vim.fn.getregtype(vim.v.register)
      if regtype == 'V' then -- Linewise selection
        vim.cmd('normal! "' .. vim.v.register .. how)
      else
        -- Temporarily convert to linewise
        vim.fn.setreg(vim.v.register, body, 'l')
        vim.cmd('normal! "' .. vim.v.register .. how)
        -- Restore original type
        vim.fn.setreg(vim.v.register, body, regtype)
      end
      -- Set up repeat (requires vim-repeat plugin)
      pcall(vim.fn['repeat#set'],
        vim.api.nvim_replace_termcodes('<Plug>(unimpaired-put-' .. map .. ')', true, true, true))
    end

    local function count_putline(how, map, postprocess)
      local count = vim.v.count1
      putline(tostring(count) .. how, map)
      vim.cmd("normal! " .. postprocess)
    end

    local map_opts = { silent = true }

    vim.keymap.set('n', '<Plug>(unimpaired-put-above)', function()
      putline('[p', 'above')
    end, map_opts)
    vim.keymap.set('n', '<Plug>(unimpaired-put-below)', function()
      putline(']p', 'below')
    end, map_opts)
    vim.keymap.set('n', '<Plug>(unimpaired-put-above-rightward)', function()
      count_putline('[p', 'Above', ">']")
    end, map_opts)
    vim.keymap.set('n', '<Plug>(unimpaired-put-below-rightward)', function()
      count_putline(']p', 'Below', ">']")
    end, map_opts)
    vim.keymap.set('n', '<Plug>(unimpaired-put-above-leftward)', function()
      count_putline('[p', 'Above', "<']")
    end, map_opts)
    vim.keymap.set('n', '<Plug>(unimpaired-put-below-leftward)', function()
      count_putline(']p', 'Below', "<']")
    end, map_opts)
    vim.keymap.set('n', '<Plug>(unimpaired-put-above-reformat)', function()
      count_putline('[p', 'Above', "=']")
    end, map_opts)
    vim.keymap.set('n', '<Plug>(unimpaired-put-below-reformat)', function()
      count_putline(']p', 'Below', "=']")
    end, map_opts)

    local mappings = {
      ['[p'] = '<Plug>(unimpaired-put-above)',
      [']p'] = '<Plug>(unimpaired-put-below)',
      ['[P'] = '<Plug>(unimpaired-put-above)',
      [']P'] = '<Plug>(unimpaired-put-below)',
      ['>P'] = '<Plug>(unimpaired-put-above-rightward)',
      ['>p'] = '<Plug>(unimpaired-put-below-rightward)',
      ['<P'] = '<Plug>(unimpaired-put-above-leftward)',
      ['<p'] = '<Plug>(unimpaired-put-below-leftward)',
      ['=P'] = '<Plug>(unimpaired-put-above-reformat)',
      ['=p'] = '<Plug>(unimpaired-put-below-reformat)',
    }
    for lhs, rhs in pairs(mappings) do
      vim.keymap.set('n', lhs, rhs, map_opts)
    end
  end,
}
