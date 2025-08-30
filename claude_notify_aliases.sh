#!/bin/bash
# Claude Code Notification Aliases
# Source this file in your shell: source claude_notify_aliases.sh

# Path to the notification script
NOTIFY_SCRIPT="$(pwd)/notify_complete.sh"

# Alias for quick notification
alias notify="$NOTIFY_SCRIPT"
alias notify-done="$NOTIFY_SCRIPT done"
alias notify-error="$NOTIFY_SCRIPT error"
alias notify-build="$NOTIFY_SCRIPT build"
alias notify-test="$NOTIFY_SCRIPT test"

# Aliases that combine common commands with notifications
alias gradle-build="./gradlew build && $NOTIFY_SCRIPT build || $NOTIFY_SCRIPT error"
alias gradle-clean="./gradlew clean && $NOTIFY_SCRIPT done || $NOTIFY_SCRIPT error"
alias gradle-test="./gradlew test && $NOTIFY_SCRIPT done || $NOTIFY_SCRIPT error"

# Function to run any command with notification
run-notify() {
    "$@" && $NOTIFY_SCRIPT done || $NOTIFY_SCRIPT error
}

echo "✅ Claude notification aliases loaded!"
echo ""
echo "Available commands:"
echo "  notify         - Show default notification"
echo "  notify-done    - Show 'task complete' notification"
echo "  notify-error   - Show error notification"
echo "  notify-build   - Show build complete notification"
echo "  notify-test    - Test the notification system"
echo ""
echo "Gradle with notifications:"
echo "  gradle-build   - Run build with notification"
echo "  gradle-clean   - Run clean with notification"
echo "  gradle-test    - Run tests with notification"
echo ""
echo "Run any command with notification:"
echo "  run-notify <command>  - Runs command and notifies when done"
echo ""
echo "Examples:"
echo "  run-notify ./gradlew assembleDebug"
echo "  run-notify sleep 5"