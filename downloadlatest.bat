@echo off
setlocal

:: Define the temporary file to store task results
set "tempFile=%temp%\task_results.txt"

:: Download WinaeroTweaker
set "taskNickname=Downloading WinaeroTweaker"
echo %taskNickname%...
powershell -command "Invoke-WebRequest -Uri 'https://github.com/userdev265scratchandpython/upgrade11/raw/refs/heads/main/winaerotweaker.zip' -OutFile 'winaerotweaker.zip'"
if %errorlevel% neq 0 (
    echo %taskNickname%... FAIL > "%tempFile%"
    goto End
) 
echo %taskNickname%... OK > "%tempFile%"
cls

:: Extract WinaeroTweaker
set "taskNickname=Extracting WinaeroTweaker"
type "%tempFile%"
echo %taskNickname%...
powershell -command "Expand-Archive -Path 'winaerotweaker.zip' -DestinationPath 'winaerotweaker'"
if %errorlevel% neq 0 (
    echo %taskNickname%... FAIL >> "%tempFile%"
    type "%tempFile%"
    goto End
) 
echo %taskNickname%... OK >> "%tempFile%"
cls

cd winaerotweaker

:: Create the installation directory if it doesn't exist
set "taskNickname=Creating installation directory"
type "%tempFile%"
echo %taskNickname%...
if not exist "C:\winaerotweaker" (
    mkdir "C:\winaerotweaker"
)
echo %taskNickname%... OK >> "%tempFile%"
cls

:: Set the setup application variable
set "SetupApp=WinaeroTweaker-1.63.0.0-setup.exe"

:: Check if the setup application exists
set "taskNickname=Installing WinaeroTweaker"
type "%tempFile%"
echo %taskNickname%...
if exist "%SetupApp%" (
    "%SetupApp%" /SP- /VERYSILENT /DIR="C:\winaerotweaker"
    if %errorlevel% neq 0 (
        echo %taskNickname%... FAIL >> "%tempFile%"
    ) else (
        echo %taskNickname%... OK >> "%tempFile%"
    )
) else (
    echo %taskNickname%... FAIL >> "%tempFile%"
)
cls

:: Clean up
cd ..
set "taskNickname=Cleaning up"
type "%tempFile%"
echo %taskNickname%...
del "winaerotweaker.zip" > nul 2>&1
if exist "winaerotweaker" (
    rmdir /s /q "winaerotweaker" > nul 2>&1
)
echo %taskNickname%... OK >> "%tempFile%"
cls

:: Navigate to the Desktop
cd "C:\Users\%username%\Desktop"

:: Check if the executable exists before creating the batch file
set "taskNickname=Creating launcher file"
if exist "C:\winaerotweaker\WinaeroTweaker.exe" (
    if exist "C:\Users\%username%\Desktop\winaero tweaker.lnk" (
        del C:\Users\%username%\Desktop\winaero tweaker.lnk
    )
    echo start "" "C:\winaerotweaker\WinaeroTweaker.exe" > winaerotweaker.bat
    echo exit /b >> winaerotweaker.bat
    echo %taskNickname%... OK >> "%tempFile%"
) else (
    echo %taskNickname%... FAIL >> "%tempFile%"
)
cls

:End
:: Display all task results
type "%tempFile%"

:: Clean up the temporary file
del "%tempFile%"

:: Manual message before exiting
echo Press any key to exit.
pause > nul