# 简单的HTTP服务器脚本
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add('http://localhost:8000/')
$listener.Start()
Write-Host "服务器运行在 http://localhost:8000"
Write-Host "按Ctrl+C停止服务器"

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response
    
    # 获取请求的文件路径
    $filePath = $request.Url.LocalPath.Trim('/')
    
    # 如果路径为空，使用zodiac_match.html
    if ([string]::IsNullOrEmpty($filePath)) {
        $filePath = 'zodiac_match.html'
    }
    
    # 构建完整的文件路径
    $fullPath = Join-Path -Path (Get-Location) -ChildPath $filePath
    
    # 检查文件是否存在
    if (Test-Path $fullPath -PathType Leaf) {
        try {
            # 读取文件内容
            $content = [System.IO.File]::ReadAllText($fullPath)
            $buffer = [System.Text.Encoding]::UTF8.GetBytes($content)
            
            # 设置响应
            $response.ContentLength64 = $buffer.Length
            $response.ContentType = 'text/html; charset=utf-8'
            
            # 发送响应
            $output = $response.OutputStream
            $output.Write($buffer, 0, $buffer.Length)
            $output.Close()
            
            Write-Host "提供文件: $filePath"
        } catch {
            Write-Host "读取文件错误: $_"
            $response.StatusCode = 500
            $response.Close()
        }
    } else {
        # 文件不存在时返回404
        $response.StatusCode = 404
        $response.Close()
        Write-Host "未找到文件: $filePath"
    }
}
