#!/bin/bash

# Apply VS Code settings for DevOps/SRE/Platform Engineers

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Get VS Code settings directory
get_vscode_settings_dir() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "$HOME/Library/Application Support/Code/User"
    else
        echo "$HOME/.config/Code/User"
    fi
}

# Apply VS Code settings
apply_vscode_settings() {
    local settings_dir=$(get_vscode_settings_dir)
    
    print_status "Applying VS Code settings..."
    
    # Create settings directory if it doesn't exist
    mkdir -p "$settings_dir"
    
    # Copy settings file
    cp "$(dirname "$0")/vscode-settings.json" "$settings_dir/settings.json"
    
    print_success "VS Code settings applied successfully"
    print_status "Settings location: $settings_dir/settings.json"
}

# Main function
main() {
    echo "=============================================="
    echo "VS Code Settings Setup for DevOps/SRE/Platform Engineers"
    echo "=============================================="
    echo
    
    apply_vscode_settings
    
    echo
    print_success "VS Code settings setup completed!"
    echo "Please restart VS Code to apply the new settings."
}

# Run main function
main "$@"
