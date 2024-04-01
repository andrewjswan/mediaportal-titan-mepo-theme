@ECHO OFF

Title Creating MediaPortal MePo Theme Installer

ECHO Creating MediaPortal MePo Theme Installer

if "%programfiles(x86)%XXX"=="XXX" goto 32BIT
    :: 64-bit
    set PROGS=%programfiles(x86)%
    goto CONT
:32BIT
    set PROGS=%ProgramFiles%
:CONT

IF NOT EXIST "%PROGS%\Team MediaPortal\MediaPortal\" SET PROGS=C:

:: Get version from DLL
FOR /F "tokens=*" %%a IN ('git rev-list HEAD --count') DO SET version=%%a

:: Trim version
SET version=%version: =%

:: Set version
SET version=5.0.0.%version%

:: Temp xmp2 file
COPY MePoTheme.xmp2 MePoThemeTemp.xmp2

:: Build MPE1
"%PROGS%\Team MediaPortal\MediaPortal\MPEMaker.exe" "MePoThemeTemp.xmp2" /B /V=%version% /UpdateXML

:: Cleanup
IF NOT [%1] == [git] (DEL MePoThemeTemp.xmp2)
