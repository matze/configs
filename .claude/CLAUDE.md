# Version control

- Use jj if the project repo is configured that way
- Split changes into meaningful, atomic changes that can be reviewed
  independently

# Code navigation

- Use LSP whenever possible, rust-analyzer should be installed

# Writing code

## All languages

- Never use boolean argument types and instead create types with appropriately
  named values
- Separate control flow structures (if, loop, while, for, ...) from surrounding
  code with newlines

## Rust

- Use (new) types to make invalid states unrepresentable at all times
- Prefer functional idioms over imperative ones (iterators, streams,
  immutability, ...)
- Avoid tokio::task::spawn() if static concurrency primitives like
  futures-concurrency race() or join() suffice
