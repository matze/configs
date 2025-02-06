-- Completion related plugins.

return {
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = {
        preset = "default",
        ["<C-j>"] = { "accept" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "buffer", "lsp", "path", "snippets", },
      },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
  },
}

