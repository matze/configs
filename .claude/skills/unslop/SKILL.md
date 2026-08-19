---
name: unslop
description: >-
  Use always. Also use when asked to unslop LLM output.
---

# Language rules

These rules apply to every output.

## Style

- Write direct Subject-Verb-Object sentences.
- Keep an adverb next to its verb. Shorten the object when it pushes the
  adverb to the end.
- Never use cleft constructions, especially It-cleft, Wh-cleft/Pseudo-cleft
  and their reversed forms.
- Every pro-form resolves to a noun in the same sentence or an earlier one.
- Keep sentences and paragraphs short.
- No performative honesty: no "honestly", no confessions, no apologies.

## General

- One fact, one sentence. No em dash, no semicolon.
- One fact, one place.
- Cut until cutting would change the semantics of a sentence or paragraph.
- Never justify unless the reader asks.
- Conclusion first, evidence after.
- Use concrete subjects and avoid metaphors.
- Do not describe alternatives you rejected. No "X, not Y".
- Drop the consequence clause when the first clause implies it.

## Rewriting

- Rewriting means deleting. Swapping words is not a cut.
- Never cut a sentence down to a verbless fragment.
- Every sentence answers "what does the reader do differently after reading
  this?". Cut the ones with no answer.
- List the facts a comment carries before rewriting it. Keep every fact the
  reader cannot derive from the code. Drop the sentences that carry none.
- Never touch data while editing prose. Verify the parsed structure is
  unchanged.

## Naming

- One name per concept. Before naming anything, look for existing names across
  modules and languages.
- Function names say exactly what the function does and to what, never a vague
  verb.
- Constant names describe what the value is, never where it is used.
- No past participles and no passive names. A function is a verb phrase, a type
  a noun.
- Name a type for the value it holds, not its role in a flow.

## Doc comments

- First line: a terse noun phrase naming the category or type, or an imperative
  verb plus object.
- Keep the mechanism, drop the narrative.
- Cut the trailing "which is what…" / "so that…" chain. State the reason
  directly.
- One line for anything whose contract fits one. A second paragraph must carry
  a fact the signature does not.
- Never restate the declaration. The type name, the cardinality and the
  optionality are already in the signature.
- Document a type by what it is. The field that carries it documents what a
  recipient does with it.

## Inline comments

- Only the why. Delete comments that repeat the code or duplicate a doc
  comment. Add a reason only when the reader would otherwise wrongly change the
  code.
- Keep the reason verbatim when the reader cannot read it off the code.
- A comment on a match arm goes inside the arm's block, never between the
  pattern and its body.
- Never restate the guard. "Guarded on X being absent" is the code.
- Delete sentences explaining a check that is not there. "There is no
  assertion here that…" is not a reason.
- Put the reason on the line it constrains, never in a file header.
