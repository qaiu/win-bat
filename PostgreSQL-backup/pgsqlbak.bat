:: �����ļ���������: ���ݿ���_��ǰʱ���_���ݿ����ϵͳ��.sql	e.g. demodb_20120503101305_PostgreSQL.sql
:: ʹ��WinRAR�������г���Rar.exe��ѹ�����ݺõ�.sql�ļ���ǰ����ϵͳ��Ҫ��װ��WinRAR�����ڴ˴���·����ȷ��
:: @update qaiu.cn
@echo off

@echo ���ڳ�ʼ����������...
@echo.


::------------------------��Ҫ���õĶ���--------------------------------------------

:: �����ļ��̷� �ļ����� 
set BAK_SYMBOL=D:
set BAK_PATH=\sdsfdb_databackup

:: pgsql·��
set POSTGRESQL_DIR=D:\App\pgsql\bin

:: winrar·��
set WINRAR_DIR=D:\Program Files\WinRAR

::------------------------���ý����ָ���----------------------------------------------

:: ���ݿ����ϵͳ��
set DBMS_NAME=PostgreSQL

::�ж�����·���Ƿ���ȷ
if not exist "%POSTGRESQL_DIR%\pg_dump.exe" (
	echo PostgreSQL·��������,�޸Ľű�����
	pause
	exit
)

if not exist "%WINRAR_DIR%\UnRAR.exe" (
	echo WinRAR·������,�޸Ľű�����
	pause
	exit
)

:: ����
set DB_NAME=%1
:start
IF "%DB_NAME%"=="" (
	@echo ʹ�÷���:pgsqlbak ����
	set /p DB_NAME=���������:
	goto :start
)
:: �û���
set USER="postgres"
:: ����
set PGPASSWORD=123456

set PATH=%POSTGRESQL_DIR%;%WINRAR_DIR%;%PATH%
set DBBAK_DIR=%BAK_SYMBOL%%BAK_PATH%
cd /d %BAK_SYMBOL%/
if not exist %BAK_PATH% (
	@echo ��������Ŀ¼
	md %BAK_PATH%
)


@echo ���ڱ������ݿ�...
@echo.

:: �����ǻ�õ�ǰϵͳʱ������e.g. 20120503101305
:: ��
set myyy=%date:~0,4%
:: ��
set mymm=%date:~5,2%
:: ��
set mydd=%date:~8,2%

@echo %myyy% %mymm% %mydd%

set /a TODAY=%date:~0,4%%date:~5,2%%date:~8,2%
set _TIME=%time:~0,8%
::@echo %_TIME%
set CURRENTTIME=%_time::=%
set CURRENTTIME=%CURRENTTIME: =0%
set MYDATETIME=%TODAY%%CURRENTTIME%
::@echo %MYDATETIME%

:: ʹ��PostgreSQL�ṩ��pg_dump����������ݿ⵼��Ϊ.sql�ļ�
pg_dump -h localhost -p 5432 -U %USER% %DB_NAME% >%DBBAK_DIR%\%DB_NAME%_%MYDATETIME%_%DBMS_NAME%.sql


@echo ����ѹ�����ݽ��...
@echo.
:: ���ѹ��(-m5)����ʵѹ��(-s)�����������ų�·��(��������·���а������ļ��У�-ep)
:: ѹ����ɾ���ļ�������վ(-dr)��ѹ����ɾ���ļ�(-df)
rar a %DBBAK_DIR%\%DB_NAME%_%MYDATETIME% %DBBAK_DIR%\%DB_NAME%_%MYDATETIME%_%DBMS_NAME%.sql -m5 -s -ep -dr

:: ɾ��7��ǰ���ļ�
forfiles /p %DBBAK_DIR% /s /m *.* /d -7 /c "cmd /c del @path"

:: ɾ�����ɵ�sql�ļ����������ã�ֱ��ʹ��rar�������ɾ��������ȫ��
::@echo ����ɾ����ʱ�ļ�...
::del %DBBAK_DIR%\%DB_NAME%_*.sql

:: ��������˳�
:: PAUSE

exit