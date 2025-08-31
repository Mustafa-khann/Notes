#!/bin/bash

# Notes Landing Page Deployment Script
# This script helps deploy the landing page to various hosting platforms

set -e

echo "🚀 Notes Landing Page Deployment Script"
echo "========================================"

# Check if we're in the right directory
if [ ! -f "index.html" ]; then
    echo "❌ Error: index.html not found. Please run this script from the landing-page directory."
    exit 1
fi

# Function to validate files
validate_files() {
    echo "📋 Validating files..."
    
    required_files=("index.html" "css/style.css" "js/main.js")
    
    for file in "${required_files[@]}"; do
        if [ ! -f "$file" ]; then
            echo "❌ Error: Required file $file not found"
            exit 1
        fi
    done
    
    echo "✅ All required files found"
}

# Function to optimize for production
optimize_for_production() {
    echo "⚡ Optimizing for production..."
    
    # Create optimized directory
    mkdir -p optimized
    
    # Copy files
    cp index.html optimized/
    cp -r css optimized/
    cp -r js optimized/
    cp -r images optimized/ 2>/dev/null || true
    
    # Add cache headers (for web servers that support .htaccess)
    cat > optimized/.htaccess << 'EOF'
# Cache static assets
<IfModule mod_expires.c>
    ExpiresActive on
    ExpiresByType text/css "access plus 1 year"
    ExpiresByType application/javascript "access plus 1 year"
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType image/jpg "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
    ExpiresByType image/gif "access plus 1 year"
    ExpiresByType image/svg+xml "access plus 1 year"
</IfModule>

# Enable compression
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/plain
    AddOutputFilterByType DEFLATE text/html
    AddOutputFilterByType DEFLATE text/xml
    AddOutputFilterByType DEFLATE text/css
    AddOutputFilterByType DEFLATE application/xml
    AddOutputFilterByType DEFLATE application/xhtml+xml
    AddOutputFilterByType DEFLATE application/rss+xml
    AddOutputFilterByType DEFLATE application/javascript
    AddOutputFilterByType DEFLATE application/x-javascript
</IfModule>
EOF
    
    echo "✅ Optimization complete. Files ready in 'optimized/' directory"
}

# Function to deploy to GitHub Pages
deploy_to_github_pages() {
    echo "🌐 Deploying to GitHub Pages..."
    
    if [ ! -d ".git" ]; then
        echo "❌ Error: Not a git repository. Please initialize git first."
        exit 1
    fi
    
    # Check if gh-pages branch exists
    if git show-ref --verify --quiet refs/heads/gh-pages; then
        git checkout gh-pages
    else
        git checkout -b gh-pages
    fi
    
    # Copy optimized files
    cp -r optimized/* .
    
    # Commit and push
    git add .
    git commit -m "Deploy landing page $(date)"
    git push origin gh-pages
    
    echo "✅ Deployed to GitHub Pages!"
    echo "🌍 Your site should be available at: https://[username].github.io/[repo-name]"
}

# Function to deploy to Netlify
deploy_to_netlify() {
    echo "🌐 Deploying to Netlify..."
    
    if ! command -v netlify &> /dev/null; then
        echo "❌ Error: Netlify CLI not found. Please install it first:"
        echo "   npm install -g netlify-cli"
        exit 1
    fi
    
    # Deploy optimized directory
    netlify deploy --dir=optimized --prod
    
    echo "✅ Deployed to Netlify!"
}

# Function to deploy to Vercel
deploy_to_vercel() {
    echo "🌐 Deploying to Vercel..."
    
    if ! command -v vercel &> /dev/null; then
        echo "❌ Error: Vercel CLI not found. Please install it first:"
        echo "   npm install -g vercel"
        exit 1
    fi
    
    # Deploy optimized directory
    vercel optimized --prod
    
    echo "✅ Deployed to Vercel!"
}

# Function to create a simple server for testing
create_test_server() {
    echo "🧪 Creating test server..."
    
    cat > test_server.py << 'EOF'
#!/usr/bin/env python3
import http.server
import socketserver
import os

PORT = 8000

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
        self.send_header('Pragma', 'no-cache')
        self.send_header('Expires', '0')
        super().end_headers()

os.chdir('optimized')
with socketserver.TCPServer(("", PORT), MyHTTPRequestHandler) as httpd:
    print(f"🌐 Test server running at http://localhost:{PORT}")
    print("Press Ctrl+C to stop")
    httpd.serve_forever()
EOF
    
    chmod +x test_server.py
    echo "✅ Test server created. Run './test_server.py' to start"
}

# Main menu
show_menu() {
    echo ""
    echo "Choose an option:"
    echo "1) Validate files"
    echo "2) Optimize for production"
    echo "3) Create test server"
    echo "4) Deploy to GitHub Pages"
    echo "5) Deploy to Netlify"
    echo "6) Deploy to Vercel"
    echo "7) Full deployment (validate + optimize + test server)"
    echo "8) Exit"
    echo ""
    read -p "Enter your choice (1-8): " choice
}

# Main execution
main() {
    validate_files
    
    while true; do
        show_menu
        
        case $choice in
            1)
                validate_files
                ;;
            2)
                optimize_for_production
                ;;
            3)
                create_test_server
                ;;
            4)
                optimize_for_production
                deploy_to_github_pages
                ;;
            5)
                optimize_for_production
                deploy_to_netlify
                ;;
            6)
                optimize_for_production
                deploy_to_vercel
                ;;
            7)
                validate_files
                optimize_for_production
                create_test_server
                echo "🎉 Full deployment setup complete!"
                echo "Run './test_server.py' to start the test server"
                ;;
            8)
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
