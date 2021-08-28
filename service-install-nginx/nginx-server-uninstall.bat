@echo off

SC QUERY "nginx" > NUL
IF ERRORLEVEL 1 GOTO NOTEXIST

pushd "%~dp0"
psexec -s %cd%\nginx.exe -p %cd% -s stop
sc delete nginx
:NOTEXIST
pause