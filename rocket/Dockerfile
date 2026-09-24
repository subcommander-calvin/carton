FROM debian:bookworm-slim

ARG HOST_UID
ARG HOST_USER

RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv curl wget git make sudo jq openssh-server \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/sshd

RUN useradd -u ${HOST_UID} -m -s /bin/bash ${HOST_USER} \
    && echo "${HOST_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN mkdir -p /workspace && chown ${HOST_UID}:${HOST_UID} /workspace
WORKDIR /workspace

ENV HOST_USER=${HOST_USER}

RUN echo "echo '🚀 WELCOME ABOARD THE ROCKET 🚀\nInfrastructure layer secure. Mount point: /workspace (Mapped to Stardrive)'" >> /home/${HOST_USER}/.bashrc

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
