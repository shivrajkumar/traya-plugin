#!/bin/bash
# Notification script for Claude Code hooks
# Usage: notify.sh <event_type> [context]
#
# This script provides desktop notifications and terminal bells for Claude Code operations.
# Supports macOS (osascript) and Linux (notify-send) with terminal bell fallback.

EVENT_TYPE="$1"
CONTEXT="${2:-Unknown}"
LOG_FILE=".claude/hooks/notify.log"

# Function to detect the current platform
detect_platform() {
    if command -v osascript >/dev/null 2>&1; then
        echo "macos"
    elif command -v notify-send >/dev/null 2>&1; then
        echo "linux"
    else
        echo "unknown"
    fi
}

# Function to send macOS notification
send_macos_notification() {
    local title="$1"
    local message="$2"

    osascript -e "display notification \"$message\" with title \"$title\"" 2>>"$LOG_FILE" || {
        echo "[$(date)] Failed to send macOS notification: $title - $message" >> "$LOG_FILE"
        return 1
    }
}

# Function to send Linux notification
send_linux_notification() {
    local title="$1"
    local message="$2"

    notify-send "$title" "$message" 2>>"$LOG_FILE" || {
        echo "[$(date)] Failed to send Linux notification: $title - $message" >> "$LOG_FILE"
        return 1
    }
}

# Function to send terminal bell
send_terminal_bell() {
    printf '\a' 2>/dev/null || {
        echo "[$(date)] Failed to send terminal bell" >> "$LOG_FILE"
        return 1
    }
}

# Function to send notification based on platform
send_notification() {
    local title="$1"
    local message="$2"
    local platform

    platform=$(detect_platform)

    case "$platform" in
        macos)
            send_macos_notification "$title" "$message"
            ;;
        linux)
            send_linux_notification "$title" "$message"
            ;;
        *)
            # Fallback to terminal bell if no notification system available
            send_terminal_bell
            echo "[$(date)] No notification system found, using terminal bell. Message: $title - $message" >> "$LOG_FILE"
            ;;
    esac
}

# Main logic - handle different event types
case "$EVENT_TYPE" in
    PostToolUse)
        send_notification "Claude Code - Tool Completed" "Tool: $CONTEXT finished"
        ;;
    PermissionRequest)
        send_notification "Claude Code - User Input Required" "Permission needed for: $CONTEXT"
        send_terminal_bell
        ;;
    Stop)
        send_notification "Claude Code" "Operation completed"
        ;;
    SubagentStop)
        send_notification "Claude Code - Subagent Completed" "Task: $CONTEXT finished"
        ;;
    *)
        echo "[$(date)] Unknown event type: $EVENT_TYPE" >> "$LOG_FILE"
        ;;
esac

# Exit silently to avoid interrupting Claude operations
exit 0
