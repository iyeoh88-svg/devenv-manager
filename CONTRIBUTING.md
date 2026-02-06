# Contributing to DevEnv Manager

First off, thank you for considering contributing to DevEnv Manager! It's people like you that make this tool better for everyone.

## 🎯 Project Vision

DevEnv Manager aims to solve the top pain points developers face when managing their development environments. We want to keep it:

- **Simple** - Easy to use, no complex configuration
- **Fast** - Minimal overhead, quick execution
- **Portable** - Works on macOS and Linux
- **Reliable** - Well-tested, safe operations
- **Extensible** - Easy to add new features

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Enhancements](#suggesting-enhancements)
  - [Your First Code Contribution](#your-first-code-contribution)
  - [Pull Requests](#pull-requests)
- [Development Setup](#development-setup)
- [Style Guidelines](#style-guidelines)
  - [Git Commit Messages](#git-commit-messages)
  - [Bash Code Style](#bash-code-style)
  - [Documentation Style](#documentation-style)
- [Testing](#testing)
- [Community](#community)

## 📜 Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please be:

- **Respectful** - Treat everyone with respect
- **Constructive** - Provide helpful feedback
- **Collaborative** - Work together towards solutions
- **Patient** - Remember everyone was a beginner once

## 🤝 How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When you create a bug report, include as many details as possible:

**Bug Report Template:**

```markdown
**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Run command '...'
2. See error '...'

**Expected behavior**
What you expected to happen.

**Actual behavior**
What actually happened.

**Environment:**
 - OS: [e.g. macOS 14.1, Ubuntu 22.04]
 - Shell: [e.g. bash 5.1, zsh 5.8]
 - DevEnv Manager Version: [e.g. 1.0.0]

**Additional context**
Add any other context about the problem here.

**Logs**
If applicable, paste relevant logs from:
~/.cache/devenv-manager/devenv-manager.log
```

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, include:

**Enhancement Template:**

```markdown
**Is your feature request related to a problem?**
A clear description of the problem. Ex. I'm always frustrated when [...]

**Describe the solution you'd like**
A clear description of what you want to happen.

**Describe alternatives you've considered**
Any alternative solutions or features you've considered.

**Additional context**
Any other context, screenshots, or examples.

**Would you be willing to implement this?**
Let us know if you'd like to work on this feature.
```

### Your First Code Contribution

Unsure where to begin? Look for issues labeled:

- `good-first-issue` - Good for newcomers
- `help-wanted` - Extra attention needed
- `documentation` - Improvements to docs
- `enhancement` - New features

### Pull Requests

1. **Fork the repository** and create your branch from `main`
2. **Make your changes** following our style guidelines
3. **Test your changes** on both macOS and Linux if possible
4. **Update documentation** if needed
5. **Write a clear commit message**
6. **Submit your pull request**

**Pull Request Template:**

```markdown
**Description**
What does this PR do?

**Related Issue**
Fixes #(issue number)

**Type of Change**
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update

**How Has This Been Tested?**
- [ ] Tested on macOS
- [ ] Tested on Linux
- [ ] Manual testing
- [ ] Automated tests added

**Checklist:**
- [ ] My code follows the style guidelines
- [ ] I have commented my code where needed
- [ ] I have updated the documentation
- [ ] My changes generate no new warnings
- [ ] I have tested on multiple platforms
```

## 🛠️ Development Setup

### Prerequisites

- Bash 4.0+
- Git 2.0+
- A macOS or Linux system for testing

### Setup

1. **Clone your fork:**
```bash
git clone https://github.com/iyeoh88-svg/devenv-manager.git
cd devenv-manager
```

2. **Make the script executable:**
```bash
chmod +x devenv-manager
```

3. **Test the script:**
```bash
./devenv-manager help
```

4. **Create a feature branch:**
```bash
git checkout -b feature/your-feature-name
```

### Project Structure

```
devenv-manager/
├── devenv-manager       # Main script
├── README.md            # User documentation
├── CHANGELOG.md         # Version history
├── CONTRIBUTING.md      # This file
├── LICENSE              # MIT License
└── tests/               # Test scripts (future)
```

## 🎨 Style Guidelines

### Git Commit Messages

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters
- Reference issues and pull requests after the first line

**Good commit messages:**
```
Add git repository health check feature

- Implement repository size analysis
- Add large file detection
- Include branch status checking

Fixes #123
```

**Commit message types:**
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, etc.)
- `refactor:` - Code refactoring
- `test:` - Adding tests
- `chore:` - Maintenance tasks

### Bash Code Style

Follow these conventions for consistency:

1. **Indentation**: Use 4 spaces (no tabs)

2. **Functions**:
```bash
# Good
function_name() {
    local var_name="value"
    echo "Result"
}

# Not recommended
function_name(){
  echo "Result"
}
```

3. **Variables**:
```bash
# Constants: UPPER_CASE
readonly CONSTANT_VALUE="value"

# Local variables: lower_case
local my_variable="value"

# Global variables: CamelCase (avoid if possible)
GlobalVariable="value"
```

4. **Quoting**:
```bash
# Always quote variables
echo "${variable}"
echo "${array[@]}"

# Use single quotes for literal strings
echo 'Literal string'

# Use double quotes when interpolating
echo "Variable: ${var}"
```

5. **Conditions**:
```bash
# Use [[ ]] for conditions
if [[ -f "$file" ]]; then
    echo "File exists"
fi

# Use || and && for logic
[[ -f "$file" ]] && echo "exists" || echo "missing"
```

6. **Error Handling**:
```bash
# Use set options
set -euo pipefail

# Check command success
if ! command -v git &> /dev/null; then
    error "git not found"
    return 1
fi
```

7. **Comments**:
```bash
# Single-line comments for brief explanations

#############################################
# Section headers for major sections
#############################################

# Inline comments for complex logic
grep pattern file | # Filter
    sort |           # Sort results
    uniq             # Remove duplicates
```

### Documentation Style

1. **Code comments**: Explain **why**, not **what**
2. **Function headers**: Document parameters and return values
3. **README**: Keep examples practical and tested
4. **Changelog**: Follow Keep a Changelog format

## 🧪 Testing

### Manual Testing Checklist

Before submitting a PR, test on:

- [ ] macOS (latest version)
- [ ] Linux (Ubuntu/Debian recommended)
- [ ] With and without git repository
- [ ] With and without package manager
- [ ] All commands work as expected
- [ ] Error messages are clear
- [ ] No permission issues

### Testing Commands

```bash
# Test help
./devenv-manager help

# Test version
./devenv-manager version

# Test in a git repo
cd /tmp
git init test-repo
cd test-repo
/path/to/devenv-manager check

# Test environment setup
./devenv-manager setup

# Test diagnosis
./devenv-manager diagnose
```

### Adding Tests

We welcome contributions to our test suite! Future improvements:

1. Automated test framework
2. CI/CD integration
3. Cross-platform testing
4. Performance benchmarks

## 💬 Community

### Getting Help

- **GitHub Discussions**: Ask questions, share ideas
- **GitHub Issues**: Report bugs, request features
- **Email**: Contact maintainers directly

### Recognition

Contributors will be:
- Listed in release notes
- Mentioned in the README
- Given credit in commit messages

## 🚀 Release Process

For maintainers:

1. Update version in script
2. Update CHANGELOG.md
3. Create git tag
4. Push to GitHub
5. Create GitHub release
6. Announce on discussions

## 📚 Resources

- [Bash Best Practices](https://github.com/bahamas10/bash-style-guide)
- [Git Commit Messages](https://chris.beams.io/posts/git-commit/)
- [Keep a Changelog](https://keepachangelog.com/)
- [Semantic Versioning](https://semver.org/)

## 🙏 Thank You!

Your contributions make this project better for everyone. Whether it's code, documentation, bug reports, or feature ideas - every contribution matters!

---

**Questions?** Feel free to open an issue or reach out to the maintainers.

**Happy Contributing! 🎉**
