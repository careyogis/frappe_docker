#!/bin/bash
set -e

# Copy this file in your directory and copy the .env file and wellnest-compose.yml to the stack directory
# Define project folder path explicitly
STACK_DIR="/home/azureuser/careyogi-stack"

echo "Note: Ensure that the .env file and wellnest-compose.yml are present in the stack directory: $STACK_DIR"
echo "Also, make sure to set the SITE_NAME and MARIADB_ROOT_PASSWORD in the .env file before running this script."

echo "==== Starting Deployment: $(date) ===="

# Force switch directory using the absolute path
cd "$STACK_DIR"

# Explicitly call the absolute path to docker compose binary
/usr/bin/docker compose pull
/usr/bin/docker compose up -d

echo "Listing newly created containers:"
/usr/bin/docker compose ps

echo "Running Frappe Multi-Tenant Migrations..."
/usr/bin/docker compose exec -T backend bench --site careyogis.local migrate

echo "==== Deployment Completed Successfully ===="
