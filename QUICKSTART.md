# DevEnv Manager - Quick Start Guide

Get up and running with DevEnv Manager in 5 minutes!

## 🚀 Installation

### One-Line Install

```bash
curl -fsSL https://raw.githubusercontent.com/iyeoh88-svg/devenv-manager/main/install.sh | bash
```

### Verify Installation

```bash
devenv-manager version
```

Expected output: `devenv-manager version 1.0.0`

## 📖 5-Minute Tutorial

### 1. Check Your Git Repository (30 seconds)

```bash
cd ~/your-project
devenv-manager check
```

**What it does:** Analyzes your git repository for issues like large files, bloat, stale branches.

**What you'll see:**
- Repository size
- Large files (>10MB)
- Uncommitted changes
- Branch status
- Maintenance recommendations

### 2. Set Up Your Development Environment (1 minute)

```bash
devenv-manager setup
```

**What it does:** Checks and installs essential development tools.

**What you'll get:**
- Automatic detection of your OS and package manager
- Check for git, curl, vim, make, gcc
- One-click installation of missing tools

### 3. Diagnose Your Environment (30 seconds)

```bash
devenv-manager diagnose
```

**What it shows:**
- System information
- Installed development tools (Python, Node, Go, etc.)
- Git configuration
- Disk usage

### 4. Create a New Project (2 minutes)

```bash
devenv-manager create
```

**Follow the prompts:**
1. Enter project name: `my-awesome-project`
2. Select project type: `1` (Python) / `2` (Node.js) / `3` (Go) / `4` (Generic)

**What you get:**
- Initialized git repository
- Project structure
- .gitignore configured
- README.md template
- LICENSE file
- Ready to code!

### 5. Clean Up Your System (1 minute)

```bash
devenv-manager cleanup
```

**What it cleans:**
- Package manager caches
- Temporary files
- Old logs (>30 days)
- Reclaims valuable disk space

## 🎯 Common Use Cases

### Weekly Maintenance Routine

```bash
# Monday morning routine
devenv-manager diagnose      # See what's installed
devenv-manager cleanup       # Clean up caches
devenv-manager update        # Check for updates
```

### Before Starting a New Feature

```bash
cd ~/project
devenv-manager check         # Health check
git checkout -b feature/new  # Create branch
# Start coding!
```

### Onboarding a New Machine

```bash
# 1. Install DevEnv Manager
curl -fsSL https://raw.githubusercontent.com/iyeoh88-svg/devenv-manager/main/install.sh | bash

# 2. Setup environment
devenv-manager setup

# 3. Configure
devenv-manager config
```

### Cleaning Up a Bloated Repository

```bash
cd ~/old-project
devenv-manager check         # See the damage
devenv-manager clean         # Fix it
```

## ⚡ Power User Tips

### Tip 1: Auto-Update Checks

Configure automatic update checking:

```bash
devenv-manager config
# Enable automatic update checks? (y/n): y
```

### Tip 2: Combine Commands

```bash
# Check and clean in one go
cd ~/project && devenv-manager check && devenv-manager clean
```

### Tip 3: Check Before Pushing

Add to your git workflow:

```bash
# In your git pre-push hook
devenv-manager check
```

### Tip 4: View Logs

```bash
# Check the logs if something goes wrong
tail -f ~/.cache/devenv-manager/devenv-manager.log
```

### Tip 5: Quick Project Creation

```bash
# Create Python project and cd into it
devenv-manager create && cd my-project
```

## 📊 Understanding Output

### Success (Green ✓)
Operation completed successfully

### Warning (Yellow ⚠)
Attention needed, but not critical

### Error (Red ✗)
Something went wrong, action required

### Info (Blue ℹ)
General information

## 🔧 Troubleshooting

### Issue: "Command not found"

**Solution:**
```bash
# Check if in PATH
which devenv-manager

# If not, use full path
/usr/local/bin/devenv-manager version
```

### Issue: "Permission denied"

**Solution:**
```bash
# Make executable
chmod +x /usr/local/bin/devenv-manager
```

### Issue: Update check fails

**Solution:**
- Check internet connection
- Verify GitHub is accessible
- Try again later

## 📚 Next Steps

### Learn More

- Read the full [README.md](README.md)
- Check out [CONTRIBUTING.md](CONTRIBUTING.md)
- See [CHANGELOG.md](CHANGELOG.md) for version history

### Get Help

- Open an issue: [GitHub Issues](https://github.com/iyeoh88-svg/devenv-manager/issues)
- Join discussions: [GitHub Discussions](https://github.com/iyeoh88-svg/devenv-manager/discussions)

### Share Feedback

Did DevEnv Manager help you? Give it a ⭐ on GitHub!

## 🎓 Cheat Sheet

```bash
# Essential Commands
devenv-manager help          # Show help
devenv-manager version       # Show version
devenv-manager update        # Check for updates

# Repository Management
devenv-manager check         # Health check (in git repo)
devenv-manager clean         # Clean repository (in git repo)

# Environment
devenv-manager setup         # Setup dev tools
devenv-manager diagnose      # Check environment
devenv-manager cleanup       # Clean system

# Project Creation
devenv-manager create        # New project from template

# Configuration
devenv-manager config        # Configure settings
```

## ⏱️ Time Savings Breakdown

| Task | Manual | With DevEnv Manager | Saved |
|------|--------|---------------------|-------|
| New project setup | 15 min | 2 min | 13 min |
| Environment check | 10 min | 30 sec | 9.5 min |
| Repository cleanup | 30 min | 2 min | 28 min |
| Tool installation | 20 min | 3 min | 17 min |
| **Total per week** | **75 min** | **8 min** | **67 min** |

**That's 58 hours saved per year!** ⏰💰

---

**Ready to dive deeper?** Check out the full [README.md](README.md) for advanced features and detailed documentation.

**Happy coding!** 🚀
