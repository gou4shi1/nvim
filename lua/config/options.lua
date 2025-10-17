-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- indent
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- fold
vim.opt.foldenable = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.require'lazyvim.util'.treesitter.foldexpr()"

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- recovery
vim.opt.undofile = true
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- timeout
vim.opt.timeoutlen = 500
vim.opt.updatetime = 1000

-- sign
vim.opt.number = true
vim.opt.signcolumn = "yes"

-- mouse
vim.opt.mouse = "a"
vim.cmd([[aunmenu PopUp.How-to\ disable\ mouse]])
vim.cmd([[aunmenu PopUp.-1-]])

-- cursor
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- wrap
vim.opt.wrap = false
vim.opt.fixeol = false

-- scroll
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.jumpoptions = "view"

-- split
vim.opt.splitright = true
-- vim.opt.splitkeep = "screen"

-- window
vim.opt.winminwidth = 5
vim.opt.pumheight = 20
vim.opt.pumblend = 10

-- conceal
vim.opt.conceallevel = 2

-- wild
vim.opt.wildmode = "longest:full,full"

-- message
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- diagnostic
vim.diagnostic.config({
  virtual_text = false,
  jump = { float = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
})

-- clipboard
if vim.env.SSH_TTY ~= nil then
  vim.g.clipboard = "osc52"
end
