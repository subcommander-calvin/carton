# Calvin's Carton

_An AI assisted agentic second brain_ 

## Components

### The Cartoniuum

[**The Cartoniuum**](resources/registry/0000.md) is the fabrics of the empty space inside Calvin's Carton and the only trace of it's existence is the registry that is to be found as a resource inside the carton. It is mostly a home for [agents](RPG-AGENTS.md)

## The Dual-Instance Architecture

Cartoniuum operates under a strict "infrastructure as code" philosophy, cleanly separating development from production:

- **`~/.carton` (The Carton):** Your local development and testing environment. Accessible locally via `https://carton/`.
- **`~/.station` (The Station):** Your production deployment on the space-local bridge. Accessible locally via `https://station/`.

By unifying the infrastructure behind a Caddy ingress router, the codebase remains identical between environments. The domains `carton` and `station` route traffic dynamically based on the active deployment.

### DNS Resolution
To access the local datacenter, simply map the domains to your local loopback address in your host's `/etc/hosts`:
```
127.0.0.1 carton station
```

## Core Modes (Services)
- **carton**: The ingress router (Caddy) handling TLS and path-based routing.
- **yard**: The Forge (Gitea) hosted at `/repos`.
- **workspace**: The WebDAV file server hosted at `/workspace`.
- **litterbox**: Nanobot GenAI WebUI hosted at `/cat`.
- **rocket**: A rapid-development container.

## Getting Started (First-Time Setup)

The Cartoniuum is built as a self-contained "strange loop" where you build the infrastructure *from within* the infrastructure. 

1. **Clone the Repo:** Fork this repository and clone it to your machine (preferably to `~/.carton`):
   ```bash
   git clone https://github.com/<your-username>/carton.git ~/.carton
   cd ~/.carton
   ```

2. **Bootstrap the Bridge:** Run the bootstrap sequence to automatically stand up the Caddy router, the Gitea Forge, and the Nanobot UI on the `carton-bridge` network.
   ```bash
   make bootstrap
   ```
   *Note: Ensure `carton` and `station` point to `127.0.0.1` in your `/etc/hosts`.*

3. **Spin up your Lifepod:** You do not need to install local development tools. Start the Calvin lifepod:
   ```bash
   make up MODE=lifepod PROFILE=calvin
   ```

4. **Enter the Matrix:** Drop into your lifepod shell:
   ```bash
   docker exec -it calvin bash
   ```
   **Magic Trick:** The `calvin` user inside the container is dynamically created with your host's exact UID and GID! This means you can use VS Code or any editor on your host machine to write code in `~/.carton`, and push to GitHub from *inside* the lifepod, with zero permission conflicts.
