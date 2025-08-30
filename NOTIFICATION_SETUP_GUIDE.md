# Claude Code Notification System - Setup Guide for Developers

## Overview
This notification system plays a sound and shows a macOS notification when long-running tasks complete, making it perfect for alerting you when Claude Code finishes processing.

## Quick Setup (2 minutes)

### Option 1: Automated Installation Script

```bash
# Run this one-liner to install everything
curl -sSL https://raw.githubusercontent.com/YOUR_REPO/main/install_notifications.sh | bash
```

### Option 2: Manual Installation

1. **Download the notification script**:
```bash
# Create a directory for the script
mkdir -p ~/scripts/claude-notify

# Download the script (or copy the content below)
curl -o ~/scripts/claude-notify/notify_complete.sh \
  https://raw.githubusercontent.com/YOUR_REPO/main/notify_complete.sh

# Make it executable
chmod +x ~/scripts/claude-notify/notify_complete.sh
```

2. **Add to your shell profile**:

For **zsh** users (default on macOS):
```bash
echo '
# Claude Code Notification System
alias notify="~/scripts/claude-notify/notify_complete.sh"
alias notify-done="~/scripts/claude-notify/notify_complete.sh done"
alias notify-build="~/scripts/claude-notify/notify_complete.sh build"
alias notify-error="~/scripts/claude-notify/notify_complete.sh error"
alias notify-test="~/scripts/claude-notify/notify_complete.sh test"

# Run any command with notification
run-notify() {
    "$@" && ~/scripts/claude-notify/notify_complete.sh done || ~/scripts/claude-notify/notify_complete.sh error
}
' >> ~/.zshrc

# Reload shell
source ~/.zshrc
```

For **bash** users:
```bash
# Same commands but use ~/.bash_profile instead of ~/.zshrc
```

3. **Test it**:
```bash
notify-test
```

## The Script Content

Save this as `notify_complete.sh`:

```bash
#!/bin/bash
# Claude Code Notification Script
# This script plays a sound and shows a notification when tasks are complete

# Function to show notification with sound
notify() {
    local message="${1:-Claude Code is ready for input}"
    local title="${2:-Claude Code}"
    local sound="${3:-Glass}"
    
    # Play system sound (runs in background with &)
    afplay /System/Library/Sounds/${sound}.aiff &
    
    # Show macOS notification
    osascript -e "display notification \"$message\" with title \"$title\" sound name \"$sound\""
}

# Function to list available sounds
list_sounds() {
    echo "Available system sounds:"
    ls /System/Library/Sounds/*.aiff | xargs -n 1 basename | sed 's/\.aiff$//'
}

# Main script logic
case "${1:-default}" in
    "list")
        list_sounds
        ;;
    "test")
        echo "Testing notification..."
        notify "Test notification!" "Claude Code Test" "Glass"
        ;;
    "done")
        notify "Task complete! Ready for input." "Claude Code" "Glass"
        ;;
    "build")
        notify "Build complete!" "Claude Code" "Hero"
        ;;
    "error")
        notify "Error occurred - check output" "Claude Code" "Basso"
        ;;
    "custom")
        notify "$2" "${3:-Claude Code}" "${4:-Glass}"
        ;;
    *)
        # Default notification
        notify "Ready for input" "Claude Code" "Glass"
        ;;
esac
```

## One-Click Installer Script

Create `install_notifications.sh` for easy distribution:

```bash
#!/bin/bash
# Claude Code Notification System Installer

set -e

INSTALL_DIR="$HOME/scripts/claude-notify"
SCRIPT_NAME="notify_complete.sh"
SCRIPT_PATH="$INSTALL_DIR/$SCRIPT_NAME"

echo "🔔 Installing Claude Code Notification System..."

# Create directory
mkdir -p "$INSTALL_DIR"

# Download or create the script
cat > "$SCRIPT_PATH" << 'EOF'
#!/bin/bash
# [Insert the notify_complete.sh content here]
EOF

# Make executable
chmod +x "$SCRIPT_PATH"

# Detect shell and update profile
if [[ "$SHELL" == */zsh ]]; then
    PROFILE="$HOME/.zshrc"
elif [[ "$SHELL" == */bash ]]; then
    PROFILE="$HOME/.bash_profile"
else
    PROFILE="$HOME/.profile"
fi

# Check if already installed
if grep -q "Claude Code Notification System" "$PROFILE" 2>/dev/null; then
    echo "✅ Aliases already installed in $PROFILE"
else
    echo "📝 Adding aliases to $PROFILE..."
    cat >> "$PROFILE" << EOF

# Claude Code Notification System
alias notify="$SCRIPT_PATH"
alias notify-done="$SCRIPT_PATH done"
alias notify-build="$SCRIPT_PATH build"
alias notify-error="$SCRIPT_PATH error"
alias notify-test="$SCRIPT_PATH test"

# Run any command with notification
run-notify() {
    "\$@" && $SCRIPT_PATH done || $SCRIPT_PATH error
}
EOF
fi

echo "✅ Installation complete!"
echo ""
echo "To activate now, run:"
echo "  source $PROFILE"
echo ""
echo "Or open a new terminal window."
echo ""
echo "Test with:"
echo "  notify-test"
echo ""
echo "Usage examples:"
echo "  notify-done                     # When Claude finishes"
echo "  run-notify ./gradlew build      # Auto-notify after command"
```

## Sharing via Git Repository

### Repository Structure
```
claude-notify/
├── README.md
├── install.sh
├── notify_complete.sh
└── examples/
    └── usage_examples.md
```

### README.md Template
```markdown
# Claude Code Notification System

Get audio notifications when Claude Code or long-running tasks complete.

## Installation

```bash
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/claude-notify/main/install.sh | bash
```

## Usage

- `notify-done` - Notify when Claude is ready
- `notify-test` - Test the system
- `run-notify <command>` - Run any command with notification

## Requirements

- macOS (uses system sounds and osascript)
- bash or zsh shell
```

## Sharing via Slack/Teams

Post this message:

```
🔔 Claude Code Notification System

Tired of missing when Claude finishes thinking? Get sound notifications!

**Quick Install:**
```
curl -sSL https://LINK_TO_SCRIPT | bash
```

**Or Manual Setup:**
1. Copy script: [link to gist]
2. Save to ~/scripts/
3. Add aliases to .zshrc
4. Run: notify-test

**Usage:**
- `notify-done` when Claude finishes
- `run-notify ./gradlew build` for commands

Works on macOS. Takes 2 minutes to setup!
```

## Sharing via Gist

1. Create a GitHub Gist with the script
2. Share this snippet:

```bash
# Install Claude notifications
curl -o ~/notify.sh https://gist.githubusercontent.com/YOUR_USERNAME/GIST_ID/raw/notify_complete.sh
chmod +x ~/notify.sh
echo 'alias notify-done="~/notify.sh done"' >> ~/.zshrc
source ~/.zshrc
```

## For Team Distribution

### 1. Add to Team Dotfiles Repository
```bash
team-dotfiles/
├── scripts/
│   └── notify_complete.sh
└── setup/
    └── install_notifications.sh
```

### 2. Add to Project Setup Script
```bash
# In your project's setup.sh
echo "Installing notification system..."
./tools/install_notifications.sh
```

### 3. Include in Developer Onboarding
Add to your onboarding checklist:
- [ ] Install Claude notification system: `make install-notifications`

## Cross-Platform Alternatives

### For Linux Users
```bash
# Replace 'afplay' with 'paplay' or 'aplay'
# Replace 'osascript' with 'notify-send'
notify-send "Claude Code" "Task complete!" -i dialog-information
paplay /usr/share/sounds/freedesktop/stereo/complete.oga
```

### For Windows Users (WSL)
```bash
# Use Windows PowerShell from WSL
powershell.exe -c "New-BurntToastNotification -Text 'Claude Code', 'Task complete!'"
```

## Troubleshooting

### Issue: "command not found: notify-done"
**Solution**: Run `source ~/.zshrc` or open a new terminal

### Issue: No sound plays
**Solution**: Check System Preferences > Sound > Sound Effects volume

### Issue: No notification appears
**Solution**: Enable notifications for Terminal in System Preferences > Notifications

## Customization

### Change Default Sound
Edit the script and change `Glass` to any of:
- Hero (success)
- Basso (error)
- Ping (simple)
- Submarine (deep)

### Custom Messages
```bash
notify custom "Your message" "Title" "Sound"
```

## License
MIT - Free to use and modify

---

**Questions?** Contact: [your-email@example.com]