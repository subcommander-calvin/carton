FROM python:3.11-slim

# Install nanobot-ai
RUN pip install --no-cache-dir nanobot-ai

WORKDIR /srv/litterbox

# The default Nanobot WebUI port we will configure
EXPOSE 8080

# Run the WebUI in non-interactive mode
CMD ["nanobot", "webui", "--port", "8080", "--workspace", "/srv/litterbox/workspace", "--no-open", "--yes"]
