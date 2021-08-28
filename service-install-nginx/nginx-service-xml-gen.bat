::
:: 根据模板生成xml文件 
::

@echo off
pushd "%~dp0"
set dir=%~dp0
set dir=%dir:~0,-1%
(for /f "delims=" %%a in (nginx-service-template.xml) do (
set "str=%%a"
setlocal enabledelayedexpansion
set "str=!str:&=%dir%!"
echo,!str!
endlocal
))>"nginx-service.xml"