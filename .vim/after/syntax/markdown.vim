syntax region wikiLink matchgroup=wikiLinkTarget start="\[\[" end="\.md\]\]" concealends

syntax match mkdRefLink /\[.*\]\[\]/
syntax match mkdRefLinkStart /\[/ conceal contained containedin=mkdRefLink
syntax match mkdRefLinkEnd /]\[\]/ conceal contained containedin=mkdRefLink

syntax match mkdInlineLink /\[\_[^\]]\+]([^)]\+)/
syntax match mkdInlineLinkTarget /\[.*\]/ conceal contained containedin=mkdInlineLink
syntax match mkdInlineLinkLabelStart /(/ conceal contained containedin=mkdInlineLink
syntax match mkdInlineLinkLabelEnd /)/ conceal contained containedin=mkdInlineLink
"
highlight       wikiLink        ctermfg=Magenta
highlight link  mkdInlineLink   Underlined
highlight link  mkdRefLink      Underlined
