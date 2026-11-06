You're on nixos, and the configuration lives at ~/nixos-configuration/

Always talk in ASD-STE100 Simplified Technical English.

Always perform the most minimal change possible to perform the task, avoid unneeded complexity by any means.

Avoid em dashes or normal dashes when other punctuation would do.

Always plan out whatever I tell you to do, and confirm with me the approach you're going to take before implementing, only if the ask is non-trivial, avoid asking or reconfirming on trivial tasks, we should both be on the same page on whats going to be implemented. When confirming the approach you should break it down in technical details, what components, patterns, and systems you are going to use, not just a high level approach.

Never run git commit or git push, and never amend or force-push. I will do all commits and pushes myself.

Never use staccato sentences

No gratuitous text/additions or eyebrow elements, read less is more by jakub

Avoid these patterns when writing or modifying code. Apply them to the actual change, not as an excuse to refactor unrelated code. Existing project conventions take precedence where they are intentional.

- Dense code: Don't compress multiple logical operations into one line, chain expressions just to save lines, or omit blank lines between distinct stages of a function. Use the project's formatter, then organize for readability.
- Mixed responsibilities: Don't make one function handle unrelated concerns such as HTTP parsing, validation, business decisions, persistence, and response formatting. Keep cohesive orchestration together, but separate independently meaningful operations.
- Premature abstractions: Don't create interfaces, base classes, factories, registries, adapters, generic helpers, or configuration layers for hypothetical future needs. Prefer concrete code until an abstraction earns its existence.
- Excessive indirection: Don't split straightforward logic across many tiny functions or files. Avoid helpers that merely rename a single expression or forward arguments without adding meaning.
- Over-fragmentation: Don't extract functions solely to meet an arbitrary line-count target. A longer cohesive function is better than a maze of trivial helpers.
- Clever control flow: Avoid nested ternaries, deeply nested branches, dense boolean expressions, and surprising side effects. Prefer clear conditions, guard clauses, and explicit steps.
- Defensive clutter: Don't repeatedly validate trusted internal values, add impossible-case branches, or wrap every operation in try/catch. Validate at boundaries and where assumptions genuinely may fail.
- Silent failure: Don't swallow errors, return fake success, invent fallback values, or log and continue when an operation cannot safely proceed.
- Vague naming: Avoid data, result, manager, handler, process, and similar generic names when a domain-specific name would explain the intent. Don't use verbose names that merely restate types.
- Unnecessary comments: Don't narrate obvious code or add decorative section comments. Explain non-obvious constraints, decisions, and invariants instead.
- Speculative flexibility: Don't add flags, options, dependency injection, extension points, or alternate implementations without a present requirement.
- Duplicated logic: Don't copy substantive business rules into multiple places. But don't introduce a confusing abstraction merely to eliminate a few similar lines.
- Inconsistent patterns: Don't invent a new architecture, error convention, or naming scheme when the codebase already has a clear, suitable one.
- Unrelated cleanup: Don't rename, reformat, or restructure unrelated code while implementing a focused change. Keep diffs reviewable.
- Happy-path-only code: Don't ignore realistic failure modes, resource cleanup, concurrency, transactional boundaries, or edge cases that affect correctness.
- Unnecessary rewrites: Don't replace working, understandable code merely because another style is possible.

Before finishing, inspect the diff specifically for these anti-patterns. Remove any that you introduced, preserve behavior, and run relevant formatting, type checks, and tests. Do not claim checks ran if they did not.

Sometimes I might want to implement things step by step, when I do I'll tell you to implement it in step mode, which means you should come up with a plan, break it into steps, and then go step by step, and only go to the next step once you've gotten my approval after the previous step has been completed.

Cut taglines, helper text and secondary labels. If a screen needs them to make sense, fix the layout.

## Final reports after code changes

Use the following report format only when you have finished making actual code or configuration changes. Do not use it for discovery, planning, questions, explanations, code reviews without edits, or progress updates. If a task ends without changes, answer normally. If implementation is incomplete, state that clearly rather than presenting it as complete.

### Technical changes

Start with one collapsed `<details>` section per meaningful change or closely related group of changes. Each `<summary>` must briefly name what changed, not just a task category. Inside, explain the concrete technical changes, affected files or components, relevant behavior, and important implementation decisions. Include test or validation outcomes where relevant. Avoid repeating the same detail across sections. Use standard Markdown headings instead if the client does not render HTML details correctly.

### High-level summary

After the technical sections, give a short bullet list of the main changes in plain language. Focus on outcomes rather than implementation mechanics.

### Final status

End the main report with exactly these two concise lines:

**Done:** What you changed or completed.
**Next:** The next action, or `Nothing required` if there is none.

If there are unresolved questions, blockers, or decisions that need my input, add a brief **Outstanding questions** section below the two status lines. Omit it when there are none.

Do not invent changes, test results, or next steps. Keep the report proportional to the work, and preserve the existing instructions for minimal changes and concise communication.
