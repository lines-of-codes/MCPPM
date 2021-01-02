@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=
REM BFCPEICON=
REM BFCPEICONINDEX=-1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=0
REM BFCPEINVISEXE=0
REM BFCPEVERINCLUDE=1
REM BFCPEVERVERSION=1.0.0.1
REM BFCPEVERPRODUCT=MCPPM
REM BFCPEVERDESC=Minecraft Plugin Project Manager
REM BFCPEVERCOMPANY=S Universal Group
REM BFCPEVERCOPYRIGHT=Protected under GNU GPL 3.0
REM BFCPEOPTIONEND
@ECHO ON
@echo off
goto :welcome

:welcome
title Home page - MCPPM
cls
echo Welcome to MCPPM!
echo (Minecraft Plugin Project Manager)
echo http://susite.ga/mcppm
echo.
echo Please type your choice
echo 1) Create new Project
echo 2) Settings and Help
echo 3) Quit
set /p choice=
if %choice%==1 goto :newprj
if %choice%==2 goto :prgsettings
if %choice%==3 exit /b
echo Invalid choice. Please try again.
goto :welcome

:prgsettings
title Settings - MCPPM
cls
echo \\ Settings
echo MCPPM Settings
echo 1) About
echo 2) Documentation
echo 3) Code editor
echo 4) Back
set /p choice=Choice: 
if %choice%==1 goto :about
if %choice%==2 goto :doc
if %choice%==3 goto :cesettings
if %choice%==4 goto :welcome
echo Invalid choice. Please try again.
goto :prgsettings

:about
title About - MCPPM
cls
echo \\ About
echo MCPPM - Minecraft Plugin Project Manager
echo Version 1.1.0.0
echo Developed by S Universal Group (LinesOfCodes)
echo Protected under GNU GPL 3.0
echo Made using Batch.
echo Official Website - http://susite.ga/mcppm
pause
goto :prgsettings

:doc
explorer https://github.com/lines-of-codes/MCPPM/wiki
goto :prgsettings

:cesettings
cls
echo \\ MCPPM Code Editor Settings
echo Sorry, At this time, MPPCE is not available.
pause
goto :prgsettings

:newprj
title Create new Project - MCPPM
cls
echo - Create new Project -
echo Project type: Minecraft Datapack
echo 1. Specify Plugin Location.
echo Type 'current' for current directory (Without Quotes)
set /p plocation=Location: 
goto :pack-mcmeta

:pack-mcmeta
echo 2. Creating pack.mcmeta
set /p packfor=For minecraft version (NOT support snapshot): 

if %packfor%==1.16.4 call :setpackformat 6 && exit /b
if %packfor%==1.16.3 call :setpackformat 6 && exit /b
if %packfor%==1.16.2 call :setpackformat 6 && exit /b

if %packfor%==1.16.1 call :setpackformat 5 && exit /b
if %packfor%==1.16 call :setpackformat 5 && exit /b
if %packfor%==1.15.2 call :setpackformat 5 && exit /b
if %packfor%==1.15.1 call :setpackformat 5 && exit /b
if %packfor%==1.15 call :setpackformat 5 && exit /b

if %packfor%==1.14.4 call :setpackformat 4 && exit /b
if %packfor%==1.14.3 call :setpackformat 4 && exit /b
if %packfor%==1.14.2 call :setpackformat 4 && exit /b
if %packfor%==1.14.1 call :setpackformat 4 && exit /b
if %packfor%==1.14 call :setpackformat 4 && exit /b
if %packfor%==1.13.2 call :setpackformat 4 && exit /b
if %packfor%==1.13.1 call :setpackformat 4 && exit /b
if %packfor%==1.13 call :setpackformat 4 && exit /b
echo Illegal Minecraft version or unsupport version. Please try again.
goto :pack-mcmeta

:setpackformat
set packformat=%~1
call :packdesc
exit /b

:packdesc
set /p pkgdesc=Plugin description: 
goto :mcns

:mcns
echo 3. Create First Namespace
set /p mcpns=Datapack Namespace: 
goto :confirm

:confirm
cls
echo Confirm Information.
echo Project directory: %plocation%
echo pack.mcmeta
echo For version: %packfor%
echo Pack format: %packformat%
echo Plugin description: %pkgdesc%
echo Data
echo Namespace: %mcpns%
echo.
echo Please type 'confirm' to confirm. (Without Quotes)
echo Or type 'cancel' to cancel. (Without Quotes)
set /p confirm=
if %confirm%==confirm goto :checkflocation
if %confirm%==cancel goto :welcome && exit /b

:checkflocation
cls
if %plocation%==current goto :writeinf
if not exist %plocation% goto :createfolderconfirm
cd /d %plocation%
goto :writeinf

:createfolderconfirm
echo Directory you typed does not exist. Do you want to create new folder? (yes/no/manual)
echo Info: 'manual' means you create folder yourself.
echo Info: 'no' choice will let you change project location.
set /p choice=
if %choice%==yes goto :createfolder
if %choice%==no goto :retypedir
if %choice%==manual goto :createfoldermanual

:createfolder
echo Please type the location you want to create new folder.
set /p newflocation=
echo Please type new folder name in plain text.
set /p newpfname=
cd %newflocation%
mkdir %newpfname%
set plocation=%newflocation%\%newpfname%
goto :checkflocation

:createfoldermanual
echo You choose to create folder manually. Please create folder you typed in.
echo You typed: %plocation%
echo Type 'cl' to Change location Or type 'cancel' to cancel.
echo Press <enter> to begin checking directory & creating project.
set /p choice=
if %choice%==cl goto :retypedir
if %choice%==cancel goto :welcome
goto :checkflocation

:retypedir
echo Then please retype your project location.
echo Type 'cancel' to cancel. (Without Quotes)
set /p plocation=
if %plocation%==cancel goto :welcome

:writeinf
rem GetPercent 1 12
echo Progress done: %result%
echo Creating pack.mcmeta...
echo { "pack": { "pack_format": %packformat%, "description": "%pkgdesc%" } } > pack.mcmeta
rem GetPercent 2 12
echo Progress done: %result%
echo Creating data folder...
mkdir data
cd data
rem GetPercent 3 12
echo Progress done: %result%
echo Creating Namespace folder...
mkdir %mcpns%
cd %mcpns%
rem GetPercent 4 12
echo Progress done: %result%
echo Creating functions folder...
mkdir functions
cd functions
rem GetPercent 5 12
echo Progress done: %result%
echo Creating tick.mcfunction...
echo. 2>tick.mcfunction
rem GetPercent 6 12
echo Progress done: %result%
echo Creating load.mcfunction...
echo tellraw @a {"text": "%mcpns% has been loaded."} > load.mcfunction
cd ..
cd ..
rem GetPercent 7 12
echo Progress done: %result%
echo Creating minecraft folder...
mkdir minecraft
cd minecraft
rem GetPercent 8 12
echo Progress done: %result%
echo Creating tags folder...
mkdir tags
cd tags
rem GetPercent 9 12
echo Progress done: %result%
echo Creating functions folder...
mkdir functions
cd functions
rem GetPercent 10 12
echo Progress done: %result%
echo { "values": ["%mcpns%:load"] } > load.json
rem GetPercent 11 12
echo Progress done: %result%
echo Creating tick.mcfunction...
echo { "values": ["%mcpns%:tick"] } > tick.json
echo Successfully create project.
pause
goto :welcome && exit /b