#!/bin/bash

# Mac Development Setup for DevOps/SRE/Platform Engineers
# This script installs essential tools and configures the development environment

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install Homebrew
install_homebrew() {
    print_status "Installing Homebrew..."
    if command_exists brew; then
        print_success "Homebrew already installed"
    else
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        
        print_success "Homebrew installed successfully"
    fi
}

# Install core development tools
install_core_tools() {
    print_status "Installing core development tools..."
    
    # Update Homebrew
    brew update
    
    # Core tools
    local core_tools=(
        "git"
        "gh"                    # GitHub CLI
        "python@3.11"
        "node"
        "go"
        "rust"
        "tmux"
        "tree"
        "watch"
        "htop"
        "ncdu"
        "curl"
        "wget"
        "gpg"
        "telnet"
        "nmap"
    )
    
    for tool in "${core_tools[@]}"; do
        if brew list "$tool" &>/dev/null; then
            print_success "$tool already installed"
        else
            print_status "Installing $tool..."
            brew install "$tool"
        fi
    done
}

# Install Kubernetes and container tools
install_k8s_tools() {
    print_status "Installing Kubernetes and container tools..."
    
    local k8s_tools=(
        "kubectl"
        "helm"
        "k9s"
        "kubectx"
        "stern"
    )
    
    for tool in "${k8s_tools[@]}"; do
        if brew list "$tool" &>/dev/null; then
            print_success "$tool already installed"
        else
            print_status "Installing $tool..."
            brew install "$tool"
        fi
    done
}

# Install cloud provider CLIs
install_cloud_tools() {
    print_status "Installing cloud provider CLIs..."
    
    local cloud_tools=(
        "azure-cli"
        "awscli"
        "google-cloud-sdk"
    )
    
    for tool in "${cloud_tools[@]}"; do
        if brew list "$tool" &>/dev/null; then
            print_success "$tool already installed"
        else
            print_status "Installing $tool..."
            brew install "$tool"
        fi
    done
}

# Install Infrastructure as Code tools
install_iac_tools() {
    print_status "Installing Infrastructure as Code tools..."
    
    local iac_tools=(
        "terraform"
        "terragrunt"
        "packer"
        "ansible"
    )
    
    for tool in "${iac_tools[@]}"; do
        if brew list "$tool" &>/dev/null; then
            print_success "$tool already installed"
        else
            print_status "Installing $tool..."
            brew install "$tool"
        fi
    done
}

# Install HashiCorp tools
install_hashicorp_tools() {
    print_status "Installing HashiCorp tools..."
    
    local hashicorp_tools=(
        "vault"
        "consul"
        "nomad"
    )
    
    for tool in "${hashicorp_tools[@]}"; do
        if brew list "$tool" &>/dev/null; then
            print_success "$tool already installed"
        else
            print_status "Installing $tool..."
            brew install "$tool"
        fi
    done
}

# Install data processing and API tools
install_data_tools() {
    print_status "Installing data processing and API tools..."
    
    local data_tools=(
        "jq"
        "yq"
        "httpie"
        "jfrog-cli"
    )
    
    for tool in "${data_tools[@]}"; do
        if brew list "$tool" &>/dev/null; then
            print_success "$tool already installed"
        else
            print_status "Installing $tool..."
            brew install "$tool"
        fi
    done
}

# Install cask applications
install_cask_apps() {
    print_status "Installing GUI applications..."
    
    local cask_apps=(
        "visual-studio-code"
        "docker"
        "1password-cli"
    )
    
    for app in "${cask_apps[@]}"; do
        if brew list --cask "$app" &>/dev/null; then
            print_success "$app already installed"
        else
            print_status "Installing $app..."
            brew install --cask "$app"
        fi
    done
}

# Install VS Code extensions
install_vscode_extensions() {
    print_status "Installing VS Code extensions..."
    
    if command_exists code; then
        local extensions=(
            "ms-vscode.vscode-docker"
            "ms-kubernetes-tools.vscode-kubernetes-tools"
            "hashicorp.terraform"
            "redhat.vscode-yaml"
            "ms-python.python"
            "golang.go"
            "rust-lang.rust-analyzer"
            "github.copilot"
            "github.vscode-pull-request-github"
            "ms-vscode.azure-repos"
            "ms-vscode.azurecli"
            "amazonwebservices.aws-toolkit-vscode"
            "googlecloudtools.cloudcode"
            "jfrog.jfrog-vscode-extension"
        )
        
        for extension in "${extensions[@]}"; do
            print_status "Installing VS Code extension: $extension"
            code --install-extension "$extension" --force
        done
        
        print_success "VS Code extensions installed"
    else
        print_warning "VS Code not found, skipping extension installation"
    fi
}

# Configure Git
configure_git() {
    print_status "Configuring Git..."
    
    # Check if git user is already configured
    if git config --global user.name &>/dev/null && git config --global user.email &>/dev/null; then
        print_success "Git already configured"
        return
    fi
    
    echo "Please enter your Git configuration details:"
    read -p "Full Name: " git_name
    read -p "Email: " git_email
    
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    git config --global init.defaultBranch main
    git config --global pull.rebase false
    
    print_success "Git configured successfully"
}

# Setup shell configuration
setup_shell_config() {
    print_status "Setting up shell configuration..."
    
    # Add useful aliases to .zshrc
    cat >> ~/.zshrc << 'EOF'

# DevOps/SRE aliases
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kgn='kubectl get nodes'
alias kctx='kubectx'
alias kns='kubens'
alias tf='terraform'
alias tg='terragrunt'
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Docker aliases
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias di='docker images'
alias dex='docker exec -it'

# Git aliases
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gs='git status'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

# Terraform aliases
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tfv='terraform validate'
alias tff='terraform fmt'

EOF

    print_success "Shell configuration updated"
}

# Create tmux configuration
create_tmux_config() {
    print_status "Creating tmux configuration..."
    
    cat > ~/.tmux.conf << 'EOF'
# Set prefix to Ctrl-a
set -g prefix C-a
unbind C-b
bind C-a send-prefix

# Enable mouse mode
set -g mouse on

# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1

# Reload config file
bind r source-file ~/.tmux.conf \; display "Config reloaded!"

# Split panes using | and -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# Switch panes using Alt-arrow without prefix
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# Enable vi mode
setw -g mode-keys vi

# Status bar customization
set -g status-bg black
set -g status-fg white
set -g status-left '#[fg=green]#S '
set -g status-right '#[fg=yellow]%Y-%m-%d %H:%M'

EOF

    print_success "tmux configuration created"
}

# Main installation function
main() {
    echo "=============================================="
    echo "Mac Development Setup for DevOps/SRE/Platform Engineers"
    echo "=============================================="
    echo
    
    # Check if running on macOS
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This script is designed for macOS only"
        exit 1
    fi
    
    # Install components
    install_homebrew
    install_core_tools
    install_k8s_tools
    install_cloud_tools
    install_iac_tools
    install_hashicorp_tools
    install_data_tools
    install_cask_apps
    install_vscode_extensions
    configure_git
    setup_shell_config
    create_tmux_config
    
    echo
    echo "=============================================="
    print_success "Setup completed successfully!"
    echo "=============================================="
    echo
    echo "Next steps:"
    echo "1. Restart your terminal or run 'source ~/.zshrc'"
    echo "2. Start Docker Desktop from Applications"
    echo "3. Authenticate with cloud providers:"
    echo "   - Azure: az login"
    echo "   - AWS: aws configure"
    echo "   - GCP: gcloud auth login"
    echo "4. Configure kubectl contexts for your clusters"
    echo
    echo "Happy coding! 🚀"
}

# Run main function
main "$@"
