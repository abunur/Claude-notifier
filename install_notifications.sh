#!/bin/bash
# Claude Code Notification System - One-Click Installer
# 
# This script installs a notification system that alerts you when
# Claude Code or long-running tasks complete.
#
# Usage: bash install_notifications.sh

set -e

# Configuration
INSTALL_DIR="$HOME/workspace/claude/claude-notifier"
SCRIPT_NAME="notify_complete.sh"
SCRIPT_PATH="$INSTALL_DIR/$SCRIPT_NAME"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔔 Claude Code Notification System Installer${NC}"
echo "============================================"
echo ""

# Check if macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "${YELLOW}⚠️  Warning: This script is designed for macOS.${NC}"
    echo "For Linux/Windows, you'll need to modify the notification commands."
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Check if directory exists (it should since script is there)
echo -e "${BLUE}📁 Using directory: $INSTALL_DIR${NC}"
if [[ ! -f "$SCRIPT_PATH" ]]; then
    echo -e "${YELLOW}⚠️  Script not found at $SCRIPT_PATH${NC}"
    echo -e "${BLUE}Using existing script in current directory...${NC}"
    SCRIPT_PATH="$INSTALL_DIR/notify_complete.sh"
fi

# Skip creating the script since it already exists
echo -e "${BLUE}📝 Using existing notification script...${NC}"

# Instead of creating, just verify it exists
if [[ ! -f "$SCRIPT_PATH" ]]; then
    echo -e "${RED}❌ Error: notify_complete.sh not found!${NC}"
    exit 1
fi

# Make script executable
chmod +x "$SCRIPT_PATH"
echo -e "${GREEN}✅ Script ready${NC}"

# Detect shell and update profile
if [[ "$SHELL" == */zsh ]]; then
    PROFILE="$HOME/.zshrc"
    SHELL_NAME="zsh"
elif [[ "$SHELL" == */bash ]]; then
    if [[ -f "$HOME/.bash_profile" ]]; then
        PROFILE="$HOME/.bash_profile"
    else
        PROFILE="$HOME/.bashrc"
    fi
    SHELL_NAME="bash"
else
    PROFILE="$HOME/.profile"
    SHELL_NAME="unknown"
fi

echo -e "${BLUE}🔍 Detected shell: $SHELL_NAME${NC}"
echo -e "${BLUE}📄 Profile file: $PROFILE${NC}"

# Check if already installed
if grep -q "Claude Code Notification System" "$PROFILE" 2>/dev/null; then
    echo -e "${YELLOW}⚠️  Notification system already installed in $PROFILE${NC}"
    read -p "Do you want to reinstall/update? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Remove old installation
        sed -i.bak '/# Claude Code Notification System/,/^$/d' "$PROFILE"
        echo -e "${GREEN}✅ Removed old installation${NC}"
    else
        echo -e "${BLUE}Skipping profile update...${NC}"
        SKIP_PROFILE=true
    fi
fi

# Add aliases to profile
if [[ "$SKIP_PROFILE" != "true" ]]; then
    echo -e "${BLUE}📝 Adding aliases to $PROFILE...${NC}"
    cat >> "$PROFILE" << EOF

# Claude Code Notification System
# Installed on $(date)
alias notify="$SCRIPT_PATH"
alias notify-done="$SCRIPT_PATH done"
alias notify-build="$SCRIPT_PATH build"
alias notify-error="$SCRIPT_PATH error"
alias notify-test="$SCRIPT_PATH test"

# Function to run any command with notification
run-notify() {
    "\$@" && $SCRIPT_PATH done || $SCRIPT_PATH error
}

# Shorter alias for quick notifications
alias nd="$SCRIPT_PATH done"
alias ne="$SCRIPT_PATH error"
alias nt="$SCRIPT_PATH test"

EOF
    echo -e "${GREEN}✅ Aliases added successfully${NC}"
fi

# Test the installation
echo ""
echo -e "${BLUE}🧪 Testing installation...${NC}"
"$SCRIPT_PATH" test

# Success message
echo ""
echo -e "${GREEN}🎉 Installation Complete!${NC}"
echo ""
echo "To activate the commands now, run:"
echo -e "  ${YELLOW}source $PROFILE${NC}"
echo ""
echo "Or simply open a new terminal window."
echo ""
echo -e "${BLUE}Available Commands:${NC}"
echo "  notify-done    - Alert when Claude is ready"
echo "  notify-test    - Test the notification system"
echo "  notify-error   - Error notification"
echo "  notify-build   - Build complete notification"
echo "  nd             - Short alias for notify-done"
echo ""
echo -e "${BLUE}Usage Examples:${NC}"
echo "  notify-done                      # When Claude finishes"
echo "  run-notify ./gradlew build       # Auto-notify after command"
echo "  run-notify sleep 5               # Test with 5-second delay"
echo ""
echo -e "${BLUE}Pro Tip:${NC}"
echo "Just type 'nd' (short for notify-done) whenever you see"
echo "Claude has finished processing and you want to be alerted!"
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}"