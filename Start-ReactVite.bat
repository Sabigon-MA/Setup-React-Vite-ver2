@echo off
chcp 65001

:: PowerShell スクリプトのパス
set "psScript=%~dp0Create-ReactVite.ps1"

:: ドラッグ&ドロップされたパスがあるか
set "existingPath=%~1"

if "%existingPath%"=="" (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%psScript%"
) else (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%psScript%" -ExistingPath "%existingPath%"
)

pause
