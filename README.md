# Notes - Landing Page

This is the landing page for **Notes**, a fast, native Linux note-taking application built with Qt and C++17.

🌐 **Live Site**: [https://mustafa-khann.github.io/notes](https://mustafa-khann.github.io/notes)

## About Notes

Notes is a lightweight, distraction-free note-taking application designed specifically for Linux users who value speed and simplicity. Built with native C++ and Qt, it provides a fast, responsive experience without the bloat of Electron-based applications.

### Key Features

- ⚡ **Lightning Fast**: Native C++ performance with zero Electron bloat
- 💾 **Auto-Save**: Never lose your work with automatic saving
- 📁 **3-Pane Layout**: Organized workflow with folders, notes list, and editor
- 🖱️ **Drag & Drop**: Intuitive organization with drag and drop support
- 📝 **Plain Text**: Distraction-free editing with plain text format
- 🌙 **Dark Theme**: Easy on the eyes with a beautiful dark theme
- 🔧 **System Integration**: Native Linux system integration

### Tech Stack

- **Frontend**: Qt 6, C++17
- **Database**: SQLite
- **Build System**: CMake
- **Platform**: Linux (Ubuntu/Debian)

## Installation

### Quick Install (.deb package)

```bash
# Download the latest release
wget https://github.com/mustafa-khann/notes/releases/latest/download/notes_0.1.0-1_amd64.deb

# Install the package
sudo dpkg -i notes_0.1.0-1_amd64.deb

# Fix any dependencies
sudo apt-get install -f
```

### Build from Source

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

## Development

For the main application source code, please visit the [main branch](https://github.com/mustafa-khann/notes/tree/main).

This branch contains only the landing page files for GitHub Pages deployment.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/mustafa-khann/notes/blob/main/LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Links

- **GitHub Repository**: [https://github.com/mustafa-khann/notes](https://github.com/mustafa-khann/notes)
- **Issues**: [https://github.com/mustafa-khann/notes/issues](https://github.com/mustafa-khann/notes/issues)
- **Releases**: [https://github.com/mustafa-khann/notes/releases](https://github.com/mustafa-khann/notes/releases)

---

**Built with ❤️ for the Linux community**
