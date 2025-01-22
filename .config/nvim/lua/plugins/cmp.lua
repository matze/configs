-- Completion related plugins.

return {
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "moyiz/blink-emoji.nvim",
      "giuxtaposition/blink-cmp-copilot",
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
        default = { "buffer", "lsp", "path", "snippets", "copilot", },
        providers = {
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 15, -- the higher the number, the higher the priority
            opts = { insert = true }, -- Insert emoji (default) or complete its name
          },
          copilot = {
            module = "blink-cmp-copilot",
            name = "copilot",
            score_offset = 100,
            async = true,
            transform_items = function(_, items)
              local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = "Copilot"
              for _, item in ipairs(items) do
                item.kind = kind_idx
              end
              return items
            end,
          },
        }
      },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
  },
}

