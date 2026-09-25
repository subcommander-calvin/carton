FROM debian:bookworm-backports

# Install tools for development and git operations
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    git \
    vim \
    jq \
    htop \
    wget \
    net-tools \
    iputils-ping \
    openssh-client \
    gh \
    && rm -rf /var/lib/apt/lists/* || true

# Add GitHub CLI repository (gh might not be in default bookworm repos)
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install gh -y \
    && rm -rf /var/lib/apt/lists/*

# Add a non-root user matching the profile and host UID/GID
ARG USER_UID=1000
ARG USER_GID=1000

RUN if ! getent group ${USER_GID} > /dev/null; then groupadd -g ${USER_GID} calvin; fi && \
    useradd -m -u ${USER_UID} -g ${USER_GID} -s /bin/bash calvin
USER calvin

WORKDIR /workspace

# Keep the lifepod alive indefinitely
CMD ["tail", "-f", "/dev/null"]
