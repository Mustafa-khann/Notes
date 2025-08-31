#!/bin/bash

# GitHub Release Creation Script for Notes
# This script helps create a GitHub release with the .deb package

set -e

echo "🚀 GitHub Release Creation Script"
echo "================================="

# Configuration
REPO="mustafa-khann/notes"
VERSION="v0.1.0"
TAG="v0.1.0"
RELEASE_TITLE="Notes v0.1.0 - Initial Release"
DEB_FILE="notes_0.1.0-1_amd64.deb"

# Check if .deb file exists
if [ ! -f "$DEB_FILE" ]; then
    echo "❌ Error: $DEB_FILE not found!"
    echo "Please build the .deb package first:"
    echo "  dpkg-buildpackage -b -us -uc"
    exit 1
fi

echo "✅ Found $DEB_FILE"

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ Error: GitHub CLI (gh) not found!"
    echo "Please install it first:"
    echo "  # Ubuntu/Debian:"
    echo "  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg"
    echo "  echo \"deb [arch=\$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main\" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null"
    echo "  sudo apt update"
    echo "  sudo apt install gh"
    echo ""
    echo "  # Then authenticate:"
    echo "  gh auth login"
    exit 1
fi

echo "✅ GitHub CLI found"

# Check if authenticated
if ! gh auth status &> /dev/null; then
    echo "❌ Error: Not authenticated with GitHub!"
    echo "Please run: gh auth login"
    exit 1
fi

echo "✅ Authenticated with GitHub"

# Create release description
cat > release_description.md << 'EOF'
## Notes v0.1.0 - Initial Release

A fast, native Linux note-taking application built with Qt and C++17.

### ✨ Features

- **3-Pane Layout**: Folders, notes list, and plain text editor
- **Auto-Save**: Automatic saving with configurable intervals
- **SQLite Database**: Persistent storage with automatic data persistence
- **Drag & Drop**: Move notes between folders with visual feedback
- **Dark Theme**: Modern dark UI with Apple Notes-inspired design
- **Plain Text Editor**: Simple, distraction-free text editing
- **System Integration**: Native Linux system integration

### 🚀 Installation

#### Quick Install (.deb package)

```bash
# Download the package
wget https://github.com/mustafa-khann/notes/releases/download/v0.1.0/notes_0.1.0-1_amd64.deb

# Install the package
sudo dpkg -i notes_0.1.0-1_amd64.deb

# Fix any dependencies
sudo apt-get install -f
```

#### Build from Source

```bash
# Clone the repository
git clone https://github.com/mustafa-khann/notes.git
cd notes

# Install dependencies
sudo apt-get install qt6-base-dev cmake build-essential

# Build and install
mkdir build && cd build
cmake ..
make
sudo make install
```

### 📦 What's Included

- **Binary**: `/usr/bin/notes` - The main application executable
- **Desktop Entry**: Application launcher in system menu
- **Icons**: Multiple resolution icons
- **Dependencies**: Automatically handles Qt and SQLite dependencies

### 🎯 Usage

After installation:
- Launch from system menu: Search for "Notes"
- Run from terminal: `notes`
- Create desktop shortcut if desired

### 🔧 System Requirements

- Ubuntu 20.04+ / Debian 11+
- Qt 6 (or Qt 5.15+)
- SQLite 3
- 50MB disk space

### 📝 Changelog

- Initial release with core note-taking functionality
- 3-pane layout with folder organization
- Auto-save with configurable intervals
- Drag & drop support
- Dark theme UI
- Plain text editor
- System-wide installation via .deb package

---

**Built with ❤️ for the Linux community**
EOF

echo "📝 Created release description"

# Create the release
echo "🌐 Creating GitHub release..."
gh release create "$TAG" \
    --title "$RELEASE_TITLE" \
    --notes-file release_description.md \
    "$DEB_FILE"

echo "✅ Release created successfully!"
echo ""
echo "🌍 Your release is now available at:"
echo "https://github.com/$REPO/releases/tag/$TAG"
echo ""
echo "📦 Download link:"
echo "https://github.com/$REPO/releases/download/$TAG/$DEB_FILE"
echo ""
echo "🔗 Update your landing page with this download link!"

# Clean up
rm release_description.md

echo ""
echo "🎉 Release creation complete!"
