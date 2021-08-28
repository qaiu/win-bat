:: 备份文件命名规则: 数据库名_当前时间戳_数据库管理系统名.sql	e.g. demodb_20120503101305_PostgreSQL.sql
:: 使用WinRAR的命令行程序Rar.exe来压缩备份好的.sql文件，前提是系统上要安装有WinRAR而且在此处的路径正确！
:: @update qaiu.cn
@echo off

@echo 正在初始化环境变量...
@echo.


::------------------------需要配置的东西--------------------------------------------

:: 备份文件盘符 文件夹名 
set BAK_SYMBOL=D:
set BAK_PATH=\sdsfdb_databackup

:: pgsql路径
set POSTGRESQL_DIR=D:\App\pgsql\bin

:: winrar路径
set WINRAR_DIR=D:\Program Files\WinRAR

::------------------------配置结束分割线----------------------------------------------

:: 数据库管理系统名
set DBMS_NAME=PostgreSQL

::判断配置路径是否正确
if not exist "%POSTGRESQL_DIR%\pg_dump.exe" (
	echo PostgreSQL路径错误请,修改脚本参数
	pause
	exit
)

if not exist "%WINRAR_DIR%\UnRAR.exe" (
	echo WinRAR路径错误,修改脚本参数
	pause
	exit
)

:: 表名
set DB_NAME=%1
:start
IF "%DB_NAME%"=="" (
	@echo 使用方法:pgsqlbak 库名
	set /p DB_NAME=请输入库名:
	goto :start
)
:: 用户名
set USER="postgres"
:: 密码
set PGPASSWORD=123456

set PATH=%POSTGRESQL_DIR%;%WINRAR_DIR%;%PATH%
set DBBAK_DIR=%BAK_SYMBOL%%BAK_PATH%
cd /d %BAK_SYMBOL%/
if not exist %BAK_PATH% (
	@echo 创建备份目录
	md %BAK_PATH%
)


@echo 正在备份数据库...
@echo.

:: 以下是获得当前系统时间的命令，e.g. 20120503101305
:: 年
set myyy=%date:~0,4%
:: 月
set mymm=%date:~5,2%
:: 日
set mydd=%date:~8,2%

@echo %myyy% %mymm% %mydd%

set /a TODAY=%date:~0,4%%date:~5,2%%date:~8,2%
set _TIME=%time:~0,8%
::@echo %_TIME%
set CURRENTTIME=%_time::=%
set CURRENTTIME=%CURRENTTIME: =0%
set MYDATETIME=%TODAY%%CURRENTTIME%
::@echo %MYDATETIME%

:: 使用PostgreSQL提供的pg_dump命令将具体数据库导出为.sql文件
pg_dump -h localhost -p 5432 -U %USER% %DB_NAME% >%DBBAK_DIR%\%DB_NAME%_%MYDATETIME%_%DBMS_NAME%.sql


@echo 正在压缩备份结果...
@echo.
:: 最好压缩(-m5)、固实压缩(-s)、从名称中排除路径(即不创建路径中包含的文件夹，-ep)
:: 压缩后删除文件到回收站(-dr)、压缩后删除文件(-df)
rar a %DBBAK_DIR%\%DB_NAME%_%MYDATETIME% %DBBAK_DIR%\%DB_NAME%_%MYDATETIME%_%DBMS_NAME%.sql -m5 -s -ep -dr

:: 删除7天前的文件
forfiles /p %DBBAK_DIR% /s /m *.* /d -7 /c "cmd /c del @path"

:: 删除生成的sql文件，不再启用，直接使用rar命令参数删除，更安全！
::@echo 正在删除临时文件...
::del %DBBAK_DIR%\%DB_NAME%_*.sql

:: 按任意键退出
:: PAUSE

exit