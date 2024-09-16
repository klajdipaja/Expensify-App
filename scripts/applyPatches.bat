@echo off
REM This script will run the patch-package command on every file under the AA directory.

set " PATCHES_DIR=%~dp0..\patches"

REM Check if the AA directory exists
if not exist "% PATCHES_DIR%" (
    echo "%PATCHES_DIR%"
)

REM Loop through each file in the AA directory and its subdirectories
for /r "%PATCHES_DIR%" %%f in (*) do (
    echo Running patch-package on %%f
    npx patch-package --error-on-fail --color=always --path "%%f"
    if %ERRORLEVEL% neq 0 (
        echo ERROR: patch-package failed on file %%f
        exit /b %ERRORLEVEL%
    )
)

echo All files processed successfully.
exit /b 0
