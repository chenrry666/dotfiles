local plugin = {
  'goolord/alpha-nvim',
}
function plugin.config()
  require 'alpha'.setup(require 'alpha.themes.startify'.config)
end

return plugin
