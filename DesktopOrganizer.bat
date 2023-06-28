@echo off
set desktopPath=%UserProfile%\Desktop
set organizedPath=%UserProfile%\Desktop\Organized
set documentsPath=%UserProfile%\Documents
set scriptName=%~nx0

:: Ensure the Organized directory exists
if not exist "%organizedPath%" (
    mkdir "%organizedPath%"
)

:: Create subfolders for each file type in Organized
for %%X in (Images, PDFs, Documents, Zip, Other, NoExt, Exe, Rar, Mp3, Txt, Html) do (
    if not exist "%organizedPath%\%%X" (
        mkdir "%organizedPath%\%%X"
    )
)

:: Copy and then remove the files
for %%F in ("%desktopPath%\*") do (
    if /I "%%~nxF"=="%scriptName%" (
        echo Skipping batch script file...
    ) else (
        if /I "%%~xF"==".png" (
            xcopy /Y "%%F" "%organizedPath%\Images\" && del /F /Q "%%F"
        ) else if /I "%%~xF"==".jpg" (
            xcopy /Y "%%F" "%organizedPath%\Images\" && del /F /Q "%%F"
        ) else if /I "%%~xF"==".jpeg" (
            xcopy /Y "%%F" "%organizedPath%\Images\" && del /F /Q "%%F"
        ) else if /I "%%~xF"==".pdf" (
            xcopy /Y "%%F" "%organizedPath%\PDFs\" && del /F /Q "%%F"
        ) else if /I "%%~xF"==".docx" (
            xcopy /Y "%%F" "%documentsPath%" && del /F /Q "%%F"
        ) else if /I "%%~xF"==".zip" (
            xcopy /Y "%%F" "%organizedPath%\Zip\" && del /F /Q "%%F"
        ) else if "%%~xF"=="" (
            xcopy /Y "%%F" "%organizedPath%\NoExt\" && del /F /Q "%%F"
        ) else if /I "%%~xF"==".exe" (
            xcopy /Y "%%F" "%organizedPath%\Exe\" && del /F /Q "%%F"
        ) else if /I "%%~xF"==".rar" (
            xcopy /Y "%%F" "%organizedPath%\Rar\" && del /F /Q "%%F"
        ) else if /I "%%~xF"==".mp3" (
            xcopy /Y "%%F" "%organizedPath%\Mp3\" && del /F /Q "%%F"
        ) else if /I "%%~xF"==".txt" (
            xcopy /Y "%%F" "%organizedPath%\Txt\" && del /F /Q "%%F"
        ) else if /I "%%~xF"==".html" (
            xcopy /Y "%%F" "%organizedPath%\Html\" && del /F /Q "%%F"
        ) else (
            xcopy /Y "%%F" "%organizedPath%\Other\" && del /F /Q "%%F"
        )
    )
)

pause
:: Copy and then remove the folders
for /D %%D in ("%desktopPath%\*") do (
    if /I not "%%~nxD"=="Organized" (
        xcopy /E /I /Y "%%D" "%organizedPath%\Other Folders\%%~nxD\" && rd /S /Q "%%D"
    )
)
