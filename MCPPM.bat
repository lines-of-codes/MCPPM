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
REM BFCPEVERINCLUDE=0
REM BFCPEVERVERSION=1.0.0.0
REM BFCPEVERPRODUCT=Product Name
REM BFCPEVERDESC=Product Description
REM BFCPEVERCOMPANY=Your Company
REM BFCPEVERCOPYRIGHT=Copyright Info
REM BFCPEOPTIONEND
@ECHO ON
@echo off
goto :welcome

:welcome
cls
echo Welcome to MCPPM!
echo (Minecraft Plugin Project Manager)
echo http://susite.ga/mcppm
echo.
echo Please type your choice
echo 1) Create new Project
echo 2) Quit
set /p choice=
if %choice%==1 goto :newprj
if %choice%==2 exit /b
echo Invalid choice. Please try again.
goto :welcome

:newprj
cls
echo - Create new Project -
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
echo Illegal Plugin version or unsupport version. Please try again.
goto :pack-mcmeta

:packdesc
set /p pkgdesc=Plugin description: 
goto :mcns

:setpackformat
set packformat=%~1
goto :packdesc

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
if %confirm%==cancel goto :welcome

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
echo { "pack": { "pack_format": %packformat%, "description": "%pkgdesc%" } } > pack.mcmeta
mkdir data
cd data
mkdir %mcpns%
cd %mcpns%
mkdir functions
cd functions
echo. 2>tick.mcfunction
echo tellraw @a {"text": "%mcpns% has been loaded."} > load.mcfunction
cd ..
cd ..
mkdir minecraft
cd minecraft
mkdir tags
cd tags
mkdir functions
cd functions
echo { "values": ["%mcpns%:load"] } > load.json
echo { "values": ["%mcpns%:tick"] } > tick.json
echo Successfully create project.
pause
goto :welcome