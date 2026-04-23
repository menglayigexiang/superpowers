@echo off
:: 有中文，需要设置编码为UTF-8
chcp 65001 > nul 2>&1

setlocal enabledelayedexpansion
:: =======================================================
:: 复制 skills 文件夹到 .trae 和 .trae-cn 目录
:: =======================================================


:: ================== 请在这里修改路径 ==================
:: 获取当前脚本所在目录的上一层目录的子目录 skills

set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR_PARENT=%~dp0.."
set "SOURCE_FOLDER=%SCRIPT_DIR_PARENT%\skills"

set "SOURCE_DIR_UserRules=%SCRIPT_DIR_PARENT%\user_rules"

:: =======================================================

echo 正在复制文件夹...

set "overallRc=0"
call :CopyFolder "%SOURCE_FOLDER%" "C:\Users\ALSONTECH2020\.trae-cn\skills" || set "overallRc=1"
call :CopyFolder "%SOURCE_FOLDER%" "C:\Users\ALSONTECH2020\.trae\skills" || set "overallRc=1"
call :CopyFolder "%SOURCE_DIR_UserRules%" "C:\Users\ALSONTECH2020\.trae-cn\user_rules" || set "overallRc=1"
call :CopyFolder "%SOURCE_DIR_UserRules%" "C:\Users\ALSONTECH2020\.trae\user_rules" || set "overallRc=1"



pause
exit /b %overallRc%














:CopyFolder
set "src=%~1"
set "dst=%~2"

echo 正在复制文件夹: %src% 到 %dst%

if not exist "%dst%" mkdir "%dst%" > nul 2>&1

xcopy "%src%" "%dst%\" /E /Y /H /R
set "rc=%errorlevel%"

if "%rc%"=="0" (
    echo.
    echo [成功] 已复制并覆盖到: %dst%
) else (
    echo.
    echo [错误] 复制失败 rc=%rc%，请检查路径是否正确: %dst%
)
exit /b %rc%
