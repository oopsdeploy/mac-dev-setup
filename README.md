# Mac Development Setup for DevOps/SRE/Platform Engineers

This repository contains scripts and configuration to set up a Mac development environment specifically tailored for DevOps, SRE, and Platform Engineering work.

## Quick Start

```bash
# Clone this repository
git clone https://github.com/oopsdeploy/mac-dev-setup.git
cd mac-dev-setup

# Make the setup script executable
chmod +x setup.sh

# Run the setup script
./setup.sh
```

## What Gets Installed

### Core Development Tools
- **Homebrew** - Package manager for macOS
- **Git** & **GitHub CLI** - Version control and GitHub integration
- **VS Code** - Code editor with essential extensions
- **Docker Desktop** - Containerization platform
- **Python 3** & **pip3** - Python development environment
- **Node.js** & **npm** - JavaScript runtime and package manager
- **Go** - Go programming language
- **Rust** & **Cargo** - Rust programming language and package manager

### Kubernetes & Container Tools
- **kubectl** - Kubernetes command-line tool
- **helm** - Kubernetes package manager
- **k9s** - Kubernetes cluster management UI
- **kubectx/kubens** - Switch between Kubernetes contexts and namespaces
- **stern** - Multi-pod log tailing for Kubernetes

### Cloud Provider CLIs
- **Azure CLI (az)** - Microsoft Azure command-line interface
- **AWS CLI** - Amazon Web Services command-line interface
- **Google Cloud SDK (gcloud)** - Google Cloud Platform CLI

### Infrastructure as Code
- **Terraform** - Infrastructure provisioning tool
- **Terragrunt** - Terraform wrapper for DRY configurations
- **Packer** - Automated image building
- **Ansible** - Configuration management and automation

### HashiCorp Tools
- **Vault** - Secrets management
- **Consul** - Service networking and discovery
- **Nomad** - Workload orchestration

### Data Processing & APIs
- **jq** - JSON processor
- **yq** - YAML processor
- **HTTPie** - Modern HTTP client
- **curl** & **wget** - Data transfer tools
- **JFrog CLI (jf)** - JFrog platform CLI

### System & Network Tools
- **tmux** - Terminal multiplexer
- **tree** - Directory structure visualization
- **watch** - Execute commands periodically
- **pstree** - Process tree visualization
- **nmap** - Network discovery and security auditing
- **telnet** - Network protocol testing
- **htop** - Interactive process viewer
- **ncdu** - Disk usage analyzer

### Security & Secrets
- **GPG** - Encryption and signing
- **1Password CLI** - Password management from command line

## Manual Setup Required

Some applications require manual installation or configuration:

1. **Docker Desktop** - Requires manual download and installation from Docker's website
2. **VS Code Extensions** - Will be installed automatically via script
3. **Cloud Provider Authentication** - You'll need to run `az login`, `aws configure`, `gcloud auth login` after installation

## Configuration Files

The setup script will also install configuration files for:
- `.gitconfig` - Git global configuration
- `.tmux.conf` - tmux configuration
- VS Code settings and extensions

## Usage

After installation, you'll have access to all the tools needed for modern DevOps/SRE/Platform engineering work. The setup script is idempotent, so you can run it multiple times safely.

## Customization

Edit `setup.sh` to add or remove tools based on your specific needs. The script is organized into sections for easy modification.

## Additional Resources

- **[Additional Tools](ADDITIONAL_TOOLS.md)** - Extended list of tools you might want to install
- **[Troubleshooting Guide](TROUBLESHOOTING.md)** - Solutions to common setup issues
- **[VS Code Settings](vscode-settings.json)** - Optimized VS Code configuration for DevOps work

## Repository Structure

```
mac-dev-setup/
├── README.md              # This file
├── setup.sh              # Main setup script
├── configure-vscode.sh    # VS Code settings configuration
├── vscode-settings.json   # VS Code settings optimized for DevOps
├── ADDITIONAL_TOOLS.md    # Extended tool recommendations
└── TROUBLESHOOTING.md     # Common issues and solutions
```

## Contributing

Feel free to submit issues and enhancement requests! If you have suggestions for additional tools or improvements to the setup process, please open an issue or submit a pull request.

## License

This project is open source and available under the [MIT License](LICENSE).