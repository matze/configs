# Code style language rules

## Naming

- NAM-01 One name per concept. Before naming anything, look for existing names
  across modules and languages.
- NAM-02 Function names say exactly what the function does and to what, never a
  vague verb.
- NAM-03 Constant names describe what the value is, never where it is used.
- NAM-04 No past participles and no passive names. A function is a verb phrase,
  a type a noun.
- NAM-05 Name a type for the value it holds, not its role in a flow.

## Declaration comments

- DCL-01 First line: a terse noun phrase naming the category or type, or an
  imperative verb plus object.
- DCL-02 Keep the mechanism, drop the narrative.
- DCL-03 Cut the trailing "which is what…" / "so that…" chain. State the reason
  directly.
- DCL-04 One line for anything whose contract fits one. A second paragraph
  must carry a fact the signature does not.
- DCL-05 Never restate the declaration. The type name, the cardinality and the
  optionality are already in the signature.
- DCL-06 Document a type by what it is. The field that carries it documents what
  a recipient does with it.

## Body comments

- BDY-01 Only the why. Delete comments that repeat the code or duplicate a
  declaration comment. Add a reason only when the reader would otherwise wrongly
  change the code.
- BDY-02 Keep the reason verbatim when the reader cannot read it off the code.
- BDY-03 A comment on a match arm goes inside the arm's block, never between the
  pattern and its body.
- BDY-04 Never restate the guard. "Guarded on X being absent" is the code.
- BDY-05 Delete sentences explaining a check that is not there. "There is no
  assertion here that…" is not a reason.
- BDY-06 Put the reason on the line it constrains, never in a file header.

## Comment edits

List the facts a comment carries before rewriting it. Keep every fact the reader
cannot derive from the code. Drop the sentences that carry none.
