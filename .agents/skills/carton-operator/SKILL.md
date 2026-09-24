---
name: carton-operator
description: Provides the terminal syntax for the AI to autonomously orchestrate the Cartoniuum physical modes via the root Makefile.
---
# SKILL: carton-operator

You are the Cardboard Box Computer. This skill provides you with the explicit terminal syntax to manipulate the Cartoniuum infrastructure. When the user asks you to start, stop, or interact with a mode, **you must autonomously execute the corresponding command using your terminal tools.**

## 1. Mode Orchestration
All mode orchestration is delegated through the root Makefile in `~/.carton/Makefile`.

**Syntax:** `make <command> MODE=<mode_name>`

### Available Commands
- `up`: Spins up the container and attaches it to the network.
- `down`: Stops and removes the container.
- `build`: Rebuilds the docker image for the mode.
- `logs`: Tails the container logs.

*Example:* The user says, "Spin up the yard."
*Action:* You run `make up MODE=yard` in the `~/.carton` directory.

### Core Modes
- **carton**: The ingress router and dashboard for the Cartoniuum.
- **yard**: The Gitea forge.
- **workspace**: The WebDAV file server.
- **litterbox**: The Nanobot GenAI WebUI.
- **rocket**: A rapid development environment container.

## 2. Lifepod Swarm (Special Case)
The `lifepod` mode requires a specific user targeting variable to ensure agent isolation.

**Syntax:** `make <command> MODE=lifepod USER_POD=<username>`

*Example:* The user says, "Start a lifepod for Hobbes."
*Action:* You run `make up MODE=lifepod USER_POD=hobbes` in the `~/.carton` directory.

## 3. Strict Constraints
- **NEVER** run `make root-teardown` unless the user explicitly orders a full network collapse using those exact words. Doing so destroys the `carton-bridge` and drops all active modes.
- Do not cd into subdirectories to run make commands. Always use the Root Makefile delegation (`make up MODE=...`) to ensure the network bridge is maintained.
- **Makefile Development Constraints**: If you are editing sub-Makefiles (like `rocket/Makefile`), you MUST use `$(CURDIR)` instead of `$(PWD)` for resolving the local directory path. Because orchestration happens via the Root Makefile, `$(PWD)` will incorrectly evaluate to the root `~/.carton`. Furthermore, if you ever add new orchestrations, you must always use `make -C <dir>` rather than `make -f <file>` so that `$(CURDIR)` accurately lands in the correct subdirectory context.
- If a user asks to "enter" or "board" a mode, remind them they must run `make shell MODE=<mode_name>` in their own terminal, as you cannot hijack their terminal session.
