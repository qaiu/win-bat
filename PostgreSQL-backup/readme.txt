Windows postgresql备份恢复v3.0脚本使用说明
SQL备份
1.修改pgsqlbak.bat 参数区pgsql路径 winRAR路径等
2.自动备份: 添加Windows任务计划 执行程序填写bat脚本路径 参数写数据库名
3.手动备份:执行 pgsqlbak.bat 库名

SQL恢复
1.修改pgsqlres.bat 参数区pgsql路径 winRAR路径等
2.将备份rar包放在脚本目录(必须是pgsqlbak.bat备份的SQL压缩文件)
3.执行pgsqlres.bat

quartz(定时任务)库如果不存在 需要手动创建
然后执行SQL脚本 quartz-public.sql