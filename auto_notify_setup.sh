#!/bin/bash
# Automatic Claude Command Notification Setup
# This script sets up automatic notifications for all Claude-related commands

NOTIFY_SCRIPT="/Users/abunur/workspace/claude/claude-notifier/notify_complete.sh"

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🔔 Setting up Automatic Claude Notifications${NC}"
echo "============================================"
echo ""

# Detect shell
if [[ "$SHELL" == */zsh ]]; then
    PROFILE="$HOME/.zshrc"
    SHELL_NAME="zsh"
elif [[ "$SHELL" == */bash ]]; then
    PROFILE="$HOME/.bash_profile"
    SHELL_NAME="bash"
else
    PROFILE="$HOME/.profile"
    SHELL_NAME="unknown"
fi

# Create the auto-notification configuration
cat > /tmp/claude_auto_notify.sh << 'EOF'
# ======================================
# Claude Automatic Notification System
# ======================================

# Store the original notify script path
CLAUDE_NOTIFY_SCRIPT="/Users/abunur/workspace/claude/claude-notifier/notify_complete.sh"

# List of commands that should trigger notifications
CLAUDE_COMMANDS=(
    "gradle"
    "gradlew"
    "./gradlew"
    "npm"
    "yarn"
    "make"
    "mvn"
    "cargo"
    "go build"
    "python"
    "pytest"
    "git clone"
    "git pull"
    "git push"
    "docker build"
    "docker-compose"
    "kubectl"
)

# Function to check if a command should be auto-notified
should_notify() {
    local cmd="$1"
    
    # Check for gradle/gradlew specifically (most common with Claude)
    if [[ "$cmd" == *"gradlew"* ]] || [[ "$cmd" == *"gradle"* ]]; then
        return 0
    fi
    
    # Check for other build/long-running commands
    for pattern in "${CLAUDE_COMMANDS[@]}"; do
        if [[ "$cmd" == *"$pattern"* ]]; then
            return 0
        fi
    done
    
    # Check if command takes longer than 5 seconds (configurable)
    return 1
}

# Override the command execution to add notifications
if [[ "$SHELL" == */zsh ]]; then
    # For ZSH - use preexec and precmd hooks
    
    # Track command start time
    claude_cmd_start_time=""
    claude_current_cmd=""
    
    # Before command execution
    preexec() {
        claude_cmd_start_time=$SECONDS
        claude_current_cmd="$1"
    }
    
    # After command execution
    precmd() {
        local last_exit_code=$?
        
        # Only notify if we have a start time and command
        if [[ -n "$claude_cmd_start_time" ]] && [[ -n "$claude_current_cmd" ]]; then
            local elapsed=$((SECONDS - claude_cmd_start_time))
            
            # Notify if command took more than 5 seconds OR is in our list
            if [[ $elapsed -gt 5 ]] || should_notify "$claude_current_cmd"; then
                if [[ $last_exit_code -eq 0 ]]; then
                    $CLAUDE_NOTIFY_SCRIPT done >/dev/null 2>&1 &
                else
                    $CLAUDE_NOTIFY_SCRIPT error >/dev/null 2>&1 &
                fi
            fi
            
            # Reset for next command
            claude_cmd_start_time=""
            claude_current_cmd=""
        fi
    }
    
elif [[ "$SHELL" == */bash ]]; then
    # For Bash - use PROMPT_COMMAND
    
    # Function to notify after command
    claude_notify_after_command() {
        local last_exit_code=$?
        local last_cmd=$(history 1 | sed 's/^[ ]*[0-9]*[ ]*//')
        
        # Check if the last command should trigger notification
        if should_notify "$last_cmd"; then
            if [[ $last_exit_code -eq 0 ]]; then
                $CLAUDE_NOTIFY_SCRIPT done >/dev/null 2>&1 &
            else
                $CLAUDE_NOTIFY_SCRIPT error >/dev/null 2>&1 &
            fi
        fi
    }
    
    # Add to PROMPT_COMMAND
    PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}claude_notify_after_command"
fi

# Function to enable/disable auto notifications
claude_notify() {
    case "$1" in
        on|enable)
            export CLAUDE_AUTO_NOTIFY=1
            echo "🔔 Claude auto-notifications ENABLED"
            ;;
        off|disable)
            export CLAUDE_AUTO_NOTIFY=0
            echo "🔕 Claude auto-notifications DISABLED"
            ;;
        status)
            if [[ "$CLAUDE_AUTO_NOTIFY" == "1" ]]; then
                echo "🔔 Claude auto-notifications are ENABLED"
            else
                echo "🔕 Claude auto-notifications are DISABLED"
            fi
            ;;
        test)
            echo "Testing auto-notification in 3 seconds..."
            sleep 3
            ;;
        *)
            echo "Usage: claude_notify [on|off|status|test]"
            echo "  on/enable    - Enable automatic notifications"
            echo "  off/disable  - Disable automatic notifications"
            echo "  status       - Check current status"
            echo "  test         - Test with 3-second sleep"
            ;;
    esac
}

# Wrapper functions for common commands with automatic notification
gradle() {
    command gradle "$@"
    local exit_code=$?
    [[ $exit_code -eq 0 ]] && $CLAUDE_NOTIFY_SCRIPT build >/dev/null 2>&1 & || $CLAUDE_NOTIFY_SCRIPT error >/dev/null 2>&1 &
    return $exit_code
}

# Alias for gradlew
alias gradlew='(command ./gradlew "$@"; [[ $? -eq 0 ]] && '$CLAUDE_NOTIFY_SCRIPT' build >/dev/null 2>&1 & || '$CLAUDE_NOTIFY_SCRIPT' error >/dev/null 2>&1 &)'

# Enable by default
export CLAUDE_AUTO_NOTIFY=1

echo "🔔 Claude Auto-Notify: Enabled (type 'claude_notify off' to disable)"
EOF

# Check if already installed
if grep -q "Claude Automatic Notification System" "$PROFILE" 2>/dev/null; then
    echo -e "${YELLOW}⚠️  Auto-notification already installed${NC}"
    echo "Updating configuration..."
    # Remove old configuration
    sed -i.bak '/# ======================================/,/# ======================================.*Claude Automatic Notification System/d' "$PROFILE"
fi

# Append to profile
echo -e "${BLUE}📝 Adding auto-notification to $PROFILE...${NC}"
echo "" >> "$PROFILE"
cat /tmp/claude_auto_notify.sh >> "$PROFILE"

# Clean up
rm /tmp/claude_auto_notify.sh

echo -e "${GREEN}✅ Installation complete!${NC}"
echo ""
echo -e "${BLUE}🎯 Automatic Notifications Set Up For:${NC}"
echo "  • gradle / ./gradlew commands"
echo "  • npm / yarn commands"
echo "  • git operations (clone, pull, push)"
echo "  • Any command taking > 5 seconds"
echo ""
echo -e "${BLUE}📋 Commands:${NC}"
echo "  claude_notify on     - Enable auto-notifications"
echo "  claude_notify off    - Disable auto-notifications"
echo "  claude_notify status - Check current status"
echo "  claude_notify test   - Test the system"
echo ""
echo -e "${YELLOW}⚡ To activate now:${NC}"
echo "  source $PROFILE"
echo ""
echo -e "${GREEN}Now all your gradle/build commands will automatically notify you!${NC}"