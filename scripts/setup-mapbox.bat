@echo offSET "NETRC_PATH=%USERPROFILE%\.netrc"
SET "GRADLE_PROPERTIES_PATH=%USERPROFILE%\.gradle\gradle.properties"
IF "%1"==""

echo Usage: %0 YOUR_MAPBOX_ACCESS_TOKEN
echo No token provided. Exiting.
exit /b 1

SET "TOKEN=%1"
echo Configuring %NETRC_PATH% for Mapbox iOS SDK download
IF NOT EXIST "%NETRC_PATH%" (echo machine api.mapbox.com >> "%NETRC_PATH%"
echo login mapbox >> "%NETRC_PATH%"
echo password %TOKEN% >> "%NETRC_PATH%"
echo %NETRC_PATH% has been updated with new credentials) ELSE (powershell -Command "if (Select-String -Path '%NETRC_PATH%' -Pattern 'password') { (Get-Content '%NETRC_PATH%') -replace 'password .+', 'password %TOKEN%' | Set-Content '%NETRC_PATH%' } else { Add-Content -Path '%NETRC_PATH%' -Value 'machine api.mapbox.com'; Add-Content -Path '%NETRC_PATH%' -Value 'login mapbox'; Add-Content -Path '%NETRC_PATH%' -Value 'password %TOKEN%' }"
echo Token updated in %NETRC_PATH%)
echo Configuring %GRADLE_PROPERTIES_PATH% for Mapbox Android SDK download
IF NOT EXIST "%USERPROFILE%\.gradle" (mkdir "%USERPROFILE%\.gradle")
IF NOT EXIST "%GRADLE_PROPERTIES_PATH%" (echo MAPBOX_DOWNLOADS_TOKEN=%TOKEN% >> "%GRADLE_PROPERTIES_PATH%"
echo %GRADLE_PROPERTIES_PATH% has been updated with new credentials) ELSE (powershell -Command "if (Select-String -Path '%GRADLE_PROPERTIES_PATH%' -Pattern 'MAPBOX_DOWNLOADS_TOKEN') { (Get-Content '%GRADLE_PROPERTIES_PATH%') -replace 'MAPBOX_DOWNLOADS_TOKEN=.+', 'MAPBOX_DOWNLOADS_TOKEN=%TOKEN%' | Set-Content '%GRADLE_PROPERTIES_PATH%' } else { Add-Content -Path '%GRADLE_PROPERTIES_PATH%' -Value 'MAPBOX_DOWNLOADS_TOKEN=%TOKEN%' }"
echo Token updated in %GRADLE_PROPERTIES_PATH%)
exit /b 0
