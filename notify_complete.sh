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