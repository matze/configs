---
name: slop-score
description: >-
  Rate prose, code or comments against the unslop language rules and report the
  violations. Reports findings, never rewrites.
argument-hint: "[file or text]"
disable-model-invocation: true
---

# Slop rating

Read `../unslop/general.md` and `../unslop/code.md` relative to this file. Every
finding cites one rule from one of them by ID.

## Scope

Skip a section when the input holds no instance of its subject. Style applies to
prose. Naming, Declaration comments and Body comments apply to code.

A commit message gets STY. A Rust diff gets all four.

## Findings

Report a violation only where you can quote the span it applies to. A rule that
yields no span yields no finding.

Write nothing about a section that produced no findings.

Open the report with the score line, then this legend:

```text
🔍 red `-` is what is there now, ✏️ green `+` is the suggestion, and `[-…-]` /
`{+…+}` mark the words that change.
```

One block per violation, in file order, so the reader walks the file top to
bottom:

````text
`<file>:<line>:<col>` `<ID>` <why those words break the rule>
```diff
- <the text as it stands, changed words wrapped in [-…-]>
+ <the suggestion, changed words wrapped in {+…+}>
```
````

`<col>` is the 1-based character column where the span starts. Pasted text
replaces file and line with a paragraph number, `¶<n>:<col>`.

A deletion drops the `+` line. A violation that recurs identically gets one
block, with the other locations listed in the reason line.

For example:

````text
`README.md:8:1` `STY-03` reversed pseudo-cleft fronting `It is`
```diff
- [-It is the cache that is-] slow.
+ {+The cache is+} slow.
```
````

Never edit the input. The `+` line is a suggestion, and the reader decides.

### Word diff

Pass the two versions of one span to this script and paste what it prints:

```sh
python3 - "$OLD" "$NEW" <<'PY'
import difflib, re, sys

words = lambda text: re.findall(r"\S+\s*", text)
old, new = words(sys.argv[1]), words(sys.argv[2])
minus = plus = ""

for tag, i1, i2, j1, j2 in difflib.SequenceMatcher(None, old, new).get_opcodes():
    cut, add = "".join(old[i1:i2]), "".join(new[j1:j2])

    if tag == "equal":
        minus += cut
        plus += add
        continue

    minus += f"[-{cut.rstrip()}-]{cut[len(cut.rstrip()):]}" if cut else ""
    plus += f"{{+{add.rstrip()}+}}{add[len(add.rstrip()):]}" if add else ""

print("- " + minus.rstrip())

if new:
    print("+ " + plus.rstrip())
PY
```

It aligns on whitespace-delimited words, so a punctuation-only edit lands on the
neighbouring word. Move the markers by hand when they cover more words than
changed.

## Score

Count words and density in one invocation, with the violations you found:

```sh
LC_ALL=C awk -v violations=9 '{ words += NF } END {
  printf "%d words, %.1f per 100\n", words, violations * 100 / words
}' FILE
```

Pipe the text on stdin when the input is not a file.

One line above the legend carries all three numbers:

```text
**`<file>`** <count> violations, <d> per 100 words, **<fail|pass>**
```

A violated prohibition (`Never`, `No`, `Do not`) fails the text. Everything else
passes.
