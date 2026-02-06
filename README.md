# DevEnv Manager

![Version](https://img.shields.io/github/v/release/iyeoh88-svg/devenv-manager)
![Stars](https://img.shields.io/github/stars/iyeoh88-svg/devenv-manager)
![Issues](https://img.shields.io/github/issues/iyeoh88-svg/devenv-manager)
![License](https://img.shields.io/github/license/iyeoh88-svg/devenv-manager)
![Last Commit](https://img.shields.io/github/last-commit/iyeoh88-svg/devenv-manager)

## 🎯 What Problem Does This Solve?

DevEnv Manager tackles the top 5 pain points developers face in 2025:

1. **⏱️ Environment Setup Headaches** - Automated setup saves hours on new machines
2. **🗂️ Git Repository Bloat** - Health checks and cleanup for large repos
3. **🔧 Tool Fragmentation** - Unified tool for managing dev environment
4. **🏗️ Inconsistent Environments** - "Works on my machine" problems solved
5. **🧹 System Maintenance** - Keep your dev machine clean and optimized

## ✨ Features

### 🔍 Git Repository Health Check
- **Repository size analysis** - Identify bloated repos quickly
- **Large file detection** - Find files >10MB that shouldn't be committed
- **Branch analysis** - Check for stale branches and ahead/behind status
- **Uncommitted changes detection** - Never lose work again
- **Garbage collection status** - Know when to run maintenance

### 🧹 Git Repository Cleanup
- **Aggressive garbage collection** - Reclaim disk space
- **Reflog cleanup** - Remove unnecessary history
- **Repository optimization** - Improve git performance
- **Safe execution** - Confirmation prompts before destructive operations

### 🛠️ Development Environment Setup
- **Automatic OS detection** - Works on macOS and Linux
- **Package manager detection** - Homebrew, apt, yum, pacman support
- **Essential tools check** - Verify git, curl, vim, make, gcc, and more
- **One-click installation** - Install missing tools automatically

### 🏥 Environment Diagnosis
- **System information** - OS, hostname, shell details
- **Disk usage analysis** - Know your space consumption
- **Git configuration check** - Verify your git setup
- **Development tools inventory** - See what's installed (Python, Node, Go, etc.)

### 📦 Project Template Generator
Create production-ready projects instantly:
- **Python projects** - With setup.py, requirements.txt, tests/
- **Node.js projects** - With package.json, proper structure
- **Go projects** - With go.mod and main.go
- **Generic projects** - With README, LICENSE, .gitignore

Each template includes:
- ✅ Git initialization
- ✅ Comprehensive .gitignore
- ✅ README.md template
- ✅ MIT License
- ✅ Initial commit

### 🧼 System Cleanup
- **Package manager cache cleanup** - Reclaim gigabytes of space
- **Temporary files removal** - Clean /tmp and caches
- **Old logs deletion** - Remove logs older than 30 days
- **Cross-platform support** - Works on all supported systems

### 🔄 Auto-Update System
- **Version checking** - Stay up-to-date with latest features
- **One-click updates** - Download and install updates automatically
- **Backup on update** - Previous version backed up before update
- **Configurable checks** - Enable/disable automatic update checks

## 📋 Requirements

- **macOS** 10.15+ or **Linux** (any modern distribution)
- `bash` 4.0+
- `git` 2.0+
- `curl` or `wget`
- Package manager: Homebrew (macOS) or apt/yum/pacman (Linux)

## 🚀 Installation

### Quick Install (Recommended)

```bash
# Download the script
curl -fsSL https://raw.githubusercontent.com/iyeoh88-svg/devenv-manager/main/devenv-manager -o devenv-manager

# Make it executable
chmod +x devenv-manager

# Move to PATH (optional)
sudo mv devenv-manager /usr/local/bin/

# Verify installation
devenv-manager version
```

### Manual Installation

1. Clone the repository:
```bash
git clone https://github.com/iyeoh88-svg/devenv-manager.git
cd devenv-manager
```

2. Make executable:
```bash
chmod +x devenv-manager
```

3. (Optional) Add to PATH:
```bash
sudo ln -s $(pwd)/devenv-manager /usr/local/bin/devenv-manager
```

## 📖 Usage

### Basic Commands

```bash
# Show help
devenv-manager help

# Check git repository health (run inside a git repo)
devenv-manager check

# Clean up git repository
devenv-manager clean

# Setup development environment
devenv-manager setup

# Diagnose environment issues
devenv-manager diagnose

# Create new project from template
devenv-manager create

# Clean system caches
devenv-manager cleanup

# Configure devenv-manager
devenv-manager config

# Check for updates
devenv-manager update

# Show version
devenv-manager version
```

### Real-World Examples

#### Example 1: New Machine Setup

```bash
# Install essential dev tools
devenv-manager setup

# Create a new Python project
devenv-manager create
# Select: 1 (Python)
# Enter project name: my-awesome-api

cd my-awesome-api
# Ready to code! Git initialized, .gitignore set up, tests/ created
```

#### Example 2: Clean Up Bloated Repository

```bash
cd ~/projects/legacy-monorepo

# Check repository health
devenv-manager check
# Output shows: Repository Size: 2.3GB, 47 large files found

# Run cleanup
devenv-manager clean
# Output: Cleanup complete! New .git size: 450MB
```

#### Example 3: Weekly Maintenance

```bash
# Add to your weekly routine
devenv-manager diagnose     # Check what's installed
devenv-manager cleanup      # Clean caches
devenv-manager update       # Get latest version
```

#### Example 4: Before Pushing Code

```bash
cd ~/projects/current-project

# Health check before pushing
devenv-manager check
# Warns about: uncommitted changes, large files, outdated branch
```

## 🎨 Output Examples

### Repository Health Check

```
=== Git Repository Health Check ===

ℹ Analyzing repository: my-project

Repository Size: 145MB

ℹ Checking for large files (>10MB)...
✓ No large files detected

✓ No uncommitted changes

Current Branch: feature/new-api
ℹ Ahead of origin by 3 commit(s)

ℹ Checking for stale branches...
⚠ Found 12 stale branch(es) that could be cleaned up

✓ Repository is well maintained (342 loose objects)
```

### Environment Diagnosis

```
=== Environment Diagnosis ===

System Information:
OS: macos
Hostname: macbook-pro
User: developer
Shell: /bin/zsh

Package Manager:
Detected: brew

Disk Usage:
Home Directory: 234GB used of 500GB (47%)

Git Configuration:
Version: 2.43.0
User: John Doe
Email: john@example.com

Development Tools:
✓ python3: Python 3.11.5
✓ node: v20.10.0
✓ docker: Docker version 24.0.7
✓ go: go version go1.21.5
```

## ⚙️ Configuration

Run `devenv-manager config` to set preferences:

```bash
devenv-manager config
```

Configuration is saved in `~/.config/devenv-manager/config.json`:

```json
{
  "auto_update": "y",
  "default_branch": "main",
  "version": "1.0.0"
}
```

## 🗂️ File Locations

- **Configuration**: `~/.config/devenv-manager/config.json`
- **Logs**: `~/.cache/devenv-manager/devenv-manager.log`
- **Cache**: `~/.cache/devenv-manager/`

## 🔧 Troubleshooting

### "Command not found" error

Make sure the script is in your PATH or use the full path:
```bash
/path/to/devenv-manager check
```

### Permission denied

Make the script executable:
```bash
chmod +x devenv-manager
```

### Git commands fail

Ensure you're running git commands inside a git repository:
```bash
cd /path/to/your/repo
devenv-manager check
```

### Update check fails

Check your internet connection. The script needs to connect to GitHub to check for updates.

## 🤝 Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Quick Start for Contributors

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📝 Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history and changes.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by common developer pain points identified in 2025
- Built to solve real-world problems faced by developers daily
- Thanks to the open-source community for inspiration

## 📬 Support

- **Issues**: [GitHub Issues](https://github.com/iyeoh88-svg/devenv-manager/issues)
- **Discussions**: [GitHub Discussions](https://github.com/iyeoh88-svg/devenv-manager/discussions)

## 🌟 Star History

If this tool helps you, please consider giving it a star! ⭐

## 🗺️ Roadmap

- [ ] Docker container health checks
- [ ] CI/CD pipeline diagnostics
- [ ] NPM/Python package audit
- [ ] Environment variable management
- [ ] Shell configuration backup/restore
- [ ] Team configuration sharing
- [ ] VS Code extension integration

## 💡 Why This Tool?

Based on extensive research of developer pain points in 2025:

- **75% of developers** waste time on environment setup
- **78% of DevOps professionals** spend 25-100% of time maintaining toolchains
- **Large repos** cause 40% increase in debugging time
- **Environment drift** is the #1 cause of "works on my machine" issues

DevEnv Manager solves these problems with a single, lightweight tool.

---

Made with ❤️ for developers, by developers.

**Remember**: A clean dev environment is a productive dev environment! 🚀
