---
name: add-english-card-to-anki
description: |
    Create sentence-based English→German vocabulary cards in the Anki English
    deck. Supports single cards or batch import.
argument-hint: "[word(s)]"
disable-model-invocation: true
---

# Add English Vocabulary Card(s)

Create one or more sentence-based vocabulary cards in the Anki "English" deck
using the "Einfach (beide Richtungen)" note type.

## Format

Each card uses the sentence format:
```
Vorderseite: word<br><br>Sentence with <b>word</b> in context.
Rückseite:  translation<br><br>Sentence with <b>translation</b> in context.
```

Rules:
- Keep original word/translation as the first line
- Short, natural sentences (≤15 words)
- Target word in `<b>` tags in both languages
- German sentence is a natural translation, not word-for-word

## Workflow

### If no words provided (interactive)

Ask the user for words they want to add. Accept:
- A single word/translation pair: `"copious = umfangreich, reichlich"`
- Multiple pairs separated by newlines or semicolons
- A comma-separated list

### If words are provided

Parse the input. Accept these formats:
```
copious = umfangreich, reichlich
to abate = abnehmen, verringern
perilous = gefährlich
```

Or just English words — in that case, propose German translations.

### For each word/translation pair

1. **Write** a short English sentence using the word naturally. Wrap the target
   word in `<b>` tags.
2. **Write** a natural German translation with the German word in `<b>` tags.
3. **Present** both sentences to the user for approval.

### On approval

Use `mcp__anki__add_note` to add the card:
```json
{
  "deck": "English",
  "model": "Einfach (beide Richtungen)",
  "fields": {
    "Vorderseite": "word<br><br>Sentence with <b>word</b>.",
    "Rückseite": "translation<br><br>Sentence with <b>translation</b>."
  }
}
```

### Batch mode

When adding multiple cards:
- Process them sequentially (show each, get approval, add, next)
- Or: generate all sentences first, present as a table, then batch-add with
  `mcp__anki__add_notes` after approval

Ask the user which mode they prefer if adding more than 3 cards.

## Example

**Input:** `copious = umfangreich, reichlich`

**Proposed:**
> **Vorderseite:** copious<br><br>She took <b>copious</b> notes during the lecture.
> **Rückseite:** umfangreich, reichlich<br><br>Sie machte sich <b>umfangreiche</b> Notizen während der Vorlesung.

**User approves → added.**

## Edge Cases

- **Verbs**: Always include the object pattern in the word line — e.g. `to bring
  up sth.`, `to deplore sth.`, `to ascribe sth. to so.`. This preserves
  grammatical context that single-word translations lose. Match existing deck
  conventions.
- **Phrasal verbs**: Same as verbs — keep the particle and object placeholder
  (`to be apprehensive about sth.`). Inflect naturally in the sentence.
- **Nouns with articles**: German nouns should include the article in the
  translation line if known (`der Sturm`, `die Vorliebe`)
- **Adverbs**: Place the adverb naturally in the sentence; the `<b>` tag goes
  around the adverb itself
- **Words with no obvious sentence**: Ask the user for context or a domain where
  they encountered the word
