---
name: unslop
description: >-
  Use always. Or when triggered explicitly to unslop LLM output.
---

# Language rules

Rules applying to textual output: prose and code alike.

## General

- One fact, one sentence, each sentence separated by a period (no em dash, no
  semicolon). Keep it short enough to read in one pass. A wall of text is a
  defect.
- One fact, one place. Never state it in two files, or in both a comment and the
  message the code prints.
- Cut until cutting would change the meaning of a sentence or paragraph.
- Do not rationalize and justify unless asked for.
- Conclusion first, evidence after. Never orbit a point and land on it as a
  revealed insight.
- Use concrete subjects instead of inanimate abstractions and metaphors.
- Take instructions literally. Do not overrule the ask toward its "spirit".
- Do not describe alternatives that were considered and not taken.
- Drop the consequence clause when the first clause implies it.
- An incident earns one sentence: what broke, and the mechanism. No dates, no
  duration, no "not by choice".

## Rewriting

- Rewriting means deleting. Swapping words is not a cut.
- Every sentence answers "what does the reader do differently for having read
  this?". Cut the ones with no answer.
- List the facts a comment carries before rewriting it. Keep every fact the
  reader cannot derive from the code. Drop the sentences that carry none.
- Editing prose must not touch data. Verify the parsed structure is unchanged.

## Style

- Avoid cleft sentence constructions, especially It-cleft,
  Wh-cleft/Pseudo-cleft and their reversed forms.
- No performative honesty: no "honestly", no confessions, no apologies.
- Never explain a choice as "X, not Y" or "X rather than Y". State what is done.

## Naming

- One name per concept. Before naming anything, look for existing names for a
  concept across modules and languages. Never coin a quasi-synonym for a name
  that exists.
- Function names say exactly what the function does and to what, never a vague verb.
- Constant names describe what the value is, never where it is used.
- No past participles and no passive names, a function is a verb phrase, a type
  a noun.
- Name a type for the value it holds, not its role in a flow.
- A name says what the thing does, never what it does instead.

## Doc comments

- First line: what it is, or an imperative verb plus object. One terse noun or
  verb phrase. State the category or type immediately.
- Keep the mechanism, drop the narrative. No world-building.
- Cut the trailing "which is what…" / "so that…" chain. Two or three sentences
  collapse to one or two that state the reason directly.
- One line for anything whose contract fits one. A second paragraph has to convey
  a fact, if the signature does not.

## Inline comments

- Only the why, never the what. Delete comments that restate the code or
  duplicate a doc comment. Add a reason only when it is non-obvious and the
  reader would otherwise change the code wrongly.
- Tighten to the direct reason, drop the justification spiral.
- Keep the non-obvious invariant verbatim. A reason the code cannot be read off
  the line stays, in full.
- A comment on a match arm goes inside the arm's block, never between the
  pattern and its body.
- Never restate the guard. "Guarded on X being absent" is the code. The comment
  carries only why the guard exists.
- Delete sentences explaining a check that is not there. "There is no
  assertion here that…" is not a reason.
- Put the reason on the line it constrains. A reason living in a file header
  belongs on the task, field or condition it governs.
