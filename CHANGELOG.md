# Changelog

All notable changes to DevEnv Manager will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- Docker container health monitoring
- CI/CD pipeline diagnostics
- NPM and Python package vulnerability scanning
- Environment variable manager
- Shell configuration backup/restore
- Team configuration sharing
- VS Code extension integration
- Performance benchmarking tools

## [1.0.0] - 2025-02-05

### Added
- **Git Repository Health Check**
  - Repository size analysis
  - Large file detection (>10MB)
  - Uncommitted changes detection
  - Branch status (ahead/behind remote)
  - Stale branch detection
  - Garbage collection status monitoring
  - Detailed reporting with color-coded output

- **Git Repository Cleanup**
  - Aggressive garbage collection
  - Reflog cleanup and expiration
  - Repository repacking and optimization
  - Before/after size comparison
  - Safe execution with confirmation prompts

- **Development Environment Setup**
  - Automatic OS detection (macOS/Linux)
  - Package manager detection (Homebrew, apt, yum, pacman)
  - Essential development tools checking
  - One-click installation of missing tools
  - Support for git, curl, wget, vim, make, gcc

- **Environment Diagnosis**
  - Comprehensive system information display
  - Disk usage analysis
  - Git configuration verification
  - Development tools inventory (Python, Node.js, Ruby, Java, Go, Rust, Docker)
  - Package manager status

- **Project Template Generator**
  - Python project template (with setup.py, requirements.txt, tests/)
  - Node.js project template (with package.json)
  - Go project template (with go.mod, main.go)
  - Generic project template
  - Automatic git initialization
  - Smart .gitignore generation per project type
  - README.md template creation
  - MIT License inclusion
  - Initial commit automation

- **System Cleanup**
  - Package manager cache cleanup
  - Temporary files removal
  - Old log file cleanup (>30 days)
  - Cross-platform support (macOS/Linux)
  - Space reclamation reporting

- **Auto-Update System**
  - Version checking against GitHub releases
  - One-click update functionality
  - Automatic backup before update
  - Configurable auto-update checks
  - Restart after update

- **Configuration Management**
  - User preferences storage
  - Auto-update toggle
  - Default git branch configuration
  - JSON configuration file
  - Config directory: `~/.config/devenv-manager/`

- **Logging System**
  - Comprehensive logging to file
  - Timestamped log entries
  - Log rotation support
  - Log location: `~/.cache/devenv-manager/devenv-manager.log`

- **User Interface**
  - Color-coded output (success, error, warning, info)
  - Progress indicators
  - Clear section headers
  - Emoji indicators for quick status recognition
  - Formatted help documentation

- **Cross-Platform Support**
  - macOS 10.15+ support
  - Linux support (Ubuntu, Debian, Fedora, Arch)
  - Automatic OS detection
  - Platform-specific optimizations

### Documentation
- Comprehensive README.md with usage examples
- Detailed installation instructions
- Troubleshooting guide
- Real-world usage examples
- Contributing guidelines reference
- Changelog implementation

### Security
- No credential storage
- Safe file operations
- Confirmation prompts for destructive actions
- No automatic script execution without user consent

### Performance
- Efficient git operations
- Minimal system resource usage
- Fast repository analysis
- Optimized cleanup operations

## [0.1.0] - 2025-01-20 (Beta)

### Added
- Initial beta release
- Basic git health check functionality
- Simple environment setup
- Prototype update system

### Known Issues
- Limited error handling
- No comprehensive logging
- Basic template support only

---

## Version History Summary

| Version | Release Date | Key Features |
|---------|--------------|--------------|
| 1.0.0   | 2025-02-05   | Full release with all core features |
| 0.1.0   | 2025-01-20   | Initial beta release |

## Upgrade Guide

### From 0.1.0 to 1.0.0

1. Backup your existing configuration (if any)
2. Download the new version
3. Run `devenv-manager config` to set up new configuration
4. Previous logs will be migrated automatically

No breaking changes - all commands from 0.1.0 are still supported.

## Contributors

Thanks to all contributors who helped make this release possible!

- iyeoh88-svg (@iyeoh88-svg) - Creator and maintainer

## Feedback

Found a bug or have a feature request? Please open an issue on [GitHub](https://github.com/iyeoh88-svg/devenv-manager/issues).

---

**Legend:**
- 🎉 **Added** for new features
- 🔧 **Changed** for changes in existing functionality
- 🗑️ **Deprecated** for soon-to-be removed features
- ❌ **Removed** for now removed features
- 🐛 **Fixed** for any bug fixes
- 🔒 **Security** in case of vulnerabilities
