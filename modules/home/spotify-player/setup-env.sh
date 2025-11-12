#!/usr/bin/env bash

# Setup script for spotify-player environment variables
# This reads your secrets and exports them as environment variables

SECRETS_FILE="$(dirname "$0")/secrets.nix.example"

if [ -f "$SECRETS_FILE" ]; then
    # Extract client_id from the nix file
    CLIENT_ID=$(grep -o 'client_id = "[^"]*"' "$SECRETS_FILE" | cut -d'"' -f2)
    
    if [ -n "$CLIENT_ID" ]; then
        export SPOTIFY_CLIENT_ID="$CLIENT_ID"
        echo "✓ SPOTIFY_CLIENT_ID exported"
        echo "Now run your build command (e.g., 'fr')"
    else
        echo "❌ Could not find client_id in $SECRETS_FILE"
        echo "Please check the format of your secrets file"
    fi
else
    echo "❌ $SECRETS_FILE not found"
    echo "1. Copy secrets.nix.example to create your own:"
    echo "   cp secrets.nix.example secrets.nix"
    echo "2. Edit secrets.nix with your actual Spotify client ID"
    echo "3. Run this script again: source setup-env.sh"
fi