local plugin = {
  'glepnir/galaxyline.nvim',
  branch = 'main',
  requires = 'kyazdani42/nvim-web-devicons',
}

function plugin.config()
  local gl = require 'galaxyline'
  local gls = gl.section
  gl.short_line_list = { 'LuaTree', 'vista', 'dbui' }
  local colors = {
    bg = '#282c34',
    yellow = '#fabd2f',
    cyan = '#008080',
    darkblue = '#081633',
    green = '#afd700',
    orange = '#FF8800',
    purple = '#5d4d7a',
    magenta = '#d16d9e',
    grey = '#c0c0c0',
    blue = '#0087d7',
    red = '#ec5f67',
  }

  local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand '%:t') ~= 1 then
      return true
    end
    return false
  end

  -- avoid dupilicate mode showing like '-- INSERT --' etc.
  vim.o.showmode = false
  gls.left[1] = {
    ViMode = {
      provider = function()
        local alias = {
          n = 'NORMAL',
          i = 'INSERT',
          c = 'COMMAND',
          v = 'VISUAL',
          V = 'VISUAL LINE',
          [''] = 'VISUAL BLOCK',
          t = 'TERMINAL',
        }
        return '  ' .. alias[vim.fn.mode()] .. ' '
      end,
      highlight = { colors.darkblue, colors.purple, 'bold' },
      separator = ' ',
      separator_highlight = { colors.magenta, colors.darkblue },
    },
  }
  gls.left[2] = {
    FileIcon = {
      provider = 'FileIcon',
      separator = ' ',
      separator_highlight = { colors.magenta, colors.darkblue },
      condition = buffer_not_empty,
      highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.darkblue },
    },
  }
  gls.left[3] = {
    FileName = {
      provider = { 'FileName', 'FileSize' },
      condition = buffer_not_empty,
      highlight = { colors.magenta, colors.darkblue },
      separator = ' ',
      separator_highlight = { colors.magenta, colors.purple },
    },
  }

  gls.left[4] = {
    GitIcon = {
      provider = function()
        return '  '
      end,
      condition = buffer_not_empty,
      highlight = { colors.orange, colors.purple },
    },
  }
  gls.left[5] = {
    GitBranch = {
      provider = 'GitBranch',
      condition = buffer_not_empty,
      highlight = { colors.grey, colors.purple },
    },
  }

  local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
      return true
    end
    return false
  end

  gls.left[6] = {
    DiffAdd = {
      provider = 'DiffAdd',
      condition = checkwidth,
      icon = ' ',
      highlight = { colors.green, colors.purple },
    },
  }
  gls.left[7] = {
    DiffModified = {
      provider = 'DiffModified',
      condition = checkwidth,
      icon = ' ',
      highlight = { colors.orange, colors.purple },
    },
  }
  gls.left[8] = {
    DiffRemove = {
      provider = 'DiffRemove',
      condition = checkwidth,
      icon = ' ',
      highlight = { colors.red, colors.purple },
    },
  }
  gls.right[1] = {
    Space = {
      provider = function()
        return ' '
      end,
      highlight = { colors.grey, colors.purple },
    },
    FileFormat = {
      provider = 'FileFormat',
      highlight = { colors.grey, colors.purple },
    },
  }
  gls.right[2] = {
    LineInfo = {
      provider = 'LineColumn',
      separator = ' | ',
      separator_highlight = { colors.darkblue, colors.purple },
      highlight = { colors.grey, colors.purple },
    },
  }
  gls.right[3] = {
    PerCent = {
      provider = 'LinePercent',
      separator = '  ',
      separator_highlight = { colors.darkblue, colors.purple },
      highlight = { colors.grey, colors.darkblue },
    },
  }
  gls.right[4] = {
    ScrollBar = {
      provider = 'ScrollBar',
      highlight = { colors.yellow, colors.purple },
    },
  }

  gls.short_line_left[1] = {
    BufferType = {
      provider = 'FileTypeName',
      separator = '  ',
      separator_highlight = { colors.purple, colors.bg },
      highlight = { colors.grey, colors.purple },
    },
  }

  gls.short_line_right[1] = {
    BufferIcon = {
      provider = 'BufferIcon',
      separator = '  ',
      separator_highlight = { colors.purple, colors.bg },
      highlight = { colors.grey, colors.purple },
    },
  }
end

return plugin
