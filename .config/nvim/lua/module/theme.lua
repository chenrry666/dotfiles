local onenord = {
  'rmehri01/onenord.nvim',
}

function onenord.config()
  require 'onenord'.setup {
    disable = {
      background = true,
    },
  }
end

return onenord
