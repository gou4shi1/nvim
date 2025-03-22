return {
  'akinsho/git-conflict.nvim',
  version = "*",
  event = "LazyFile",
  opts = {
    default_mappings = {
      ours = 'co',
      theirs = 'ct',
      none = 'cn',
      both = 'cb',
      prev = '[<',
      next = ']>',
    },
  },
}
