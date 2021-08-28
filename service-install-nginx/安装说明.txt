将当前目录下所有文件拷贝到nginx根目录

注意事项:
1. 不要将nginx放在中文路径下
2. (除非下面特别说明)当前文件夹下所有bat脚本都要以管理员身份运行
3. 仅限于windows平台, win7(含)以下版本可能有bug

BAT脚本说明
1. nginx-server-install.bat: 安装并启动nginx服务 
2. nginx-server-uninstall.bat: 停止并删除nginx服务 
3. nginx-server-start.bat: 启动nginx服务 
4. nginx-server-stop.bat: 停止nginx服务 (首次执行有提示 点同意) 
5. nginx-reload.bat: 重新加载nginx配置 (首次执行有提示 点同意) 
---
6. nginx-service-add-env-path.bat 设置环境变量(不建议使用)
