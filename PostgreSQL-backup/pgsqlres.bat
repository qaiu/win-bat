@echo off&@chcp 936 > nul
:: PGSQL恢复命令 注意执行会删除原数据库!! 
:: 务必慎重操作!! 
:: 务必慎重操作!! 
:: 务必慎重操作!! 
::-----------------------------------配置部分------------------------------------------------------------

:: PostgreSQL安装路径
set POSTGRESQL_DIR=D:\App\pgsql\bin

:: WinRAR路径
set WINRAR_DIR=D:\Program Files\WinRAR

:: 用户名 密码
set USER=postgres
set PGPASSWORD=123456

::----------------------------------------------------------------------------------------------------------

::判断配置路径是否正确
if not exist "%POSTGRESQL_DIR%\pg_dump.exe" (
	echo PostgreSQL路径错误请,修改脚本参数
	goto :quit
)

if not exist "%WINRAR_DIR%\UnRAR.exe" (
	echo WinRAR路径错误,修改脚本参数
	goto :quit
)

:: 查找SQL压缩包文件名
cd %~dp0
for %%i in (*_20*.rar) do (
	set FILE_NAME=%%i
	goto :label1
)
echo 未找到rar压缩包
goto :quit
:label1
:: 数据库名
set DB_NAME=%FILE_NAME:~0,-19%
:start
echo 备份压缩包名:%FILE_NAME%
echo 恢复数据库名:%DB_NAME%
echo 此操作会清空已存在数据库如果数据库不存在则自动创建,请慎重操作!!!
echo 请输入[Y确认; R修改库名; 其他任意键退出]:
set /p var=
if "%var%" equ "R" (
	set /p DB_NAME=请输入库名:
	goto :start
) else if "%var%" neq "Y" (
	echo 用户取消恢复
	goto :quit
)
set PATH=%POSTGRESQL_DIR%;%WINRAR_DIR%;%PATH%

unrar e -o+ %FILE_NAME% %TEMP%
set SQL_FILE=%FILE_NAME:~0,-4%_PostgreSQL.sql

psql -U %USER% -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE datname='%DB_NAME%' AND pid<>pg_backend_pid()"
psql -U %USER% -c "drop database if exists %DB_NAME%"
psql -U %USER% -c "create database %DB_NAME%"
psql -d %DB_NAME% -U %USER% -f "%TEMP%\%SQL_FILE%"

echo delete temp file
del %TEMP%\%SQL_FILE%
echo 恢复完成
:quit
pause
:: exit
