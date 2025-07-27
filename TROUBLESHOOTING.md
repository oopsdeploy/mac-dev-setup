# Troubleshooting Guide

This guide covers common issues you might encounter during the setup process and how to resolve them.

## Common Installation Issues

### Homebrew Installation Issues

**Issue**: Homebrew installation fails with permission errors
```bash
Error: Permission denied @ dir_s_mkdir - /usr/local/Homebrew
```

**Solution**: 
1. Ensure you have admin privileges on your Mac
2. Try installing with the official script:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
3. For Apple Silicon Macs, make sure Homebrew is in your PATH:
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Docker Desktop Issues

**Issue**: Docker Desktop fails to start or shows "Docker Desktop is starting..." indefinitely

**Solutions**:
1. Restart Docker Desktop from Applications
2. Check if virtualization is enabled in System Preferences > Security & Privacy
3. For Apple Silicon Macs, ensure you downloaded the ARM64 version
4. Reset Docker Desktop: Docker > Troubleshoot > Reset to factory defaults

**Issue**: Docker commands require sudo

**Solution**: Add your user to the docker group (this is handled automatically by Docker Desktop on Mac)

### VS Code Extension Installation Issues

**Issue**: Extensions fail to install with "code: command not found"

**Solution**: 
1. Open VS Code
2. Press `Cmd+Shift+P` to open Command Palette
3. Type "Shell Command: Install 'code' command in PATH"
4. Select and run the command
5. Restart your terminal and try again

### Cloud CLI Authentication Issues

**Issue**: Azure CLI login fails

**Solutions**:
1. Try device code authentication:
```bash
az login --use-device-code
```
2. Clear existing credentials:
```bash
az account clear
az login
```
3. Check if you're behind a corporate firewall that blocks authentication

**Issue**: AWS CLI configuration issues

**Solutions**:
1. Ensure you have valid AWS credentials
2. Configure AWS CLI:
```bash
aws configure
```
3. Set up AWS SSO if your organization uses it:
```bash
aws configure sso
```

**Issue**: Google Cloud SDK authentication fails

**Solutions**:
1. Initialize gcloud:
```bash
gcloud init
```
2. Authenticate with application default credentials:
```bash
gcloud auth application-default login
```

### Kubernetes Tools Issues

**Issue**: kubectl commands fail with "connection refused"

**Solutions**:
1. Verify your kubeconfig is correctly set up:
```bash
kubectl config view
```
2. Check if your cluster is running:
```bash
kubectl cluster-info
```
3. Verify you're connected to the right context:
```bash
kubectl config current-context
kubectl config get-contexts
```

**Issue**: k9s fails to start

**Solutions**:
1. Ensure kubectl is working first
2. Check k9s configuration:
```bash
k9s info
```
3. Reset k9s configuration:
```bash
rm -rf ~/.k9s
```

### Python Environment Issues

**Issue**: Python commands use system Python instead of Homebrew Python

**Solution**: Add Homebrew Python to your PATH in `~/.zshrc`:
```bash
export PATH="/opt/homebrew/bin:$PATH"  # For Apple Silicon
export PATH="/usr/local/bin:$PATH"     # For Intel Macs
```

**Issue**: pip install fails with permission errors

**Solutions**:
1. Use virtual environments:
```bash
python3 -m venv myenv
source myenv/bin/activate
```
2. Install with user flag:
```bash
pip3 install --user package_name
```

### Shell Configuration Issues

**Issue**: Aliases and PATH changes don't persist

**Solutions**:
1. Make sure you're editing the correct shell configuration file:
   - For zsh (default on macOS Catalina+): `~/.zshrc`
   - For bash: `~/.bash_profile` or `~/.bashrc`
2. Reload your shell configuration:
```bash
source ~/.zshrc  # or ~/.bash_profile
```
3. Or restart your terminal

### Git Configuration Issues

**Issue**: Git push fails with authentication errors

**Solutions**:
1. Use GitHub CLI to authenticate:
```bash
gh auth login
```
2. Set up SSH keys for GitHub:
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
cat ~/.ssh/id_ed25519.pub  # Add this to GitHub
```
3. Use personal access tokens for HTTPS

### Performance Issues

**Issue**: Terminal or applications are slow to start

**Solutions**:
1. Check if you have too many items in your PATH
2. Clean up your shell configuration files
3. Restart your Mac
4. Check for conflicting software or resource usage

### M1/M2 Mac Specific Issues

**Issue**: Tools installed for x86_64 architecture instead of ARM64

**Solutions**:
1. Ensure you're using the ARM64 version of Homebrew:
```bash
which brew  # Should show /opt/homebrew/bin/brew
```
2. For tools that don't have ARM64 versions, use Rosetta 2:
```bash
arch -x86_64 brew install tool_name
```

**Issue**: Some tools don't work natively on Apple Silicon

**Solutions**:
1. Check if an ARM64 version is available
2. Use Rosetta 2 for x86_64 compatibility
3. Look for alternative tools with native ARM64 support

## Getting Help

### Checking Tool Versions
```bash
# Check if tools are installed and their versions
brew --version
docker --version
kubectl version --client
terraform --version
az --version
aws --version
gcloud version
```

### Useful Debugging Commands
```bash
# Check system information
uname -a
sw_vers

# Check architecture
arch
uname -m

# Check shell
echo $SHELL

# Check PATH
echo $PATH

# Check environment variables
env | grep -E "(PATH|HOME|SHELL)"
```

### Log Files
- Homebrew logs: `brew doctor` and `brew config`
- Docker Desktop logs: Docker > Troubleshoot > Get support information
- VS Code logs: Help > Toggle Developer Tools > Console

### Community Resources
- [Homebrew Troubleshooting](https://docs.brew.sh/Troubleshooting)
- [Docker Desktop for Mac Troubleshooting](https://docs.docker.com/desktop/troubleshoot/overview/)
- [VS Code Issues on GitHub](https://github.com/microsoft/vscode/issues)
- Stack Overflow with specific error messages

## Reporting Issues

If you encounter issues with this setup script:

1. Check this troubleshooting guide first
2. Search existing issues in the repository
3. Create a new issue with:
   - Your macOS version (`sw_vers`)
   - Your Mac architecture (`uname -m`)
   - The exact error message
   - Steps to reproduce the issue
   - What you expected to happen

## Manual Cleanup

If you need to completely reset your development environment:

```bash
# Remove Homebrew (use with caution)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

# Remove VS Code settings
rm -rf "$HOME/Library/Application Support/Code"

# Remove shell configurations (backup first!)
cp ~/.zshrc ~/.zshrc.backup
# Then edit ~/.zshrc to remove added configurations

# Remove tool-specific configurations
rm -rf ~/.docker
rm -rf ~/.kube
rm -rf ~/.aws
rm -rf ~/.azure
rm -rf ~/.config/gcloud
```
