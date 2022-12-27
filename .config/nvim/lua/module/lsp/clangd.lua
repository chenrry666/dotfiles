local lspconfig = require 'lspconfig'
local M = {}

function M.setup(settings)
  lspconfig.clangd.setup {
    root_dir = lspconfig.util.root_pattern("CMakeLists.txt", ".clangd"),
    cmd = {
      "clangd",
      "--compile-commands-dir=build/",
      "--clang-tidy", -- 开启clang-tidy
      "--all-scopes-completion", -- 全代码库补全
      "--completion-style=detailed", -- 详细补全
      "--header-insertion=iwyu",
      "--header-insertion-decorators",
      "--pch-storage=disk", -- 如果内存够大可以关闭这个选项
      "--log=error",
      "--j=5", -- 后台线程数，可根据机器配置自行调整
      "--background-index"
    },
    capabilities = settings.capabilities,
    on_attach = settings.on_attach,
  }
end

return M
