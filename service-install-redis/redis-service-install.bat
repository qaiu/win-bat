@echo off
pushd "%~dp0"

SC QUERY "Redis" > NUL
IF not ERRORLEVEL 1 GOTO EXIST

redis-server.exe --service-install redis.windows.conf
:EXIST
redis-server.exe --service-start
pause