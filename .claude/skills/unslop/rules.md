# Language rules

Numbers are append-only. A deleted rule retires its number.

## Style

- STY-01 Write direct Subject-Verb-Object sentences.
- STY-02 Keep an adverb next to its verb. Shorten the object when it pushes the
  adverb to the end.
- STY-03 Never use cleft constructions, especially It-cleft,
  Wh-cleft/Pseudo-cleft and their reversed forms.
- STY-04 Every pro-form resolves to a noun in the same sentence or an earlier
  one.
- STY-05 Keep sentences and paragraphs short.
- STY-06 No performative honesty: no "honestly", no confessions, no apologies.

## General

- GEN-01 One fact, one sentence. No em dash, no semicolon.
- GEN-02 One fact, one place.
- GEN-03 Cut until cutting would change the semantics of a sentence or
  paragraph.
- GEN-04 Never justify unless the reader asks.
- GEN-05 Conclusion first, evidence after.
- GEN-06 Make the actor the subject and give it a real verb. No metaphors.
- GEN-07 Do not describe alternatives you rejected. No "X, not Y".
- GEN-08 Drop the consequence clause when the first clause implies it.
- GEN-09 Adverbs to avoid: honestly, genuinely, load-bearing
- GEN-10 Nouns to avoid: seam, blast radius
- GEN-11 Verbs to avoid: carry, travel, live, earn, be for
- GEN-12 The words in GEN-09 to GEN-11 name constructions. Replacing one with a
  synonym in the same sentence frame is not a fix.

## Cutting

- CUT-01 Rewriting means deleting. Swapping words is not a cut.
- CUT-02 Never cut a sentence down to a verbless fragment.
- CUT-03 Every sentence answers "what does the reader do differently after
  reading this?". Cut the ones with no answer.
- CUT-04 List the facts a comment carries before rewriting it. Keep every fact
  the reader cannot derive from the code. Drop the sentences that carry none.
- CUT-05 Never touch data while editing prose. Verify the parsed structure is
  unchanged.

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
