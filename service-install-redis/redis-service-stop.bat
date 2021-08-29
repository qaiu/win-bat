@echo off
pushd "%~dp0"

redis-server.exe --service-stop
pause