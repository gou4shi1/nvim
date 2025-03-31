return {
  "monaqa/dial.nvim",
  desc = "Increment and decrement numbers, dates, and more",
  keys = {
    { "<C-a>",  function() require("dial.map").manipulate("increment", "normal") end,  desc = "Increment", mode = "n" },
    { "<C-a>",  function() require("dial.map").manipulate("increment", "visual") end,  desc = "Increment", mode = "v" },
    { "<C-x>",  function() require("dial.map").manipulate("decrement", "normal") end,  desc = "Decrement", mode = "n" },
    { "<C-x>",  function() require("dial.map").manipulate("decrement", "visual") end,  desc = "Decrement", mode = "v" },
  },
  opts = function()
    local augend = require("dial.augend")

    local logical_alias = augend.constant.new({
      elements = { "&&", "||" },
      word = false,
      cyclic = true,
    })

    local ordinal_numbers = augend.constant.new({
      -- elements through which we cycle. When we increment, we go down
      -- On decrement we go up
      elements = {
        "first",
        "second",
        "third",
        "fourth",
        "fifth",
        "sixth",
        "seventh",
        "eighth",
        "ninth",
        "tenth",
      },
      -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
      word = false,
      -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
      -- Otherwise nothing will happen when there are no further values
      cyclic = true,
    })

    local weekdays = augend.constant.new({
      elements = {
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday",
      },
      word = true,
      cyclic = true,
    })

    local months = augend.constant.new({
      elements = {
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December",
      },
      word = true,
      cyclic = true,
    })

    local capitalized_boolean = augend.constant.new({
      elements = {
        "True",
        "False",
      },
      word = true,
      cyclic = true,
    })

    return {
      groups = {
        default = {
          augend.integer.alias.decimal,     -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.decimal_int, -- nonnegative and negative decimal number
          augend.integer.alias.hex,         -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.date.alias["%Y/%m/%d"],    -- date (2022/02/19, etc.)
          ordinal_numbers,
          weekdays,
          months,
          capitalized_boolean,
          augend.constant.alias.bool, -- boolean value (true <-> false)
          logical_alias,
        },
        json = {
          augend.semver.alias.semver, -- versioning (v1.1.2)
        },
      },
    }
  end,
  config = function(_, opts)
    -- copy defaults to each group
    for name, group in pairs(opts.groups) do
      if name ~= "default" then
        vim.list_extend(group, opts.groups.default)
      end
    end
    require("dial.config").augends:register_group(opts.groups)
  end,
}
