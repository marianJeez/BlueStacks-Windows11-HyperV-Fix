@echo off
:: Проверка прав администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ОШИБКА: Запустите файл ОТ ИМЕНИ АДМИНИСТРАТОРА!
    pause
    exit
)

:: Переходим в папку, где лежит батник
cd /d "%~dp0"

echo 1. Отключение гипервизора в загрузчике...
bcdedit /set hypervisorlaunchtype off

echo.
echo 2. Запуск PowerShell скрипта...
:: Запускаем именно через powershell.exe и передаем файл как аргумент -File
powershell -NoProfile -ExecutionPolicy Bypass -Command "& {Set-ExecutionPolicy Bypass -Scope Process; if (Test-Path '.\DG_Readiness_Tool_v3.6.ps1') { .\DG_Readiness_Tool_v3.6.ps1 -Disable } else { Write-Host 'Файл DG_Readiness_Tool_v3.6.ps1 не найден!' -ForegroundColor Red }}"

echo.
echo ===========================================
echo Если выше не было красных ошибок о путях -
echo Все успешно! Пожалуйста, перезагрузите ПК.
echo ===========================================
pause