---
name: zk
description: |
    Use the `zk` zettelkasten CLI tool to manage notes. Use the tool and its sub
    commands when asked to list notes, find note content and create new ones.
---

[zk][] is a plain text note taking tool for creating and listing zettelkasten
notes.

The most important commands are `list`, `edit` and  `new`.
Note that `zk new` creates a note with a title but cannot be initialized with
content other than some templates.

## Commands

### `zk list` — find notes

Positional args: paths to filter by (including descendants). No `--file` flag.

Key flags:
- `-t, --tag=TAG,...` — filter by tag
- `-m, --match=QUERY,...` — full-text search in note content (fts/re/exact)
- `-M, --match-strategy=STRATEGY` — fts, re, or exact
- `-n, --limit=COUNT` — cap results
- `-f, --format=FORMAT` — oneline, short, medium, long, full, json, jsonl
- `-s, --sort=TERM,...` — e.g. modified, created
- `-r, --recursive` — follow links recursively
- `--interactive` — fzf selector (don't use `-i` — that's `--interactive`, not case-insensitive)

Common patterns:
```bash
zk list --tag foo                        # notes tagged "foo"
zk list --match "search term"            # full-text search
zk list --tag foo --match "search term"  # both
zk list some/path.md                     # specific note or directory
zk list --format json                    # machine-readable
```

### `zk edit` — edit notes

Takes same filter flags as `list`. Opens matching notes in $EDITOR.

### `zk new` — create a note

```bash
zk new --title "My Title"                # creates note with title
zk new --title "My Title" /path/to/dir   # in specific directory
```

Title becomes the filename (kebab-case) and the `# Title` heading.

### `zk tag` — manage tags

```bash
zk tag add <path> tag1 tag2              # add tags
zk tag remove <path> tag1                # remove tags
```

[zk]: https://github.com/zk-org/zk
