#!/usr/bin/env bash
# Script to run ansible playbook on localhost

set -e

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLAYBOOK="${SCRIPT_DIR}/ansible/dotfiles.yml"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if ansible is installed
if ! command -v ansible-playbook &> /dev/null; then
    echo -e "${RED}Error: ansible-playbook is not installed${NC}"
    echo "Install it with: pip install ansible"
    echo "Or on macOS: brew install ansible"
    exit 1
fi

# Build the ansible-playbook command
ANSIBLE_CMD="ansible-playbook ${PLAYBOOK} --connection=local -i localhost,"

# Add tags if provided as arguments
if [ $# -gt 0 ]; then
    ANSIBLE_CMD="${ANSIBLE_CMD} --tags $*"
fi

# Add verbose flag if VERBOSE environment variable is set
if [ -n "$VERBOSE" ]; then
    ANSIBLE_CMD="${ANSIBLE_CMD} -vvv"
fi

echo -e "${GREEN}Running ansible playbook...${NC}"
echo -e "${YELLOW}Command: ${ANSIBLE_CMD}${NC}"
echo ""

# Ask for sudo password upfront
sudo -v

# Keep sudo alive in background
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Run the playbook
eval $ANSIBLE_CMD

echo ""
echo -e "${GREEN}Ansible playbook completed successfully!${NC}"
