@echo off
pushd "%~dp0"
echo %~dp0

psexec -s %cd%\nginx.exe -p %cd% -s reload

pause