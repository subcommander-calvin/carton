# opencode-delegate

- **Description**: Use this skill to delegate complex coding, refactoring, project scaffolding, testing, and build tasks to OpenCode. OpenCode runs on the OpenCode Go subscription with access to multiple coding-optimized models.
- **Triggers**: "delegate to opencode", "run opencode task", "ask opencode to", "opencode this", "send to engine"
- **Execution Mode**: Sub-agent isolation — OpenCode runs as an independent process with its own session, tools, and filesystem access. Results return via files written to the vault.

## Available Models (OpenCode Go)
| Model | Best For |
|-------|----------|
| `kimi-k2.7-code` | Large-scale refactoring, architecture, complex logic |
| `qwen3.7-max` | General coding, script writing, API work |
| `glm-5.2` | Full-stack web, UI components, design systems |
| `deepseek-v4-pro` | Deep reasoning, debugging, algorithm design |
| `deepseek-v4-flash` | Fast prototyping, simple scripts, quick fixes |
| `minimax-m3` | Creative coding, experiments, exploration |

Default model is whatever OpenCode is configured to use. Override with `--model` flag when a specific model is needed for the task.

## Steps

1. **Gather context.** Collect all relevant file paths, error messages, requirements, and constraints. OpenCode runs in an isolated session — it knows nothing about your current conversation. Be explicit.

2. **Format the task.** Write a clear, self-contained instruction:
   ```
   opencode "Task: [specific instruction with context]

   Files: /path/to/file1, /path/to/file2
   Constraints: [any limits or requirements]
   Expected output: [what should be produced or changed]"
   ```

3. **Choose a model (optional).** If the task needs a specific model:
   ```
   opencode "Task: ..." --model deepseek-v4-pro
   ```

4. **Execute.** Run the command. OpenCode spawns, works independently, and writes results back to the vault.

5. **Verify.** After OpenCode completes, read the changed files to confirm the work matches the request.

## Context Hand-off Template

When delegating, always include:
- **What** — the specific task or change
- **Where** — exact file paths
- **Why** — the purpose or user story behind it
- **Constraints** — limits, style guides, conventions to follow
- **Expected output** — what "done" looks like

## Timeouts

Long-running OpenCode tasks (multi-step plans, large codebases) may take several minutes. Set a generous timeout:
```bash
export AGY_TIMEOUT_DELEGATE=600
```

## Pitfalls

- **OpenCode is stateless.** Don't assume it remembers anything from your session. Include all context in the command.
- **Vault paths must be absolute.** OpenCode's working directory may differ from yours. Use full paths like `/mnt/dock/vaults/...` or `~/Documents/The-Keep/...`.
- **OpenCode writes files, not stdout.** Don't expect a text response — check the vault for changed files.
- **Model selection is advisory.** OpenCode may use its default model if the specified one is unavailable. Check the result, not the model name.
- **Not for conversation.** This is a fire-and-forget coding tool. For collaborative discussion, use agy subagents. For memory/archival work, use @corvus (Hermes).
