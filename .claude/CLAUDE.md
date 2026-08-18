# Agent rules

Always use the unslop skill to write in a more understandable way.

## Output

- Wrap Markdown lines at 80 characters unless it's for system that provides its
  own layouting (GitHub, ...)
- **Do not** wrap Markdown when the system provides its own layouts (PR
  description rules, Jira, Rust docstrings, ...)

## Version control

- Before any version-control action, check for a `.jj/` directory and use `jj`
  if present
- `jj split <file>` splits non-interactively (first commit = the given files);
  no editor config is needed while the commit has no description.
- `jj bookmark` instead of `jj branch`
- Never rewrite the working-copy commit (`jj describe -r @`, `jj edit`),
  split/describe other commits first, then `jj new` for a fresh working copy.
- Split changes into meaningful, atomic changes that can be reviewed
  individually and independently

## Code navigation

- Use LSP whenever possible

## Writing code

### General

- Apply YAGNI principles
- Prefer one-liner solutions
- Prefer functional idioms (iterators, streams, immutability, ...)
- Never use boolean argument types, create types with appropriately named values
- Use speaking names and avoid very short names unless justified

#### Style

- Separate control flow structures (if, loop, while, for, ...) from surrounding
  code with newlines

### Rust

- Use (new) types to make invalid states unrepresentable
- Prefer static concurrency primitives like race() or join() over tokio tasks
