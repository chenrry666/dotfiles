local plugin = {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
}

function plugin.config()
  require 'nvim-autopairs'.setup {
    enable_check_bracket_line = false,
    check_ts = true,
    ts_config = { java = false },
  }

  local cmp_status_ok, cmp = pcall(require, 'cmp')
  if cmp_status_ok then
    cmp.event:on('confirm_done', require 'nvim-autopairs.completion.cmp'.on_confirm_done { tex = false })
  end
end

return plugin
