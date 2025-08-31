#!/bin/bash

# Notes Landing Page Update Script
# This script helps manage updates between the main branch and gh-pages branch

set -e

echo "🚀 Notes Landing Page Update Script"
echo "==================================="

# Function to update landing page from main branch
update_from_main() {
    echo "📝 Updating landing page from main branch..."
    
    # Check if we're on main branch
    if [ "$(git branch --show-current)" != "main" ]; then
        echo "❌ Error: Please run this script from the main branch"
        exit 1
    fi
    
    # Create or update landing-page directory
    if [ -d "landing-page" ]; then
        echo "📁 Updating existing landing-page directory..."
    else
        echo "📁 Creating landing-page directory..."
        mkdir -p landing-page
    fi
    
    # Copy landing page files
    cp -r landing-page/* . 2>/dev/null || true
    cp -r landing-page/.* . 2>/dev/null || true
    
    # Switch to gh-pages branch
    git checkout gh-pages
    
    # Move files to root
    mv landing-page/* . 2>/dev/null || true
    mv landing-page/.* . 2>/dev/null || true
    rmdir landing-page 2>/dev/null || true
    
    # Remove application files
    git rm -r src/ resources/ debian/ CMakeLists.txt 2>/dev/null || true
    rm -rf obj-x86_64-linux-gnu/ build/ notes_0.1.0-1_amd64.deb 2>/dev/null || true
    
    # Add and commit changes
    git add .
    git commit -m "Update landing page $(date)"
    
    echo "✅ Landing page updated and committed to gh-pages branch"
    echo "🌐 Push to GitHub Pages: git push origin gh-pages"
}

# Function to push to GitHub Pages
push_to_github_pages() {
    echo "🌐 Pushing to GitHub Pages..."
    
    if [ "$(git branch --show-current)" != "gh-pages" ]; then
        echo "❌ Error: Please run this script from the gh-pages branch"
        exit 1
    fi
    
    git push origin gh-pages
    
    echo "✅ Pushed to GitHub Pages!"
    echo "🌍 Your site should be available at: https://mustafa-khann.github.io/notes"
}

# Function to switch to main branch
switch_to_main() {
    echo "🔄 Switching to main branch..."
    git checkout main
    echo "✅ Switched to main branch"
}

# Function to switch to gh-pages branch
switch_to_gh_pages() {
    echo "🔄 Switching to gh-pages branch..."
    git checkout gh-pages
    echo "✅ Switched to gh-pages branch"
}

# Function to show status
show_status() {
    echo "📊 Current Status:"
    echo "Branch: $(git branch --show-current)"
    echo "Status: $(git status --porcelain | wc -l) changes"
    
    if [ "$(git branch --show-current)" = "gh-pages" ]; then
        echo "🌐 This is the GitHub Pages branch"
        echo "Files in root:"
        ls -la | grep -E "\.(html|css|js|md)$"
    else
        echo "📝 This is the main development branch"
        if [ -d "landing-page" ]; then
            echo "📁 Landing page directory exists"
        else
            echo "📁 No landing page directory found"
        fi
    fi
}

# Main menu
show_menu() {
    echo ""
    echo "Choose an option:"
    echo "1) Show current status"
    echo "2) Switch to main branch"
    echo "3) Switch to gh-pages branch"
    echo "4) Update landing page from main"
    echo "5) Push to GitHub Pages"
    echo "6) Full update (update + push)"
    echo "7) Exit"
    echo ""
    read -p "Enter your choice (1-7): " choice
}

# Main execution
main() {
    show_status
    
    while true; do
        show_menu
        
        case $choice in
            1)
                show_status
                ;;
            2)
                switch_to_main
                ;;
            3)
                switch_to_gh_pages
                ;;
            4)
                update_from_main
                ;;
            5)
                push_to_github_pages
                ;;
            6)
                update_from_main
                push_to_github_pages
                ;;
            7)
                echo "👋 Goodbye!"
                exit 0
                ;;
            *)
                echo "❌ Invalid choice. Please try again."
                ;;
        esac
        
        echo ""
        read -p "Press Enter to continue..."
    done
}

# Run main function
main
