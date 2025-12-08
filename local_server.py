#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
命理正缘查询工具本地服务器脚本
用于快速预览和测试网站
"""

import http.server
import socketserver
import webbrowser
import os
import sys

# 定义服务器端口
PORT = 8000

# 获取当前脚本所在目录
script_dir = os.path.dirname(os.path.abspath(__file__))

# 切换到脚本所在目录
os.chdir(script_dir)

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    """自定义HTTP请求处理器，用于设置正确的MIME类型"""
    def end_headers(self):
        # 添加CORS头，允许跨域请求
        self.send_header('Access-Control-Allow-Origin', '*')
        super().end_headers()

    # 设置正确的MIME类型
    extensions_map = {
        **http.server.SimpleHTTPRequestHandler.extensions_map,
        '.html': 'text/html; charset=utf-8',
        '.js': 'application/javascript; charset=utf-8',
        '.css': 'text/css; charset=utf-8',
    }

def main():
    """主函数"""
    print("=" * 50)
    print("命理正缘查询工具本地服务器")
    print("=" * 50)
    print(f"当前工作目录: {script_dir}")
    print(f"服务器将在 http://localhost:{PORT} 启动")
    print("按 Ctrl+C 停止服务器")
    print("=" * 50)
    
    try:
        # 创建服务器
        with socketserver.TCPServer(("", PORT), MyHTTPRequestHandler) as httpd:
            # 自动打开浏览器
            webbrowser.open(f"http://localhost:{PORT}/zodiac_match.html")
            
            # 启动服务器
            print(f"服务器正在运行...")
            httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n服务器已停止")
        sys.exit(0)
    except Exception as e:
        print(f"\n启动服务器时出错: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
