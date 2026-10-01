---
name: unslop
description: >-
  Use always. Also use when asked to unslop LLM output.
---

# Language rules

`general.md` next to this file contains writing rules to be applied to every
output that a human reader may see. `code.md` next to this file is only loaded
when writing prose in code, e.g. comments, docstrings etc.

Rule numbers are append-only. A deleted rule blocks its number.

Every rule opens with an imperative verb. A rule that forbids opens with Never,
Do not, or No. A word list in a rule names examples, not a closed set.

## Removing slop

Rewriting means deleting. Swapping words is not a cut.

Every sentence answers "what does the reader do differently after reading
this?". Cut the ones with no answer, and cut until cutting would change the
semantics of a sentence or paragraph.

Never touch data while editing prose. Verify the parsed structure is unchanged.

Re-read the finished text against every rule. Any new sentence is subject to
them as well.
