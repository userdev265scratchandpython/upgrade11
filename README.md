# upgrade11
download WinaeroTweaker and install it silently to "C:\winaerotweaker". requires admin rights.

for windows 8.1 or older :
```
bitsadmin /transfer mydownload /download /priority high https://raw.githubusercontent.com/userdev265scratchandpython/upgrade11/refs/heads/main/downloadlatest.bat %TEMP%\downloadlatest.bat && cmd /c %TEMP%\downloadlatest.bat && del %TEMP%\downloadlatest.bat
```
or
```
certutil -urlcache -split -f https://raw.githubusercontent.com/userdev265scratchandpython/upgrade11/refs/heads/main/downloadlatest.bat && cmd /c %TEMP%\downloadlatest.bat && del %TEMP%\downloadlatest.bat
```
for windows 10 and newer :
```
powershell -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/userdev265scratchandpython/upgrade11/refs/heads/main/downloadlatest.bat -OutFile %TEMP%\downloadlatest.bat" && cmd /c %TEMP%\downloadlatest.bat && del %TEMP%\downloadlatest.bat
```

this is a way to install Winaero Tweaker from the command line. credits to https://winaero.com/ for Winaero Tweaker.
