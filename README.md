# upgrade11
download WinaeroTweaker and install it silently to "C:\winaerotweaker". requires admin rights.

for windows 8.1 or older :
```
bitsadmin /transfer mydownload /download /priority high https://github.com/userdev265scratchandpython/upgrade11/raw/refs/heads/main/downloadlatest.bat %TEMP%\downloadlatest.bat && cmd /c %TEMP%\downloadlatest.bat && del %TEMP%\downloadlatest.bat
```
or
```
certutil -urlcache -split -f https://github.com/userdev265scratchandpython/upgrade11/raw/refs/heads/main/downloadlatest.bat %TEMP%\downloadlatest.bat && cmd /c %TEMP%\downloadlatest.bat && del %TEMP%\downloadlatest.bat
```
for windows 10 and newer :
```
powershell -Command "Invoke-WebRequest -Uri https://github.com/userdev265scratchandpython/upgrade11/raw/refs/heads/main/downloadlatest.cmd -OutFile %TEMP%\downloadlatest.cmd" && cmd /c %TEMP%\ie11load.bat && del %TEMP%\ie11load.bat
```

this is a way to install Winaero Tweaker from the command lign. credits to https://winaero.com/ for Winaero Tweaker.
