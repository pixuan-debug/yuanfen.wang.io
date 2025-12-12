// 网站加载优化脚本
// 这个脚本可以帮助优化网站的加载速度

// 1. 关键资源优化 - 减少不必要的预加载
(function() {
    // 只预连接最重要的域名
    const preconnectDomains = [
        'https://fonts.googleapis.com',
        'https://cdn.jsdelivr.net'
    ];
    
    preconnectDomains.forEach(domain => {
        const preconnect = document.createElement('link');
        preconnect.rel = 'preconnect';
        preconnect.href = domain;
        preconnect.crossorigin = 'anonymous';
        document.head.appendChild(preconnect);
    });
})();

// 2. 延迟加载非关键资源
(function() {
    // 页面加载完成后再加载非关键资源
    function loadNonCriticalResources() {
        // 延迟加载Font Awesome图标
        const fontAwesome = document.createElement('link');
        fontAwesome.rel = 'stylesheet';
        fontAwesome.href = 'https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css';
        fontAwesome.media = 'print';
        fontAwesome.onload = function() {
            this.media = 'all';
        };
        document.head.appendChild(fontAwesome);
    }

    // 只有当页面完全加载后才加载非关键资源
    if (document.readyState === 'loading') {
        window.addEventListener('load', loadNonCriticalResources);
    } else {
        loadNonCriticalResources();
    }
})();

// 3. 优化字体显示
(function() {
    // 添加字体显示策略
    const style = document.createElement('style');
    style.textContent = `
        /* 优化字体显示 */
        @font-face {
            font-display: swap;
        }
        
        /* 优化页面渲染 */
        html {
            scroll-behavior: smooth;
        }
        
        /* 减少重排重绘 */
        img {
            max-width: 100%;
            height: auto;
        }
    `;
    document.head.appendChild(style);
})();

// 4. 延迟加载图片
(function() {
    // 确保图片使用延迟加载
    const images = document.querySelectorAll('img');
    images.forEach(img => {
        if (!img.hasAttribute('loading')) {
            img.setAttribute('loading', 'lazy');
        }
    });
})();