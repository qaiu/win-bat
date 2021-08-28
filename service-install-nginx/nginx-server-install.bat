@echo off
pushd "%~dp0"
call nginx-service-xml-gen.bat
SC QUERY "nginx" > NUL
IF not ERRORLEVEL 1 GOTO EXIST

nginx-service install
sc start nginx
:EXIST
pause