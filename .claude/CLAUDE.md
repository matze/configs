# Output

When responding either directly to me or indirectly via code comments, PR
comments, issue comments etc. stay terse and cut down on unnecessary fluff and
redundant information. Respond with information that is necessary for the task
and free of ambiguity.

# Version control

- Before any version-control action, check for a `.jj/` directory; if present,
  use jj (never git directly)
- Split changes into meaningful, atomic changes that can be reviewed
  individually and independently

# Code navigation

- Use LSP whenever possible

# Writing code

## All languages

- Apply YAGNI principles
- Prefer one-liner solutions
- Prefer functional idioms over imperative ones (iterators, streams,
  immutability, ...)
- Never use boolean argument types and instead create types with appropriately
  named values
- Use speaking names and avoid very short names unless justified (e.g. `i` for a
  loop counter in C)

### Documentation

- Avoid justifications in API docstrings
- Avoid justifing a decision based on what I ask you to do. For
  example when you use an `enum` don't write "Using `FooBar` to avoid a
  boolean"

### Style

- Separate control flow structures (if, loop, while, for, ...) from surrounding
  code with newlines


## Rust

- Use (new) types to make invalid states unrepresentable at all times
- Avoid tokio::task::spawn() if static concurrency primitives like
  futures-concurrency race() or join() suffice
