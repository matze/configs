require("config.options")
require("config.mappings")
require("config.autocmds")
require("config.filetypes")
require("config.lazy")

vim.lsp.enable({"clangd", "gopls", "ruff", "rust-analyzer", "tinymist", "ty"})

local function sync_colorscheme()
  local result = vim.fn.system("gsettings get org.gnome.desktop.interface color-scheme")
  if result:find("prefer%-light") or result:find("default") then
    -- set background directly so lualine is synced as well
    vim.o.background = "light"
    vim.cmd([[colorscheme jellybeans-muted-light]])
  else
    vim.o.background = "dark"
    vim.cmd([[colorscheme jellybeans]])
  end
end

sync_colorscheme()

-- Watch for GNOME theme changes
local handle = vim.uv.new_pipe()
local pid = vim.uv.spawn("gsettings", {
  args = { "monitor", "org.gnome.desktop.interface", "color-scheme" },
  stdio = { nil, handle, nil },
}, function() end)

if handle then
  handle:read_start(function(err, data)
    if data then
      vim.schedule(sync_colorscheme)
    end
  end)
end
