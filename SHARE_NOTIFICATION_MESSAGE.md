# Share This With Your Team

## Slack/Teams Message

```
🔔 Get Notified When Claude Code Finishes!

Hey team! I've set up a simple notification system that plays a sound when Claude Code (or any long-running task) completes. Super useful when you're waiting for builds or letting Claude work on something complex.

**Quick Install (30 seconds):**
1. Download: [attach install_notifications.sh]
2. Run: `bash install_notifications.sh`
3. Test: `notify-test`

**How to use:**
• Type `notify-done` or just `nd` when Claude is processing
• Use `run-notify ./gradlew build` for auto-notifications on any command

Works on macOS. Takes literally 30 seconds to set up! 

Let me know if you want help setting it up! 🚀
```

## Email Template

```
Subject: Claude Code Notification Tool - Never Miss When It's Done!

Hi [Team/Name],

I wanted to share a quick productivity tool I've been using with Claude Code. It's a simple notification system that plays a sound and shows a desktop alert when Claude finishes processing or when long builds complete.

**Why it's useful:**
- No more constantly checking if Claude is done thinking
- Get alerted when builds/tests finish
- Works with any command-line task

**Installation (takes 1 minute):**
1. Save the attached installer script
2. Run: bash install_notifications.sh
3. That's it!

**Usage:**
- Just type "notify-done" when you want to be alerted
- Or use "run-notify" before any command for automatic notifications

I've attached the installer script and documentation. It only works on macOS currently, but can be adapted for Linux.

Feel free to reach out if you have any questions!

Best,
[Your name]

Attachments:
- install_notifications.sh
- NOTIFICATION_SETUP_GUIDE.md
```

## GitHub README Section

```markdown
## 🔔 Notification System

This project includes a notification system for long-running tasks.

### Installation

```bash
bash install_notifications.sh
```

### Usage

Get notified when tasks complete:
```bash
# Manual notification
notify-done                    # When waiting for Claude

# Automatic notification
run-notify ./gradlew build     # After any command
run-notify ./gradlew test
```

### Commands

- `notify-done` (`nd`) - Task complete notification
- `notify-error` (`ne`) - Error notification  
- `notify-test` (`nt`) - Test the system
- `run-notify <cmd>` - Run any command with notification
```

## Gist Instructions

```markdown
# Quick Share via GitHub Gist

1. Go to https://gist.github.com
2. Create a new gist with these files:
   - notify_complete.sh
   - install_notifications.sh
   - README.md (with usage instructions)

3. Share the gist URL with your team

4. They can install with:
   ```bash
   curl -sSL https://gist.githubusercontent.com/YOUR_USERNAME/GIST_ID/raw/install_notifications.sh | bash
   ```
```

## For Company Wiki/Confluence

```markdown
# Claude Code Notification System

## Overview
Productivity tool that provides audio/visual notifications when Claude Code or terminal commands complete.

## Benefits
- ⏰ Save time by not constantly checking Claude's status
- 🎯 Stay focused on other tasks while waiting
- 📊 Know immediately when builds/tests finish

## Installation

### Automatic
```bash
curl -O https://COMPANY_URL/tools/install_notifications.sh
bash install_notifications.sh
```

### Manual
1. Copy script from: [internal repo link]
2. Add aliases to ~/.zshrc
3. Reload shell

## Usage Guide

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `notify-done` | Alert when ready | Claude is processing |
| `run-notify <cmd>` | Auto-notify | Long builds/tests |
| `notify-error` | Error alert | Something failed |
| `notify-test` | Test system | Initial setup |

## Troubleshooting

**No sound?**
- Check System Preferences > Sound

**Command not found?**
- Run: `source ~/.zshrc`
- Or open new terminal

## Support
Contact: [your-email] or #dev-tools Slack channel
```