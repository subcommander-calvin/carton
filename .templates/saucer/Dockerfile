FROM debian:bookworm-slim

ARG HOST_UID
ARG HOST_USER

RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv curl wget git make sudo jq openssh-client \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -u ${HOST_UID} -m -s /bin/bash ${HOST_USER} \
    && echo "${HOST_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN mkdir -p /workspace && chown ${HOST_UID}:${HOST_UID} /workspace
WORKDIR /workspace

ENV HOST_USER=${HOST_USER}

RUN echo "echo '🛸 WELCOME TO THE SAUCER 🛸\nWorkspace active. Mount point: /workspace (Mapped to Saucer SSD)'" >> /home/${HOST_USER}/.bashrc

CMD ["tail", "-f", "/dev/null"]
