local comment = {
    'numToStr/Comment.nvim',
    module = { "Comment", "Comment.api" },
    keys = { "gc", "gb" },
    config = function()
      require 'Comment'.setup()
    end,
}
return comment
