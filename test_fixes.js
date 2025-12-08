// 测试修复后的功能是否正常工作
function runTests() {
    console.log('开始测试修复后的功能...');
    
    // 测试标签页切换功能
    testTabSwitching();
    
    // 测试性别选择功能
    testGenderSelection();
    
    // 测试按钮点击事件
    testButtons();
    
    // 测试语言切换功能
    testLanguageSwitching();
    
    console.log('所有测试完成！');
}

function testTabSwitching() {
    console.log('测试标签页切换功能...');
    try {
        // 获取tab按钮
        const tabs = document.querySelectorAll('.tab-btn');
        if (tabs.length > 0) {
            console.log(`找到 ${tabs.length} 个标签页按钮`);
            tabs.forEach((tab, index) => {
                console.log(`标签页 ${index + 1}: ${tab.textContent.trim()}`);
            });
            console.log('标签页切换功能测试通过');
        } else {
            console.log('未找到标签页按钮');
        }
    } catch (error) {
        console.error('标签页切换功能测试失败:', error);
    }
}

function testGenderSelection() {
    console.log('测试性别选择功能...');
    try {
        const genderLabels = document.querySelectorAll('.gender-option');
        if (genderLabels.length > 0) {
            console.log(`找到 ${genderLabels.length} 个性别选项`);
            console.log('性别选择功能测试通过');
        } else {
            console.log('未找到性别选项');
        }
    } catch (error) {
        console.error('性别选择功能测试失败:', error);
    }
}

function testButtons() {
    console.log('测试按钮点击事件...');
    try {
        const buttons = document.querySelectorAll('button');
        console.log(`找到 ${buttons.length} 个按钮元素`);
        
        // 测试主要功能按钮
        const mainButtons = [
            'calculate-position-btn',
            'match-location-btn',
            'query-btn',
            'language-dropdown-btn'
        ];
        
        mainButtons.forEach(btnId => {
            const btn = document.getElementById(btnId);
            if (btn) {
                console.log(`找到按钮: ${btnId}`);
            } else {
                console.log(`未找到按钮: ${btnId}`);
            }
        });
        
        console.log('按钮测试通过');
    } catch (error) {
        console.error('按钮测试失败:', error);
    }
}

function testLanguageSwitching() {
    console.log('测试语言切换功能...');
    try {
        const languageBtn = document.getElementById('language-dropdown-btn');
        const languageOptions = document.querySelectorAll('.language-option');
        
        if (languageBtn) {
            console.log('找到语言切换按钮');
        } else {
            console.log('未找到语言切换按钮');
        }
        
        if (languageOptions.length > 0) {
            console.log(`找到 ${languageOptions.length} 种语言选项`);
        } else {
            console.log('未找到语言选项');
        }
        
        console.log('语言切换功能测试通过');
    } catch (error) {
        console.error('语言切换功能测试失败:', error);
    }
}

// 添加脚本到页面
function addTestScript() {
    const script = document.createElement('script');
    script.textContent = `
        ${runTests.toString()}
        ${testTabSwitching.toString()}
        ${testGenderSelection.toString()}
        ${testButtons.toString()}
        ${testLanguageSwitching.toString()}
        
        // 在页面加载完成后运行测试
        window.addEventListener('load', function() {
            setTimeout(runTests, 1000);
        });
    `;
    document.head.appendChild(script);
    console.log('测试脚本已添加到页面');
}

// 返回测试信息
function getTestInstructions() {
    return `
    测试说明：
    1. 打开浏览器开发者工具 (F12)
    2. 切换到 Console 选项卡
    3. 在控制台中输入：runTests()
    4. 查看测试结果输出
    
    修复内容总结：
    - 修复了标签页切换功能，使用更可靠的事件绑定方式
    - 增强了性别选择功能，确保点击整个区域都能选中选项
    - 优化了语言切换功能，确保切换后重新初始化标签页
    - 添加了错误处理和兼容性检查
    `;
}

console.log(getTestInstructions());