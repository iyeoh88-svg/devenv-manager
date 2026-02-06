#!/usr/bin/env bash

#############################################
# DevEnv Manager - Installation Script
#############################################

set -euo pipefail

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

REPO_URL="https://github.com/iyeoh88-svg/devenv-manager"
INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="devenv-manager"

echo "╔══════════════════════════════════════════╗"
echo "║   DevEnv Manager - Installation Script   ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# Check for required commands
if ! command -v curl &> /dev/null; then
    echo -e "${RED}Error: curl is required but not installed.${NC}"
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}Warning: git is recommended for full functionality.${NC}"
fi

# Check for sudo if installing to /usr/local/bin
if [[ ! -w "$INSTALL_DIR" ]]; then
    echo -e "${YELLOW}Installation requires sudo privileges for ${INSTALL_DIR}${NC}"
    if ! sudo -v; then
        echo -e "${RED}Failed to obtain sudo privileges${NC}"
        exit 1
    fi
fi

echo "Downloading DevEnv Manager..."
TEMP_FILE="/tmp/${SCRIPT_NAME}"

if curl -fsSL "${REPO_URL}/raw/main/${SCRIPT_NAME}" -o "${TEMP_FILE}"; then
    echo -e "${GREEN}✓ Download complete${NC}"
else
    echo -e "${RED}✗ Failed to download${NC}"
    exit 1
fi

echo "Installing to ${INSTALL_DIR}/${SCRIPT_NAME}..."
chmod +x "${TEMP_FILE}"

if [[ -w "$INSTALL_DIR" ]]; then
    mv "${TEMP_FILE}" "${INSTALL_DIR}/${SCRIPT_NAME}"
else
    sudo mv "${TEMP_FILE}" "${INSTALL_DIR}/${SCRIPT_NAME}"
fi

echo -e "${GREEN}✓ Installation complete!${NC}"
echo ""
echo "Verify installation:"
echo "  ${SCRIPT_NAME} version"
echo ""
echo "Get started:"
echo "  ${SCRIPT_NAME} help"
echo ""
echo "Documentation: ${REPO_URL}"
