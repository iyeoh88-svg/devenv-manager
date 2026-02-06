#!/usr/bin/env bash

#############################################
# DevEnv Manager - Development Environment Manager
# Version: 1.0.0
# A comprehensive tool for managing development environments
# Works on: macOS and Linux
#############################################

set -euo pipefail

# Script metadata
SCRIPT_VERSION="1.0.0"
SCRIPT_NAME="devenv-manager"
GITHUB_REPO="iyeoh88-svg/${SCRIPT_NAME}"
UPDATE_CHECK_URL="https://api.github.com/repos/${GITHUB_REPO}/releases/latest"

# Color codes - with terminal detection
# Check if terminal supports colors
if [[ -t 1 ]] && [[ -n "${TERM:-}" ]] && command -v tput &>/dev/null && tput colors &>/dev/null && [[ $(tput colors) -ge 8 ]]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    MAGENTA='\033[0;35m'
    CYAN='\033[0;36m'
    NC='\033[0m' # No Color
    BOLD='\033[1m'
else
    # No color support - use empty strings
    RED=''
    GREEN=''
    YELLOW=''
    BLUE=''
    MAGENTA=''
    CYAN=''
    NC=''
    BOLD=''
fi

# Configuration
CONFIG_DIR="${HOME}/.config/devenv-manager"
CONFIG_FILE="${CONFIG_DIR}/config.json"
CACHE_DIR="${HOME}/.cache/devenv-manager"
LOG_FILE="${CACHE_DIR}/devenv-manager.log"

# Ensure directories exist
mkdir -p "${CONFIG_DIR}" "${CACHE_DIR}"

#############################################
# Logging Functions
#############################################

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" >> "${LOG_FILE}"
}

success() {
    echo -e "${GREEN}✓${NC} $*"
    log "SUCCESS: $*"
}

error() {
    echo -e "${RED}✗${NC} $*" >&2
    log "ERROR: $*"
}

warning() {
    echo -e "${YELLOW}⚠${NC} $*"
    log "WARNING: $*"
}

info() {
    echo -e "${BLUE}ℹ${NC} $*"
    log "INFO: $*"
}

header() {
    echo ""
    echo -e "${BOLD}${CYAN}=== $* ===${NC}"
    echo ""
}

#############################################
# System Detection
#############################################

detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        echo "unsupported"
    fi
}

detect_package_manager() {
    local os=$(detect_os)
    
    if [[ "$os" == "macos" ]]; then
        if command -v brew &> /dev/null; then
            echo "brew"
        else
            echo "none"
        fi
    elif [[ "$os" == "linux" ]]; then
        if command -v apt-get &> /dev/null; then
            echo "apt"
        elif command -v yum &> /dev/null; then
            echo "yum"
        elif command -v pacman &> /dev/null; then
            echo "pacman"
        else
            echo "none"
        fi
    fi
}

#############################################
# Version Check & Auto-Update
#############################################

check_for_updates() {
    info "Checking for updates..."
    
    if ! command -v curl &> /dev/null; then
        warning "curl not found. Skipping update check."
        return
    fi
    
    local latest_version
    latest_version=$(curl -s "${UPDATE_CHECK_URL}" 2>/dev/null | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/^v//')
    
    if [[ -z "$latest_version" ]]; then
        warning "Could not check for updates. Please check your internet connection."
        return
    fi
    
    if [[ "$latest_version" != "$SCRIPT_VERSION" ]]; then
        echo ""
        warning "A new version is available: ${latest_version} (current: ${SCRIPT_VERSION})"
        echo -e "${YELLOW}Update available!${NC}"
        echo "Visit: https://github.com/${GITHUB_REPO}/releases/latest"
        echo ""
        read -p "Would you like to update now? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            update_script
        fi
    else
        success "You are running the latest version (${SCRIPT_VERSION})"
    fi
}

update_script() {
    info "Updating ${SCRIPT_NAME}..."
    
    local temp_file="/tmp/${SCRIPT_NAME}.new"
    local download_url="https://raw.githubusercontent.com/${GITHUB_REPO}/main/${SCRIPT_NAME}"
    
    if curl -fsSL "${download_url}" -o "${temp_file}"; then
        chmod +x "${temp_file}"
        
        # Backup current script
        cp "$0" "${0}.backup"
        
        # Replace with new version
        mv "${temp_file}" "$0"
        
        success "Updated successfully! Restarting..."
        exec "$0" "$@"
    else
        error "Failed to download update"
        rm -f "${temp_file}"
        exit 1
    fi
}

#############################################
# Git Repository Health Check
#############################################

check_git_repo_health() {
    header "Git Repository Health Check"
    
    if [[ ! -d .git ]]; then
        error "Not a git repository. Run this command in a git repository."
        return 1
    fi
    
    local repo_name=$(basename "$(git rev-parse --show-toplevel)")
    info "Analyzing repository: ${repo_name}"
    echo ""
    
    # Check repository size
    local repo_size=$(du -sh .git 2>/dev/null | cut -f1)
    echo -e "${BOLD}Repository Size:${NC} ${repo_size}"
    
    # Check for large files
    echo ""
    info "Checking for large files (>10MB)..."
    local large_files=$(find . -type f -size +10M 2>/dev/null | grep -v '.git' | wc -l | tr -d ' ')
    if [[ $large_files -gt 0 ]]; then
        warning "Found ${large_files} large file(s)"
        echo "Large files detected:"
        find . -type f -size +10M 2>/dev/null | grep -v '.git' | head -5 | while read -r file; do
            local size=$(du -h "$file" | cut -f1)
            echo "  - $file (${size})"
        done
    else
        success "No large files detected"
    fi
    
    # Check for uncommitted changes
    echo ""
    if git diff-index --quiet HEAD -- 2>/dev/null; then
        success "No uncommitted changes"
    else
        warning "You have uncommitted changes"
        echo "Uncommitted files:"
        git status --short | head -10
    fi
    
    # Check branch info
    echo ""
    local current_branch=$(git branch --show-current)
    local ahead_behind=$(git rev-list --left-right --count origin/${current_branch}...HEAD 2>/dev/null || echo "0 0")
    local behind=$(echo "$ahead_behind" | awk '{print $1}')
    local ahead=$(echo "$ahead_behind" | awk '{print $2}')
    
    echo -e "${BOLD}Current Branch:${NC} ${current_branch}"
    if [[ $ahead -gt 0 ]]; then
        info "Ahead of origin by ${ahead} commit(s)"
    fi
    if [[ $behind -gt 0 ]]; then
        warning "Behind origin by ${behind} commit(s)"
        info "Run 'git pull' to update"
    fi
    
    # Check for stale branches
    echo ""
    info "Checking for stale branches..."
    local stale_count=$(git branch -r --merged | grep -v '\->' | grep -v 'main\|master\|develop' | wc -l | tr -d ' ')
    if [[ $stale_count -gt 0 ]]; then
        warning "Found ${stale_count} stale branch(es) that could be cleaned up"
    else
        success "No stale branches found"
    fi
    
    # Disk usage analysis
    echo ""
    info "Running git garbage collection check..."
    local gc_auto=$(git config --get gc.auto || echo "6700")
    local loose_objects=$(git count-objects -v | grep 'count:' | awk '{print $2}')
    
    if [[ $loose_objects -gt $gc_auto ]]; then
        warning "Found ${loose_objects} loose objects. Consider running: git gc"
    else
        success "Repository is well maintained (${loose_objects} loose objects)"
    fi
    
    echo ""
}

clean_git_repo() {
    header "Git Repository Cleanup"
    
    if [[ ! -d .git ]]; then
        error "Not a git repository"
        return 1
    fi
    
    warning "This will run git maintenance operations"
    read -p "Continue? (y/n): " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        info "Cleanup cancelled"
        return 0
    fi
    
    info "Running git garbage collection..."
    git gc --aggressive --prune=now
    success "Garbage collection complete"
    
    info "Running git reflog cleanup..."
    git reflog expire --expire=now --all
    success "Reflog cleaned"
    
    info "Optimizing repository..."
    git repack -A -d
    success "Repository optimized"
    
    local new_size=$(du -sh .git 2>/dev/null | cut -f1)
    success "Cleanup complete! New .git size: ${new_size}"
}

#############################################
# Development Environment Setup
#############################################

setup_dev_environment() {
    header "Development Environment Setup"
    
    local os=$(detect_os)
    local pkg_mgr=$(detect_package_manager)
    
    info "Detected OS: ${os}"
    info "Package Manager: ${pkg_mgr}"
    echo ""
    
    # Check for essential tools
    local tools=("git" "curl" "wget" "vim" "make" "gcc")
    
    echo "Checking essential development tools..."
    echo ""
    
    local missing_tools=()
    for tool in "${tools[@]}"; do
        if command -v "$tool" &> /dev/null; then
            success "$tool is installed"
        else
            warning "$tool is NOT installed"
            missing_tools+=("$tool")
        fi
    done
    
    echo ""
    
    if [[ ${#missing_tools[@]} -gt 0 ]]; then
        warning "Missing tools: ${missing_tools[*]}"
        read -p "Install missing tools? (y/n): " -n 1 -r
        echo
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            install_missing_tools "${missing_tools[@]}"
        fi
    else
        success "All essential tools are installed!"
    fi
}

install_missing_tools() {
    local tools=("$@")
    local pkg_mgr=$(detect_package_manager)
    
    if [[ "$pkg_mgr" == "none" ]]; then
        error "No package manager detected. Please install tools manually."
        return 1
    fi
    
    info "Installing tools using ${pkg_mgr}..."
    
    case "$pkg_mgr" in
        brew)
            for tool in "${tools[@]}"; do
                brew install "$tool" || warning "Failed to install $tool"
            done
            ;;
        apt)
            sudo apt-get update
            sudo apt-get install -y "${tools[@]}"
            ;;
        yum)
            sudo yum install -y "${tools[@]}"
            ;;
        pacman)
            sudo pacman -S --noconfirm "${tools[@]}"
            ;;
    esac
    
    success "Installation complete!"
}

#############################################
# Environment Diagnosis
#############################################

diagnose_environment() {
    header "Environment Diagnosis"
    
    # System info
    echo -e "${BOLD}System Information:${NC}"
    echo "OS: $(detect_os)"
    echo "Hostname: $(hostname)"
    echo "User: $(whoami)"
    echo "Shell: ${SHELL}"
    echo ""
    
    # Package manager info
    echo -e "${BOLD}Package Manager:${NC}"
    local pkg_mgr=$(detect_package_manager)
    echo "Detected: ${pkg_mgr}"
    echo ""
    
    # Disk usage
    echo -e "${BOLD}Disk Usage:${NC}"
    df -h ~ | tail -1 | awk '{print "Home Directory: " $3 " used of " $2 " (" $5 ")"}'
    echo ""
    
    # Git configuration
    echo -e "${BOLD}Git Configuration:${NC}"
    if command -v git &> /dev/null; then
        local git_version=$(git --version | awk '{print $3}')
        echo "Version: ${git_version}"
        
        local git_user=$(git config --global user.name 2>/dev/null || echo "Not set")
        local git_email=$(git config --global user.email 2>/dev/null || echo "Not set")
        echo "User: ${git_user}"
        echo "Email: ${git_email}"
    else
        warning "Git not installed"
    fi
    echo ""
    
    # Development tools
    echo -e "${BOLD}Development Tools:${NC}"
    local dev_tools=("python3" "node" "ruby" "java" "go" "rust" "docker")
    
    for tool in "${dev_tools[@]}"; do
        if command -v "$tool" &> /dev/null; then
            local version=$("$tool" --version 2>&1 | head -1)
            success "${tool}: ${version}"
        fi
    done
    echo ""
}

#############################################
# Project Template Generator
#############################################

create_project_template() {
    header "Create Project Template"
    
    read -p "Project name: " project_name
    
    if [[ -z "$project_name" ]]; then
        error "Project name cannot be empty"
        return 1
    fi
    
    if [[ -d "$project_name" ]]; then
        error "Directory ${project_name} already exists"
        return 1
    fi
    
    echo ""
    echo "Select project type:"
    echo "1) Python"
    echo "2) Node.js"
    echo "3) Go"
    echo "4) Generic"
    read -p "Choice (1-4): " -n 1 -r choice
    echo ""
    
    mkdir -p "$project_name"
    cd "$project_name" || return 1
    
    # Initialize git
    git init
    
    # Create .gitignore
    create_gitignore "$choice"
    
    # Create README
    cat > README.md << EOF
# ${project_name}

## Description
Add your project description here.

## Installation
\`\`\`bash
# Add installation instructions
\`\`\`

## Usage
\`\`\`bash
# Add usage examples
\`\`\`

## License
MIT
EOF
    
    # Create LICENSE
    cat > LICENSE << EOF
MIT License

Copyright (c) $(date +%Y) $(git config --global user.name 2>/dev/null || echo "Your Name")

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF
    
    case "$choice" in
        1)
            create_python_template
            ;;
        2)
            create_nodejs_template
            ;;
        3)
            create_go_template
            ;;
        *)
            ;;
    esac
    
    git add .
    git commit -m "Initial commit"
    
    success "Project ${project_name} created successfully!"
    info "Location: $(pwd)"
}

create_gitignore() {
    local type=$1
    
    case "$type" in
        1) # Python
            cat > .gitignore << 'EOF'
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
venv/
ENV/
.venv
.pytest_cache/
.coverage
htmlcov/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db
EOF
            ;;
        2) # Node.js
            cat > .gitignore << 'EOF'
# Node.js
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.npm
.yarn/cache
.yarn/unplugged
.yarn/build-state.yml
.yarn/install-state.gz
.pnp.*
dist/
build/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Environment
.env
.env.local
EOF
            ;;
        3) # Go
            cat > .gitignore << 'EOF'
# Go
*.exe
*.exe~
*.dll
*.so
*.dylib
*.test
*.out
go.work
vendor/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db
EOF
            ;;
        *)
            cat > .gitignore << 'EOF'
# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Environment
.env
.env.local
EOF
            ;;
    esac
}

create_python_template() {
    mkdir -p src tests
    
    cat > requirements.txt << 'EOF'
# Add your dependencies here
pytest>=7.0.0
EOF
    
    cat > src/__init__.py << 'EOF'
"""Main module"""
EOF
    
    cat > tests/__init__.py << 'EOF'
"""Tests module"""
EOF
    
    cat > setup.py << EOF
from setuptools import setup, find_packages

setup(
    name='${project_name}',
    version='0.1.0',
    packages=find_packages(),
    install_requires=[],
)
EOF
}

create_nodejs_template() {
    cat > package.json << EOF
{
  "name": "${project_name}",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "$(git config --global user.name 2>/dev/null || echo '')",
  "license": "MIT"
}
EOF
    
    touch index.js
}

create_go_template() {
    cat > go.mod << EOF
module ${project_name}

go 1.21
EOF
    
    cat > main.go << 'EOF'
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
EOF
}

#############################################
# Cleanup Tools
#############################################

cleanup_system() {
    header "System Cleanup"
    
    local os=$(detect_os)
    
    echo "This will clean:"
    echo "  - Package manager caches"
    echo "  - Temporary files"
    echo "  - Old logs"
    echo ""
    
    read -p "Continue? (y/n): " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        info "Cleanup cancelled"
        return 0
    fi
    
    if [[ "$os" == "macos" ]]; then
        if command -v brew &> /dev/null; then
            info "Cleaning Homebrew cache..."
            brew cleanup -s 2>/dev/null || true
            success "Homebrew cleaned"
        fi
    elif [[ "$os" == "linux" ]]; then
        local pkg_mgr=$(detect_package_manager)
        case "$pkg_mgr" in
            apt)
                info "Cleaning apt cache..."
                sudo apt-get clean
                sudo apt-get autoclean
                success "apt cleaned"
                ;;
            yum)
                info "Cleaning yum cache..."
                sudo yum clean all
                success "yum cleaned"
                ;;
        esac
    fi
    
    # Clean temp files
    info "Cleaning temporary files..."
    rm -rf /tmp/* 2>/dev/null || true
    
    # Clean old logs
    info "Cleaning old logs..."
    find "${HOME}/.cache" -type f -name "*.log" -mtime +30 -delete 2>/dev/null || true
    
    success "System cleanup complete!"
}

#############################################
# Configuration Management
#############################################

configure() {
    header "Configuration"
    
    echo "Configure ${SCRIPT_NAME}:"
    echo ""
    
    read -p "Enable automatic update checks? (y/n): " -n 1 -r auto_update
    echo ""
    
    read -p "Git default branch name (default: main): " default_branch
    default_branch=${default_branch:-main}
    
    cat > "${CONFIG_FILE}" << EOF
{
  "auto_update": "$auto_update",
  "default_branch": "$default_branch",
  "version": "${SCRIPT_VERSION}"
}
EOF
    
    success "Configuration saved to ${CONFIG_FILE}"
}

#############################################
# Help & Usage
#############################################

show_version() {
    echo "${SCRIPT_NAME} version ${SCRIPT_VERSION}"
}

show_help() {
    cat << EOF
${BOLD}${SCRIPT_NAME}${NC} - Development Environment Manager
Version: ${SCRIPT_VERSION}

${BOLD}USAGE:${NC}
    ${SCRIPT_NAME} [COMMAND] [OPTIONS]

${BOLD}COMMANDS:${NC}
    ${GREEN}check${NC}           Check git repository health
    ${GREEN}clean${NC}           Clean git repository
    ${GREEN}setup${NC}           Setup development environment
    ${GREEN}diagnose${NC}        Diagnose environment issues
    ${GREEN}create${NC}          Create new project from template
    ${GREEN}cleanup${NC}         Clean system caches and temp files
    ${GREEN}config${NC}          Configure ${SCRIPT_NAME}
    ${GREEN}update${NC}          Check for updates
    ${GREEN}version${NC}         Show version information
    ${GREEN}help${NC}            Show this help message

${BOLD}EXAMPLES:${NC}
    ${SCRIPT_NAME} check        # Check current git repository
    ${SCRIPT_NAME} setup        # Setup dev environment
    ${SCRIPT_NAME} create       # Create new project
    ${SCRIPT_NAME} update       # Check for updates

${BOLD}DOCUMENTATION:${NC}
    Visit: https://github.com/${GITHUB_REPO}

${BOLD}REPORT ISSUES:${NC}
    https://github.com/${GITHUB_REPO}/issues
EOF
}

#############################################
# Main Function
#############################################

main() {
    # Check for updates on startup (if configured)
    if [[ -f "${CONFIG_FILE}" ]]; then
        local auto_update=$(grep -o '"auto_update": "[^"]*"' "${CONFIG_FILE}" 2>/dev/null | cut -d'"' -f4)
        if [[ "$auto_update" =~ ^[Yy]$ ]]; then
            check_for_updates
        fi
    fi
    
    case "${1:-help}" in
        check)
            check_git_repo_health
            ;;
        clean)
            clean_git_repo
            ;;
        setup)
            setup_dev_environment
            ;;
        diagnose)
            diagnose_environment
            ;;
        create)
            create_project_template
            ;;
        cleanup)
            cleanup_system
            ;;
        config)
            configure
            ;;
        update)
            check_for_updates
            ;;
        version|--version|-v)
            show_version
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            error "Unknown command: $1"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# Run main function
main "$@"
