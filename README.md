# 🔔 Claude Code Notifier

A lightweight macOS notification system that alerts you when Claude Code (or any long-running terminal task) completes. Never miss when your AI assistant finishes thinking or when your builds are done!

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-macOS-lightgrey.svg)
![Shell](https://img.shields.io/badge/shell-bash%20%7C%20zsh-green.svg)
![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)

## ✨ Features

- 🎵 **Audio Notifications** - Plays system sounds when tasks complete
- 📱 **Desktop Alerts** - Native macOS notifications
- 🚀 **Quick Setup** - One-line installation
- ⚡ **Lightweight** - Pure bash, no dependencies
- 🎨 **Customizable** - Multiple sounds and message options
- 🔧 **Flexible** - Works with any command-line tool
- 💻 **Shell Agnostic** - Supports bash and zsh

## 🎬 Demo

```bash
# Get notified when Claude finishes thinking
$ notify-done
🔔 *chime* "Claude Code: Task complete! Ready for input."

# Auto-notify after any command
$ run-notify ./gradlew build
Building... Done!
🔔 *hero sound* "Claude Code: Build complete!"
```

## 🚀 Quick Start

### One-Line Installation

```bash
curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/claude-notifier/main/install_notifications.sh | bash
```

### Manual Installation

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/claude-notifier.git
cd claude-notifier
```

2. Run the installer:
```bash
bash install_notifications.sh
```

3. Reload your shell:
```bash
source ~/.zshrc  # or ~/.bashrc
```

4. Test it:
```bash
notify-test
```

## 📖 Usage

### Basic Commands

| Command | Description | Use Case |
|---------|-------------|----------|
| `notify-done` | Task complete notification | When Claude finishes processing |
| `notify-test` | Test the system | Verify installation |
| `notify-error` | Error notification | When something goes wrong |
| `notify-build` | Build complete | After compilation |
| `run-notify <cmd>` | Auto-notify any command | Wrap any long-running task |

### Short Aliases

For even quicker access:
- `nd` → `notify-done`
- `ne` → `notify-error`
- `nt` → `notify-test`

### Examples

```bash
# Quick notification when Claude is done
nd

# Get notified after a build
run-notify ./gradlew build

# Custom notification
notify custom "Deploy complete!" "Success" "Hero"

# Chain multiple commands
npm install && npm test && notify-done

# Use with conditional execution
make || notify-error
```

## 🎨 Customization

### Available Sounds

The script uses macOS system sounds. Available options:

| Sound | Best For | Description |
|-------|----------|-------------|
| `Glass` | Default | Pleasant chime |
| `Hero` | Success | Triumphant sound |
| `Basso` | Errors | Low warning tone |
| `Ping` | Attention | Simple ping |
| `Pop` | Quick tasks | Soft pop |
| `Submarine` | Deep focus | Deep submarine ping |

List all available sounds:
```bash
notify list
```

### Custom Messages

```bash
# Custom message with specific sound
notify custom "Your message" "Title" "Sound"

# Examples
notify custom "Tests passed!" "CI/CD" "Hero"
notify custom "Merge conflict" "Git" "Basso"
```

## 🤝 Integration Ideas

### With Claude Code

```bash
# Add to your workflow when using Claude
# 1. Start a long Claude task
# 2. Switch to terminal
# 3. Type: nd
# 4. Get notified when ready!
```

### With Build Tools

```bash
# Gradle
alias gradle-notify='run-notify ./gradlew'
gradle-notify build

# NPM
alias npm-notify='run-notify npm'
npm-notify install

# Make
alias make-notify='run-notify make'
make-notify all
```

### With Git Hooks

Add to `.git/hooks/post-commit`:
```bash
#!/bin/bash
notify custom "Commit successful" "Git" "Pop"
```

## 🛠️ Advanced Usage

### Conditional Notifications

```bash
# Notify only on success
command && notify-done

# Notify only on failure
command || notify-error

# Always notify with appropriate message
command && notify-done || notify-error
```

### Time-Delayed Notifications

```bash
# Pomodoro timer
run-notify sleep 1500  # 25 minutes

# Meeting reminder
(sleep 3300 && notify custom "Meeting in 5 minutes!" "Calendar" "Ping") &
```

### Integration with Scripts

```bash
#!/bin/bash
# my-long-script.sh

echo "Starting process..."
# ... long running tasks ...

# Notify on completion
source ~/scripts/claude-notify/notify_complete.sh
notify done
```

## 📝 Installation Details

The installer:
1. Creates `~/scripts/claude-notify/` directory
2. Installs the notification script
3. Adds aliases to your shell profile (`.zshrc` or `.bashrc`)
4. Makes commands available in all future terminal sessions

### What Gets Installed

```
~/
├── scripts/
│   └── claude-notify/
│       └── notify_complete.sh
└── .zshrc (or .bashrc)
    └── # Added aliases
```

## 🔧 Troubleshooting

### Command not found

```bash
# Reload your shell configuration
source ~/.zshrc  # or ~/.bashrc

# Or open a new terminal window
```

### No sound playing

1. Check System Preferences → Sound → Sound Effects volume
2. Ensure "Play sound effects through" is set correctly
3. Test with: `afplay /System/Library/Sounds/Glass.aiff`

### No notifications appearing

1. System Preferences → Notifications & Focus
2. Allow notifications from Terminal
3. Check Do Not Disturb is off

### Testing individual components

```bash
# Test sound only
afplay /System/Library/Sounds/Glass.aiff

# Test notification only
osascript -e 'display notification "Test" with title "Test"'

# Test the script directly
~/scripts/claude-notify/notify_complete.sh test
```

## 🤝 Contributing

Contributions are welcome! Feel free to:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m '✨ Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Ideas for Contributions

- 🐧 Linux support (using `notify-send` and `paplay`)
- 🪟 Windows support (PowerShell notifications)
- 🎨 More notification styles/themes
- 📊 Statistics tracking (how many notifications sent)
- ⚙️ Configuration file support
- 🌐 Web dashboard
- 📱 Mobile app notifications
- 🔌 IDE plugins

## 📚 Related Projects

- [terminal-notifier](https://github.com/julienXX/terminal-notifier) - Send macOS notifications from terminal
- [noti](https://github.com/variadico/noti) - Monitor a process and trigger notifications
- [ntfy](https://github.com/dschep/ntfy) - Cross-platform notification tool

## 📄 License

This project is licensed under the MIT License - see below:

```
MIT License

Copyright (c) 2024 [Your Name]

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
```

## 🙏 Acknowledgments

- Inspired by the need to know when [Claude](https://claude.ai) finishes processing
- Built for developers who multitask while waiting for AI responses
- Uses native macOS notification system and sounds

## 📊 Stats

![Stars](https://img.shields.io/github/stars/YOUR_USERNAME/claude-notifier?style=social)
![Forks](https://img.shields.io/github/forks/YOUR_USERNAME/claude-notifier?style=social)
![Watchers](https://img.shields.io/github/watchers/YOUR_USERNAME/claude-notifier?style=social)

## 🗺️ Roadmap

- [ ] Linux support
- [ ] Windows support
- [ ] Custom sound packs
- [ ] Integration with more AI tools
- [ ] Browser extension
- [ ] Slack/Discord webhooks
- [ ] Configuration GUI

## 💬 Support

- 🐛 [Report bugs](https://github.com/YOUR_USERNAME/claude-notifier/issues)
- 💡 [Request features](https://github.com/YOUR_USERNAME/claude-notifier/issues)
- 💬 [Discussions](https://github.com/YOUR_USERNAME/claude-notifier/discussions)
- ⭐ Star this repo if you find it useful!

## 🚀 Why This Exists

When working with Claude Code or running long builds, it's easy to get distracted and forget to check back. This simple tool solves that problem by alerting you the moment your task completes, helping you maintain flow while staying productive.

Perfect for:
- 🤖 AI-assisted coding sessions
- 🏗️ Long build processes
- 🧪 Test suite runs
- 📦 Package installations
- 🔄 CI/CD pipelines
- ⏰ Any time-consuming terminal task

---

**Made with ❤️ for developers who value their time and focus**

*If this tool saves you time, consider [buying me a coffee]([https://www.buymeacoffee.com/YOUR_USERNAME](https://buymeacoffee.com/abunur)) ☕*
