#!/bin/bash

# Ensure jq is installed
if ! command -v jq &> /dev/null; then
    echo "jq could not be found. Skipping user initialization."
    exit 0
fi

USERS_FILE="../users.json"
if [ ! -f "$USERS_FILE" ]; then
    echo "users.json not found. Skipping."
    exit 0
fi

echo "Waiting for Gitea to initialize (this takes a few seconds on first boot)..."
# We wait until the gitea admin CLI is responsive
until docker exec -u git yard gitea admin user list &> /dev/null; do
    sleep 2
done

echo "Gitea is ready. Provisioning crew members..."

for profile in $(jq -r '.crew | keys[]' "$USERS_FILE"); do
    email=$(jq -r ".crew[\"$profile\"].email" "$USERS_FILE")
    admin=$(jq -r ".crew[\"$profile\"].gitea_admin" "$USERS_FILE")
    
    # Check if user already exists
    if docker exec -u git yard gitea admin user list | grep -q "$profile"; then
        echo "User $profile already exists."
        continue
    fi

    echo "Creating Gitea user: $profile..."
    admin_flag=""
    if [ "$admin" = "true" ]; then
        admin_flag="--admin"
    fi

    docker exec -u git yard gitea admin user create --username "$profile" --password "$profile" --email "$email" $admin_flag --must-change-password=false
done

echo "Gitea user provisioning complete."
