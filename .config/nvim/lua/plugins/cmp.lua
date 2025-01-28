-- Completion related plugins.

return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "moyiz/blink-emoji.nvim",
    },
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
        providers = {
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15, -- the higher the number, the higher the priority
            opts = { insert = true }, -- Insert emoji (default) or complete its name
          },
        }
      },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
  },
}

