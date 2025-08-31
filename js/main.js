// Modern JavaScript for Notes Landing Page
// Enhanced with professional animations and interactions

class NotesLandingPage {
    constructor() {
        this.init();
    }

    init() {
        this.setupEventListeners();
        this.initializeAnimations();
        this.setupScrollEffects();
        this.setupCopyFunctionality();
        this.setupPerformanceOptimizations();
        this.initializeGitHubStats();
        this.addConsoleWelcome();
    }

    setupEventListeners() {
        // Mobile Navigation Toggle
        const navToggle = document.querySelector('.nav-toggle');
        const navLinks = document.querySelector('.nav-links');
        
        if (navToggle && navLinks) {
            navToggle.addEventListener('click', () => {
                navLinks.classList.toggle('active');
                navToggle.classList.toggle('active');
                document.body.classList.toggle('nav-open');
            });
        }

        // Smooth Scrolling for Navigation Links
        document.querySelectorAll('a[href^="#"]').forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const targetId = link.getAttribute('href');
                const targetSection = document.querySelector(targetId);
                
                if (targetSection) {
                    const offsetTop = targetSection.offsetTop - 80;
                    window.scrollTo({
                        top: offsetTop,
                        behavior: 'smooth'
                    });
                    
                    // Close mobile menu if open
                    if (navLinks?.classList.contains('active')) {
                        navLinks.classList.remove('active');
                        navToggle?.classList.remove('active');
                        document.body.classList.remove('nav-open');
                    }
                }
            });
        });

        // Close mobile menu when clicking outside
        document.addEventListener('click', (e) => {
            if (!e.target.closest('.navbar') && navLinks?.classList.contains('active')) {
                navLinks.classList.remove('active');
                navToggle?.classList.remove('active');
                document.body.classList.remove('nav-open');
            }
        });
    }

    initializeAnimations() {
        // Typing Animation for Hero Title
        this.setupTypingAnimation();
        
        // Scroll-triggered animations
        this.setupScrollAnimations();
        
        // Parallax effects
        this.setupParallaxEffects();
        
        // Hover animations
        this.setupHoverAnimations();
    }

    setupTypingAnimation() {
        const heroTitle = document.querySelector('.hero-title');
        if (!heroTitle) return;

        const originalText = heroTitle.textContent;
        heroTitle.textContent = '';
        heroTitle.style.opacity = '1';

        let i = 0;
        const typeWriter = () => {
            if (i < originalText.length) {
                heroTitle.textContent += originalText.charAt(i);
                i++;
                setTimeout(typeWriter, 80);
            } else {
                // Add cursor blink effect
                this.addCursorBlink(heroTitle);
            }
        };

        // Start typing animation after a delay
        setTimeout(typeWriter, 500);
    }

    addCursorBlink(element) {
        const cursor = document.createElement('span');
        cursor.textContent = '|';
        cursor.style.color = 'var(--primary-color)';
        cursor.style.animation = 'blink 1s infinite';
        element.appendChild(cursor);

        // Add CSS for cursor blink
        if (!document.querySelector('#cursor-blink-style')) {
            const style = document.createElement('style');
            style.id = 'cursor-blink-style';
            style.textContent = `
                @keyframes blink {
                    0%, 50% { opacity: 1; }
                    51%, 100% { opacity: 0; }
                }
            `;
            document.head.appendChild(style);
        }
    }

    setupScrollAnimations() {
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate-in');
                    observer.unobserve(entry.target);
                }
            });
        }, observerOptions);

        // Observe elements for scroll animations
        const animateElements = document.querySelectorAll(
            '.feature-card, .arch-layer, .install-method, .gallery-item, .benefit'
        );
        
        animateElements.forEach(el => {
            el.classList.add('scroll-animate');
            observer.observe(el);
        });
    }

    setupParallaxEffects() {
        const hero = document.querySelector('.hero');
        if (!hero) return;

        window.addEventListener('scroll', () => {
            const scrolled = window.pageYOffset;
            const rate = scrolled * -0.3;
            hero.style.transform = `translateY(${rate}px)`;
        });
    }

    setupHoverAnimations() {
        // Feature cards hover effects
        document.querySelectorAll('.feature-card').forEach(card => {
            card.addEventListener('mouseenter', () => {
                card.style.transform = 'translateY(-8px) scale(1.02)';
                card.style.boxShadow = 'var(--shadow-xl)';
            });
            
            card.addEventListener('mouseleave', () => {
                card.style.transform = 'translateY(0) scale(1)';
                card.style.boxShadow = 'var(--shadow-md)';
            });
        });

        // Architecture layers hover effects
        document.querySelectorAll('.arch-layer').forEach(layer => {
            layer.addEventListener('mouseenter', () => {
                layer.style.transform = 'translateY(-4px)';
                layer.style.boxShadow = 'var(--shadow-xl)';
            });
            
            layer.addEventListener('mouseleave', () => {
                layer.style.transform = 'translateY(0)';
                layer.style.boxShadow = 'var(--shadow-md)';
            });
        });
    }

    setupScrollEffects() {
        const navbar = document.querySelector('.navbar');
        let lastScrollTop = 0;
        
        window.addEventListener('scroll', () => {
            const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
            
            // Add background when scrolled
            if (scrollTop > 50) {
                navbar?.classList.add('scrolled');
            } else {
                navbar?.classList.remove('scrolled');
            }
            
            // Hide/show navbar on scroll (optional)
            if (scrollTop > lastScrollTop && scrollTop > 100) {
                navbar.style.transform = 'translateY(-100%)';
            } else {
                navbar.style.transform = 'translateY(0)';
            }
            
            lastScrollTop = scrollTop;
        });
    }

    setupCopyFunctionality() {
        document.querySelectorAll('.copy-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.preventDefault();
                const codeBlock = btn.closest('.code-block');
                const code = codeBlock?.querySelector('code');
                
                if (code) {
                    this.copyToClipboard(code.textContent, btn);
                }
            });
        });
    }

    async copyToClipboard(text, button) {
        try {
            await navigator.clipboard.writeText(text);
            this.showCopySuccess(button);
        } catch (err) {
            // Fallback for older browsers
            this.fallbackCopyToClipboard(text, button);
        }
    }

    fallbackCopyToClipboard(text, button) {
        const textArea = document.createElement('textarea');
        textArea.value = text;
        textArea.style.position = 'fixed';
        textArea.style.left = '-999999px';
        textArea.style.top = '-999999px';
        document.body.appendChild(textArea);
        textArea.focus();
        textArea.select();
        
        try {
            document.execCommand('copy');
            this.showCopySuccess(button);
        } catch (err) {
            console.error('Fallback copy failed:', err);
        }
        
        document.body.removeChild(textArea);
    }

    showCopySuccess(button) {
        const icon = button.querySelector('i');
        const originalIcon = icon.className;
        
        icon.className = 'fas fa-check';
        button.style.color = 'var(--success-color)';
        
        setTimeout(() => {
            icon.className = originalIcon;
            button.style.color = '';
        }, 2000);
    }

    setupPerformanceOptimizations() {
        // Debounced scroll handler
        let scrollTimeout;
        window.addEventListener('scroll', () => {
            if (scrollTimeout) {
                clearTimeout(scrollTimeout);
            }
            scrollTimeout = setTimeout(() => {
                // Performance-intensive operations here
            }, 16); // ~60fps
        });

        // Lazy loading for images
        this.setupLazyLoading();
    }

    setupLazyLoading() {
        const images = document.querySelectorAll('img[data-src]');
        const imageObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.src = img.dataset.src;
                    img.classList.remove('lazy');
                    imageObserver.unobserve(img);
                }
            });
        });

        images.forEach(img => imageObserver.observe(img));
    }

    async initializeGitHubStats() {
        try {
            const response = await fetch('https://api.github.com/repos/mustafa-khann/notes');
            const data = await response.json();
            
            // Update star count if element exists
            const starElement = document.querySelector('.github-stars');
            if (starElement && data.stargazers_count) {
                starElement.textContent = this.formatNumber(data.stargazers_count);
            }
        } catch (error) {
            console.log('Could not fetch GitHub stats:', error);
        }
    }

    formatNumber(num) {
        if (num >= 1000) {
            return (num / 1000).toFixed(1) + 'k';
        }
        return num.toString();
    }

    addConsoleWelcome() {
        console.log(`
%c🎉 Welcome to Notes! %c

A fast, native Linux note-taking application built with Qt & C++17.

%cGitHub:%c https://github.com/mustafa-khann/notes
%cLicense:%c MIT

Built with ❤️ for the Linux community

        `, 
        'color: #3b82f6; font-size: 20px; font-weight: bold;',
        'color: #64748b; font-size: 14px;',
        'color: #10b981; font-weight: bold;',
        'color: #cbd5e1;',
        'color: #f59e0b; font-weight: bold;',
        'color: #cbd5e1;'
        );
    }
}

// Utility Functions
class Utils {
    static debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    }

    static throttle(func, limit) {
        let inThrottle;
        return function() {
            const args = arguments;
            const context = this;
            if (!inThrottle) {
                func.apply(context, args);
                inThrottle = true;
                setTimeout(() => inThrottle = false, limit);
            }
        };
    }
}

// Initialize the application
document.addEventListener('DOMContentLoaded', () => {
    new NotesLandingPage();
});

// Add CSS for enhanced animations
const enhancedStyles = `
    .scroll-animate {
        opacity: 0;
        transform: translateY(30px);
        transition: all 0.6s cubic-bezier(0.4, 0, 0.2, 1);
    }
    
    .scroll-animate.animate-in {
        opacity: 1;
        transform: translateY(0);
    }
    
    .navbar.scrolled {
        background: rgba(15, 23, 42, 0.98);
        backdrop-filter: blur(20px);
        box-shadow: var(--shadow-lg);
    }
    
    .nav-links.active {
        display: flex;
        position: absolute;
        top: 100%;
        left: 0;
        right: 0;
        background: var(--bg-secondary);
        flex-direction: column;
        padding: var(--space-6);
        border-top: 1px solid var(--border-primary);
        box-shadow: var(--shadow-xl);
        animation: slideDown 0.3s ease-out;
    }
    
    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .nav-toggle.active span:nth-child(1) {
        transform: rotate(45deg) translate(5px, 5px);
    }
    
    .nav-toggle.active span:nth-child(2) {
        opacity: 0;
    }
    
    .nav-toggle.active span:nth-child(3) {
        transform: rotate(-45deg) translate(7px, -6px);
    }
    
    .copy-btn {
        background: none;
        border: none;
        color: var(--text-secondary);
        cursor: pointer;
        padding: var(--space-2) var(--space-3);
        border-radius: var(--radius-sm);
        transition: all var(--transition-normal);
        margin-left: auto;
    }
    
    .copy-btn:hover {
        background: var(--bg-tertiary);
        color: var(--text-primary);
        transform: scale(1.05);
    }
    
    body.nav-open {
        overflow: hidden;
    }
    
    .feature-card,
    .arch-layer,
    .install-method,
    .gallery-item,
    .benefit {
        transition: all var(--transition-normal);
    }
    
    .hero-badge {
        animation: pulse 2s ease-in-out infinite;
    }
    
    @keyframes pulse {
        0%, 100% {
            transform: scale(1);
        }
        50% {
            transform: scale(1.05);
        }
    }
`;

// Inject enhanced styles
const styleSheet = document.createElement('style');
styleSheet.textContent = enhancedStyles;
document.head.appendChild(styleSheet);
