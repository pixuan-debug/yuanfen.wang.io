/**
 * 跨浏览器测试脚本
 * 用于验证生肖配对页面在不同浏览器中的兼容性
 */

console.log('==== 开始跨浏览器兼容性测试 ====');

// 1. 测试基本DOM API兼容性
function testDOMAPICompatibility() {
    console.log('\n1. 测试DOM API兼容性:');
    
    const results = {
        querySelector: typeof document.querySelector === 'function',
        querySelectorAll: typeof document.querySelectorAll === 'function',
        getElementsByClassName: typeof document.getElementsByClassName === 'function',
        getElementById: typeof document.getElementById === 'function',
        addEventListener: typeof document.addEventListener === 'function'
    };
    
    for (const [api, supported] of Object.entries(results)) {
        console.log(`   ${api}: ${supported ? '✓ 支持' : '✗ 不支持'}`);
    }
    
    return results;
}

// 2. 测试CSS兼容性
function testCSSCompatibility() {
    console.log('\n2. 测试CSS兼容性:');
    
    const body = document.body;
    const style = window.getComputedStyle ? window.getComputedStyle(body) : body.currentStyle;
    
    // 测试CSS变量支持
    let cssVariablesSupported = false;
    try {
        // 创建一个临时元素来测试CSS变量
        const tempDiv = document.createElement('div');
        tempDiv.style.setProperty('--test-var', 'red');
        cssVariablesSupported = tempDiv.style.getPropertyValue('--test-var') === 'red';
    } catch (e) {
        console.log('   CSS变量测试出错:', e.message);
    }
    
    // 测试一些关键CSS属性
    const results = {
        'CSS变量': cssVariablesSupported,
        'Flexbox': typeof style.display !== 'undefined' && 
                  (style.display.toLowerCase().includes('flex') || 
                   document.body.style.display !== undefined),
        'Grid': typeof style.grid !== 'undefined' || typeof style.gridTemplateColumns !== 'undefined',
        'Scrollbar Gutter': typeof style.scrollbarGutter !== 'undefined'
    };
    
    for (const [feature, supported] of Object.entries(results)) {
        console.log(`   ${feature}: ${supported ? '✓ 支持' : '⚠ 可能不支持'}`);
    }
    
    return results;
}

// 3. 测试表单功能
function testFormFunctionality() {
    console.log('\n3. 测试表单功能:');
    
    const results = {
        formElementsExist: !!document.getElementById('position-day-master-element') || 
                          !!document.querySelector('.gender-option'),
        buttonsExist: !!document.getElementById('calculate-position-btn') || 
                     !!document.getElementById('reset-position-btn')
    };
    
    for (const [feature, supported] of Object.entries(results)) {
        console.log(`   ${feature}: ${supported ? '✓ 存在' : '✗ 不存在'}`);
    }
    
    return results;
}

// 4. 测试多语言功能
function testLanguageFunctionality() {
    console.log('\n4. 测试多语言功能:');
    
    // 检查语言切换器是否存在
    const languageSwitcher = document.getElementById('language-switcher');
    const hasLanguageSwitcher = !!languageSwitcher;
    
    console.log(`   语言切换器存在: ${hasLanguageSwitcher ? '✓' : '✗'}`);
    
    // 检查当前页面使用的语言
    const htmlLang = document.documentElement.lang || '未设置';
    console.log(`   当前页面语言: ${htmlLang}`);
    
    // 检查translations对象是否定义
    if (typeof translations !== 'undefined') {
        console.log(`   支持的语言数量: ${Object.keys(translations).length}`);
        console.log(`   支持的语言: ${Object.keys(translations).join(', ')}`);
    } else {
        console.log('   ✗ translations对象未定义');
    }
    
    // 测试翻译函数是否可用
    const hasTranslateFunction = typeof translatePage === 'function';
    console.log(`   翻译函数可用: ${hasTranslateFunction ? '✓' : '✗'}`);
    
    // 测试翻译文本对象是否存在
    if (typeof translationTexts !== 'undefined') {
        console.log(`   翻译文本对象存在: ✓`);
        console.log(`   可用语言数量: ${Object.keys(translationTexts).length}`);
    } else {
        console.log('   ✗ 翻译文本对象未定义');
    }
    
    // 测试DOM文本操作兼容性
    try {
        const testElement = document.createElement('div');
        testElement.innerHTML = '<p>测试内容</p>';
        document.body.appendChild(testElement);
        
        const hasInnerHTML = typeof testElement.innerHTML !== 'undefined';
        const hasTextContent = typeof testElement.textContent !== 'undefined';
        
        console.log(`   DOM文本操作: ${hasInnerHTML || hasTextContent ? '✓ 支持' : '✗ 不支持'}`);
        document.body.removeChild(testElement);
    } catch (e) {
        console.log(`   DOM文本操作: ✗ 不支持 (错误: ${e.message})`);
    }
    
    return {
        hasLanguageSwitcher,
        htmlLang,
        hasTranslateFunction,
        hasTranslations: typeof translations !== 'undefined',
        hasTranslationTexts: typeof translationTexts !== 'undefined'
    };
}

// 5. 测试标签页功能
function testTabsFunctionality() {
    console.log('\n5. 测试标签页功能:');
    
    const tabButtons = document.querySelectorAll('.tab-btn');
    const tabsExist = tabButtons.length > 0;
    
    console.log(`   标签按钮数量: ${tabButtons.length}`);
    
    // 检查主要内容区域
    const positionTab = document.getElementById('position');
    const matchTab = document.getElementById('location-match');
    const timingTab = document.getElementById('timing');
    
    console.log(`   正缘方位标签页: ${positionTab ? '✓ 存在' : '✗ 不存在'}`);
    console.log(`   情侣匹配标签页: ${matchTab ? '✓ 存在' : '✗ 不存在'}`);
    console.log(`   正缘年份标签页: ${timingTab ? '✓ 存在' : '✗ 不存在'}`);
    
    return {
        tabsExist,
        hasPositionTab: !!positionTab,
        hasMatchTab: !!matchTab,
        hasTimingTab: !!timingTab
    };
}

// 6. 浏览器信息检测
function detectBrowserInfo() {
    console.log('\n6. 浏览器信息:');
    
    const ua = navigator.userAgent;
    let browser = '未知';
    let version = '未知';
    
    // 简单的浏览器检测
    if (ua.indexOf('Chrome') > -1) {
        browser = 'Chrome';
        const match = ua.match(/Chrome\/(\d+)/);
        if (match) version = match[1];
    } else if (ua.indexOf('Firefox') > -1) {
        browser = 'Firefox';
        const match = ua.match(/Firefox\/(\d+)/);
        if (match) version = match[1];
    } else if (ua.indexOf('Safari') > -1 && ua.indexOf('Chrome') === -1) {
        browser = 'Safari';
        const match = ua.match(/Version\/(\d+)/);
        if (match) version = match[1];
    } else if (ua.indexOf('Edge') > -1) {
        browser = 'Edge';
        const match = ua.match(/Edge\/(\d+)/);
        if (match) version = match[1];
    } else if (ua.indexOf('MSIE') > -1 || ua.indexOf('Trident') > -1) {
        browser = 'IE';
        const match = ua.match(/MSIE\s*(\d+)/) || ua.match(/rv:(\d+)/);
        if (match) version = match[1];
    }
    
    console.log(`   浏览器: ${browser}`);
    console.log(`   版本: ${version}`);
    console.log(`   操作系统: ${navigator.platform}`);
    
    return { browser, version, platform: navigator.platform };
}

// 7. 显示综合兼容性报告
function generateCompatibilityReport(results) {
    console.log('\n==== 兼容性测试报告 ====');
    
    // 计算兼容性得分
    let score = 0;
    let totalTests = 0;
    
    // DOM API得分
    Object.values(results.domAPI).forEach(supported => {
        score += supported ? 1 : 0;
        totalTests++;
    });
    
    // CSS功能得分
    Object.values(results.css).forEach(supported => {
        score += supported ? 1 : 0;
        totalTests++;
    });
    
    // 功能得分
    Object.values(results.form).forEach(supported => {
        score += supported ? 1 : 0;
        totalTests++;
    });
    
    // 计算百分比
    const compatibilityPercentage = Math.round((score / totalTests) * 100);
    
    console.log(`\n综合兼容性得分: ${compatibilityPercentage}%`);
    
    // 兼容性等级
    let compatibilityLevel = '优秀';
    if (compatibilityPercentage < 100 && compatibilityPercentage >= 80) {
        compatibilityLevel = '良好';
    } else if (compatibilityPercentage < 80 && compatibilityPercentage >= 60) {
        compatibilityLevel = '一般';
    } else if (compatibilityPercentage < 60) {
        compatibilityLevel = '较差';
    }
    
    console.log(`兼容性等级: ${compatibilityLevel}`);
    
    // 提供建议
    if (compatibilityPercentage < 100) {
        console.log('\n优化建议:');
        
        // DOM API建议
        if (!results.domAPI.querySelectorAll) {
            console.log('- 请使用getElementsByClassName作为querySelectorAll的降级方案');
        }
        
        // CSS建议
        if (!results.css['CSS变量']) {
            console.log('- 对于不支持CSS变量的浏览器，请提供备选样式');
        }
        
        if (!results.css['Scrollbar Gutter']) {
            console.log('- 对于不支持scrollbar-gutter的浏览器，可能需要手动调整内容边距');
        }
    }
    
    return {
        compatibilityPercentage,
        compatibilityLevel
    };
}

// 运行所有测试
function runAllTests() {
    try {
        const results = {
            domAPI: testDOMAPICompatibility(),
            css: testCSSCompatibility(),
            form: testFormFunctionality(),
            language: testLanguageFunctionality(),
            tabs: testTabsFunctionality(),
            browser: detectBrowserInfo()
        };
        
        const report = generateCompatibilityReport(results);
        
        // 在页面上显示测试结果
        displayResultsOnPage(results, report);
        
        return { results, report };
    } catch (error) {
        console.error('测试过程中发生错误:', error);
    }
}

// 在页面上显示测试结果
function displayResultsOnPage(results, report) {
    try {
        // 创建测试结果容器
        const testContainer = document.createElement('div');
        testContainer.id = 'compatibility-test-results';
        testContainer.style.cssText = `
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 20px;
            margin: 20px auto;
            max-width: 800px;
            font-family: Arial, sans-serif;
            font-size: 14px;
        `;
        
        // 创建标题
        const title = document.createElement('h3');
        title.textContent = '浏览器兼容性测试结果';
        title.style.cssText = 'color: #333; margin-top: 0;';
        testContainer.appendChild(title);
        
        // 创建浏览器信息
        const browserInfo = document.createElement('div');
        browserInfo.innerHTML = `<strong>浏览器:</strong> ${results.browser.browser} ${results.browser.version} (${results.browser.platform})`;
        browserInfo.style.cssText = 'margin-bottom: 15px; padding: 10px; background-color: #e9ecef; border-radius: 4px;';
        testContainer.appendChild(browserInfo);
        
        // 创建总体得分
        const scoreDiv = document.createElement('div');
        scoreDiv.innerHTML = `<strong>兼容性得分:</strong> ${report.compatibilityPercentage}% (${report.compatibilityLevel})`;
        scoreDiv.style.cssText = 'margin-bottom: 15px; padding: 10px; background-color: #d4edda; border-radius: 4px;';
        testContainer.appendChild(scoreDiv);
        
        // 创建详细结果部分
        const details = document.createElement('div');
        
        // DOM API结果
        const domSection = document.createElement('div');
        domSection.innerHTML = `<h4>DOM API 兼容性</h4>
            <div>querySelector: ${results.domAPI.querySelector ? '✓' : '✗'}</div>
            <div>querySelectorAll: ${results.domAPI.querySelectorAll ? '✓' : '✗'}</div>
            <div>getElementsByClassName: ${results.domAPI.getElementsByClassName ? '✓' : '✗'}</div>
            <div>getElementById: ${results.domAPI.getElementById ? '✓' : '✗'}</div>
            <div>addEventListener: ${results.domAPI.addEventListener ? '✓' : '✗'}</div>`;
        domSection.style.cssText = 'margin-bottom: 15px;';
        details.appendChild(domSection);
        
        // CSS结果
        const cssSection = document.createElement('div');
        cssSection.innerHTML = `<h4>CSS 兼容性</h4>
            <div>CSS变量: ${results.css['CSS变量'] ? '✓' : '⚠'}</div>
            <div>Flexbox: ${results.css['Flexbox'] ? '✓' : '⚠'}</div>
            <div>Grid: ${results.css['Grid'] ? '✓' : '⚠'}</div>
            <div>Scrollbar Gutter: ${results.css['Scrollbar Gutter'] ? '✓' : '⚠'}</div>`;
        cssSection.style.cssText = 'margin-bottom: 15px;';
        details.appendChild(cssSection);
        
        // 语言功能结果
        const languageSection = document.createElement('div');
        languageSection.innerHTML = `<h4>多语言功能</h4>
            <div>语言切换器: ${results.language.hasLanguageSwitcher ? '✓ 存在' : '✗ 不存在'}</div>
            <div>当前语言: ${results.language.htmlLang}</div>`;
        languageSection.style.cssText = 'margin-bottom: 15px;';
        details.appendChild(languageSection);
        
        // 添加到容器
        testContainer.appendChild(details);
        
        // 添加测试说明
        const note = document.createElement('p');
        note.textContent = '注意：此测试仅供参考，建议在实际目标浏览器中进行完整功能测试。';
        note.style.cssText = 'font-style: italic; color: #666; margin-top: 20px;';
        testContainer.appendChild(note);
        
        // 将测试结果添加到页面
        const container = document.querySelector('.container') || document.body;
        container.appendChild(testContainer);
    } catch (error) {
        console.error('显示测试结果时出错:', error);
    }
}

// 当页面加载完成后运行测试
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', runAllTests);
} else {
    // 如果页面已经加载完成，立即运行
    runAllTests();
}
