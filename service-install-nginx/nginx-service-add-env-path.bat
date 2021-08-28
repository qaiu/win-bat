@echo off

set dir=%~dp0
set dir=%dir:~0,-1%

echo %PATH% | findstr /c:%dir%>nul
if %errorlevel% equ 1 set PATH=%PATH%;%dir%

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "Path" /t REG_EXPAND_SZ /d "%PATH%" /f

pause