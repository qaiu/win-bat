:: �����ļ���������: ���ݿ���_��ǰʱ���_���ݿ����ϵͳ��.sql	e.g. demodb_20120503101305_PostgreSQL.sql
:: ʹ��WinRAR�������г���Rar.exe��ѹ�����ݺõ�.sql�ļ���ǰ����ϵͳ��Ҫ��װ��WinRAR�����ڴ˴���·����ȷ��
:: @update qaiu.cn

@echo off&@chcp 936 > nul
:: PGSQL�ָ����� ע��ִ�л�ɾ��ԭ���ݿ�!! 
:: ������ز���!! 
:: ������ز���!! 
:: ������ز���!! 
::-----------------------------------���ò���------------------------------------------------------------

:: PostgreSQL��װ·��
set POSTGRESQL_DIR=D:\App\pgsql\bin

:: WinRAR·��
set WINRAR_DIR=D:\Program Files\WinRAR

:: �û��� ����
set USER=postgres
set PGPASSWORD=123456

::----------------------------------------------------------------------------------------------------------

::�ж�����·���Ƿ���ȷ
if not exist "%POSTGRESQL_DIR%\pg_dump.exe" (
	echo PostgreSQL·��������,�޸Ľű�����
	goto :quit
)

if not exist "%WINRAR_DIR%\UnRAR.exe" (
	echo WinRAR·������,�޸Ľű�����
	goto :quit
)

:: ����SQLѹ�����ļ���
cd %~dp0
for %%i in (*_20*.rar) do (
	set FILE_NAME=%%i
	goto :label1
)
echo δ�ҵ�rarѹ����
goto :quit
:label1
:: ���ݿ���
set DB_NAME=%FILE_NAME:~0,-19%
:start
echo ����ѹ������:%FILE_NAME%
echo �ָ����ݿ���:%DB_NAME%
echo �˲���������Ѵ������ݿ�������ݿⲻ�������Զ�����,�����ز���!!!
echo ������[Yȷ��; R�޸Ŀ���; ����������˳�]:
set /p var=
if "%var%" equ "R" (
	set /p DB_NAME=���������:
	goto :start
) else if "%var%" neq "Y" (
	echo �û�ȡ���ָ�
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
echo �ָ����
:quit
pause
:: exit
