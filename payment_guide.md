# 支付宝收款功能接入指南

## 一、接入方案概述

由于当前项目是**纯静态HTML网站**，没有后端服务器支持，接入支付宝收款功能主要有以下两种方案：

### 方案1：静态收款码展示
这是最简单直接的方式，适合个人或小流量网站使用。

### 方案2：支付宝官方收款链接
适合需要统计收款数据或有更多功能需求的场景。

## 二、需要您提供的信息

### 方案1：静态收款码展示
1. **支付宝收款码图片**
   - 请提供您的支付宝收款码图片（建议格式：PNG/JPG，尺寸：300x300像素以上）
   - 获取方式：打开支付宝APP → 收钱 → 保存收款码

2. **收款说明文字**（可选）
   - 例如："感谢使用本工具，如需更详细的命理分析，请扫码支持"

3. **收款金额建议**（可选）
   - 例如："建议打赏金额：10元/次"

### 方案2：支付宝官方收款链接
1. **支付宝商户号或个人收款链接**
   - 个人用户：打开支付宝APP → 收钱 → 收款小账本 → 商家工具 → 在线收款
   - 企业用户：登录支付宝商家平台创建收款链接

2. **收款金额设置**（可选）
   - 固定金额或可选金额

3. **收款商品名称**
   - 例如："命理分析服务费"

## 三、接入实现示例

### 方案1：静态收款码展示实现

```html
<!-- 在页面合适位置添加收款码区域 -->
<div class="payment-section" style="max-width: 600px; margin: 2rem auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 8px; text-align: center;">
    <h3 style="color: var(--text-color); margin-bottom: 1rem;">感谢支持</h3>
    <p style="color: var(--light-text); margin-bottom: 2rem;">如需更详细的命理分析，请扫码支持</p>
    
    <!-- 支付宝收款码图片 -->
    <div style="margin-bottom: 1.5rem;">
        <img src="alipay-qrcode.png" alt="支付宝收款码" style="width: 250px; height: 250px; border-radius: 8px; box-shadow: var(--shadow-medium);">
    </div>
    
    <!-- 收款说明 -->
    <p style="color: var(--light-text); font-size: 0.9rem;">建议打赏金额：10元/次</p>
    <p style="color: var(--light-text); font-size: 0.8rem; margin-top: 1rem;">感谢您的支持，祝您生活愉快！</p>
</div>
```

### 方案2：支付宝官方收款链接实现

```html
<!-- 在页面合适位置添加收款按钮 -->
<div class="payment-section" style="max-width: 600px; margin: 2rem auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 8px; text-align: center;">
    <h3 style="color: var(--text-color); margin-bottom: 1rem;">获取详细分析报告</h3>
    <p style="color: var(--light-text); margin-bottom: 2rem;">支付后即可获取完整的命理分析报告</p>
    
    <!-- 支付宝收款按钮 -->
    <a href="https://qr.alipay.com/FKX001234567890123" target="_blank" style="display: inline-block; padding: 12px 30px; background-color: #1677FF; color: white; text-decoration: none; border-radius: 4px; font-weight: 500; transition: background-color 0.3s;">
        <i class="fa fa-alipay" style="margin-right: 8px;"></i>立即支付 10元
    </a>
    
    <p style="color: var(--light-text); font-size: 0.8rem; margin-top: 1.5rem;">支付后请截图并联系客服获取报告</p>
</div>
```

## 四、接入位置建议

根据当前页面结构，建议在以下位置添加收款功能：

1. **查询结果区域下方**：用户获得查询结果后，是最合适的引导时机
2. **页面底部footer上方**：作为全局的支持入口
3. **侧边悬浮按钮**：不影响主要内容，随时可访问

## 五、后续扩展建议

如果您希望未来实现更高级的支付功能，如：
- 自动生成订单
- 支付后自动解锁内容
- 会员系统

您需要：
1. 搭建后端服务器
2. 接入支付宝官方API
3. 实现数据库存储

## 六、下一步操作

请您根据上述方案，准备好所需的信息（收款码图片或收款链接），我将为您完成具体的接入实现。