// 增强的翻译功能测试脚本
(function() {
    // 测试配置
    const TEST_CONFIG = {
        testDelay: 1500, // 初始测试延迟
        retestDelay: 800, // 语言切换后的重新测试延迟
        keyElements: [
            { selector: '#ba-zi-info-input-title', name: '八字信息输入标题' },
            { selector: '#query-position-btn', name: '查询按钮' },
            { selector: '#gender-select-label', name: '性别选择标签' },
            { selector: '#gender-select', name: '性别选择下拉框' },
            { selector: '#tab-position', name: '感情方位查询标签' },
            { selector: '#tab-location-match', name: '情侣方位匹配标签' },
            { selector: '#tab-timing', name: '感情年份预测标签' },
            { selector: '#language-dropdown', name: '语言切换器' }
        ]
    };
    
    // 工具函数
    function logTest(message, data) {
        if (typeof console !== 'undefined' && console.log) {
            if (data) {
                console.log(`【翻译测试】${message}:`, data);
            } else {
                console.log(`【翻译测试】${message}`);
            }
        }
    }
    
    function logTestError(message, error) {
        if (typeof console !== 'undefined' && console.error) {
            console.error(`【翻译测试错误】${message}`, error);
        }
    }
    
    // 主测试函数
    function testTranslationFix() {
        try {
            logTest('开始测试翻译功能修复...');
            
            // 获取当前语言设置（如果可访问）
            let currentLang = '未知';
            if (window.currentLang) {
                currentLang = window.currentLang;
            } else {
                logTest('无法直接访问currentLang变量，尝试从DOM获取');
                // 尝试从语言切换器获取当前语言
                const currentLangText = document.querySelector('#current-language-text');
                if (currentLangText) {
                    currentLang = currentLangText.textContent.trim();
                }
            }
            logTest(`当前测试语言环境: ${currentLang}`);
            
            // 测试关键UI元素
            const testResults = {
                totalElements: TEST_CONFIG.keyElements.length,
                foundElements: 0,
                missingElements: [],
                elementDetails: []
            };
            
            TEST_CONFIG.keyElements.forEach(element => {
                try {
                    const el = document.querySelector(element.selector);
                    if (el) {
                        testResults.foundElements++;
                        
                        // 特殊处理下拉框元素
                        let elementInfo;
                        if (element.name.includes('下拉框')) {
                            const options = el.querySelectorAll('option');
                            const optionTexts = [];
                            options.forEach(option => {
                                optionTexts.push({
                                    value: option.value,
                                    text: option.textContent.trim()
                                });
                            });
                            elementInfo = {
                                name: element.name,
                                found: true,
                                options: optionTexts
                            };
                            logTest(`${element.name} 存在，包含 ${options.length} 个选项`);
                        } else {
                            // 普通元素，记录文本内容
                            elementInfo = {
                                name: element.name,
                                found: true,
                                textContent: el.textContent ? el.textContent.trim() : '(空文本)'
                            };
                            logTest(`${element.name} 存在，文本: ${elementInfo.textContent}`);
                        }
                        
                        testResults.elementDetails.push(elementInfo);
                    } else {
                        testResults.missingElements.push(element);
                        logTestError(`${element.name} (${element.selector}) 不存在`);
                    }
                } catch (e) {
                    logTestError(`测试 ${element.name} 时出错`, e);
                }
            });
            
            // 显示测试结果摘要
            logTest('翻译功能测试完成，结果摘要:');
            logTest(`找到元素: ${testResults.foundElements}/${testResults.totalElements}`);
            
            if (testResults.missingElements.length > 0) {
                logTest('缺失的元素:', testResults.missingElements.map(el => el.name));
            }
            
            // 如果有翻译调试函数，调用它
            if (typeof testLanguageSwitch === 'function') {
                logTest('调用内部testLanguageSwitch函数进行额外测试');
                try {
                    testLanguageSwitch();
                } catch (e) {
                    logTestError('调用testLanguageSwitch时出错', e);
                }
            }
            
            // 显示简单的UI反馈
            showTestFeedback(testResults, currentLang);
            
            return testResults;
            
        } catch (error) {
            logTestError('测试执行过程中出错', error);
            return { error: error.message };
        }
    }
    
    // 显示测试结果UI反馈
    function showTestFeedback(results, language) {
        try {
            // 移除之前可能存在的反馈元素
            const oldFeedback = document.querySelector('.translation-test-feedback');
            if (oldFeedback && oldFeedback.parentNode) {
                oldFeedback.parentNode.removeChild(oldFeedback);
            }
            
            // 创建新的反馈元素
            const feedback = document.createElement('div');
            feedback.className = 'translation-test-feedback';
            feedback.style.cssText = 'position:fixed; top:20px; right:20px; background:#2c3e50; color:white; padding:15px; border-radius:5px; z-index:9999; max-width:320px; font-size:14px; box-shadow:0 2px 10px rgba(0,0,0,0.2);';
            
            // 计算成功率
            const successRate = Math.round((results.foundElements / results.totalElements) * 100);
            
            // 设置内容
            feedback.innerHTML = `
                <h4 style="margin:0 0 10px 0; font-size:16px;">翻译功能测试结果</h4>
                <p style="margin:5px 0;">当前语言: <strong>${language}</strong></p>
                <p style="margin:5px 0;">元素检测: <strong>${results.foundElements}/${results.totalElements}</strong> (${successRate}%)</p>
            `;
            
            // 添加关闭按钮
            const closeBtn = document.createElement('button');
            closeBtn.textContent = '×';
            closeBtn.style.cssText = 'position:absolute; top:5px; right:5px; background:none; border:none; color:white; font-size:18px; cursor:pointer; padding:2px 6px;';
            closeBtn.onclick = function() {
                if (feedback.parentNode) {
                    feedback.parentNode.removeChild(feedback);
                }
            };
            feedback.appendChild(closeBtn);
            
            // 添加到页面
            if (document.body) {
                document.body.appendChild(feedback);
                
                // 10秒后自动隐藏
                setTimeout(() => {
                    if (feedback.parentNode) {
                        feedback.style.opacity = '0';
                        feedback.style.transition = 'opacity 0.5s';
                        setTimeout(() => {
                            if (feedback.parentNode) {
                                feedback.parentNode.removeChild(feedback);
                            }
                        }, 500);
                    }
                }, 10000);
            }
            
        } catch (e) {
            logTestError('显示测试反馈时出错', e);
        }
    }
    
    // 模拟语言切换测试
    function simulateLanguageSwitch() {
        try {
            logTest('尝试模拟语言切换测试');
            
            // 获取语言选项
            const langOptions = document.querySelectorAll('.language-option');
            if (langOptions.length > 1) {
                // 找出当前未选中的语言选项
                let targetOption = null;
                for (let i = 0; i < langOptions.length; i++) {
                    if (!langOptions[i].classList.contains('active')) {
                        targetOption = langOptions[i];
                        break;
                    }
                }
                
                if (targetOption) {
                    logTest(`尝试切换到语言: ${targetOption.textContent.trim()}`);
                    // 触发点击事件
                    if (targetOption.click) {
                        targetOption.click();
                        logTest('语言切换点击事件已触发');
                    } else {
                        logTestError('无法触发语言选项点击事件');
                    }
                } else {
                    logTest('未找到非激活状态的语言选项，使用第一个选项');
                    if (langOptions[0].click) {
                        langOptions[0].click();
                    }
                }
            } else {
                logTest('语言选项不足，无法进行切换测试');
            }
            
        } catch (e) {
            logTestError('模拟语言切换时出错', e);
        }
    }
    
    // 当DOM加载完成后执行测试
    function initTest() {
        logTest('初始化翻译测试...');
        
        // 延迟执行初始测试
        setTimeout(() => {
            logTest('执行初始翻译测试');
            testTranslationFix();
            
            // 延迟一段时间后进行语言切换测试
            setTimeout(simulateLanguageSwitch, 3000);
        }, TEST_CONFIG.testDelay);
    }
    
    // 添加翻译测试按钮
    function addTestButton() {
        try {
            // 检查是否已存在测试按钮
            if (document.getElementById('translation-test-button')) return;
            
            // 创建测试按钮
            const button = document.createElement('button');
            button.id = 'translation-test-button';
            button.textContent = '测试翻译功能';
            button.style.cssText = 'position:fixed; bottom:20px; right:20px; background:#3498db; color:white; border:none; padding:10px 20px; border-radius:5px; cursor:pointer; z-index:9999;';
            
            // 添加点击事件
            button.onclick = function() {
                logTest('手动触发翻译功能测试');
                testTranslationFix();
                
                // 提示用户切换语言查看效果
                if (confirm('测试已完成！请尝试切换语言，然后再次点击此按钮查看翻译效果。')) {
                    // 尝试聚焦语言切换器
                    const langSwitcher = document.getElementById('language-dropdown-btn');
                    if (langSwitcher) {
                        langSwitcher.focus();
                    }
                }
            };
            
            // 添加到页面
            if (document.body) {
                document.body.appendChild(button);
                logTest('已添加翻译测试按钮');
            }
        } catch (e) {
            logTestError('添加测试按钮时出错', e);
        }
    }
    
    // 使用多种方式确保DOM加载完成后初始化测试
    function init() {
        addTestButton();
        initTest();
    }
    
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else if (document.readyState === 'interactive' || document.readyState === 'complete') {
        // DOM已经加载完成，直接初始化
        init();
    } else {
        // 降级方案
        window.onload = init;
    }
    
    // 监听语言切换事件（如果有）
    document.addEventListener('languageChanged', function(event) {
        logTest('检测到语言切换事件:', event.detail ? event.detail.language : '未知');
        setTimeout(testTranslationFix, TEST_CONFIG.retestDelay);
    });
    
    // 导出测试函数供外部调用
    window.testTranslationFix = testTranslationFix;
})();
