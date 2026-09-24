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

## Installation & Deployment
1. Ensure `carton` is in your `/etc/hosts`.
2. Run `make up MODE=carton` to start the ingress router.
3. Run `make up MODE=<mode>` to spin up individual services.
