@echo off
pushd "%~dp0"
psexec -s %cd%\nginx.exe -p %cd% -s stop
pause