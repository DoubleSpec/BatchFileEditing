@echo off
goto Main

:Main
::Theres some commented out code here from my attempts at using the errorlevel return code from the choice statement. I also don't know how to get "set" to work after using if %ERRORLEVEL%. Anyways this just checks from highest to lowest which return code it got because it works from if equal to or greater than
echo Save, load, create, or delete fam
echo You can also look at whats in the directory of this batch file with "E"
title Variable Manipulation Tester
set ertm=0
choice /c SLCDE /m Pick_one
if %ERRORLEVEL% == 5 goto Check
if %ERRORLEVEL% == 4 goto Delete
if %ERRORLEVEL% == 3 goto Create
if %ERRORLEVEL% == 2 goto Load
if %ERRORLEVEL% == 1 goto Save
::if errorlevel 1 set %ertm%=s
::if errorlevel 2 set %ertm%=l
::if %ertm%==0 echo what up
::pause
::if %ertm%==2 goto Load
::if %errm%==1 goto Save

:Check
dir
pause
goto Main

:Save
:: This setlocal is for when I try to edit a variable in the if exist block. As of rn i dont think it helped
::setlocal EnableDelayedExpansion
set vari=variablevaribugged
:: This asks for and checks for the file to save to, otherwise return to menu
echo What text file would you like to overwrite to? Just write the name only.
set /p ufileinput=_
if exist %ufileinput%.txt (
	echo The file has been found.
) else (
	echo No file of the name "%ufileinput%.txt" exists.
	pause
	cls
	goto main
)
:: This takes a users input, saves it to a variable, and then uses that variable to be entered into the file SLTvar.txt
echo Enter the text data to save
:: set uvar=%uservarinput%
set/p uservarinput=_
set vari=%uservarinput%
@echo %vari%>%ufileinput%.txt
echo The data entry "%vari%" has been saved in %ufileinput%.txt
pause
cls
goto main

::NOTE:: below is unused code heaven forbid it executes
:: This takes a users input, saves it to a variable, and then uses that variable to be entered into the file SLTvar.txt
echo enter the variable to save
:: set uvar=%uservarinput%
set/p uservarinput=_
set vari=%uservarinput%
@echo %vari%>SLTvar.txt
echo The data entry "%vari%" has been saved in SLTvar.txt
pause
goto Main

:Load
:: Checks for and stores title name
echo What text file would you like to read from?
set /p ufileinput=_
if exist %ufileinput%.txt (
	echo The file was found.
) else (
	echo No txt file of that name was found.
	pause
	goto main
)
:: This loads the text data within file
set vari=temp
set/p vari=<%ufileinput%.txt
echo The file %ufileinput%.txt reads: %vari%
pause
cls
goto Main

:Create
:: This takes a user input, checks for the files existance, and if it finds nothing it will create said file
echo What file name would you like to create? It will automatically be set to ".txt" 
set /p ufileinput=_
if exist %ufileinput%.txt (
::BUG:: typing wih spaces didnt create the file but proceeded execution with the echo below
	echo File with same name already exists within this directoy.
	pause
	goto Main
) else (
	echo. 2>%ufileinput%.txt
	echo File %ufileinput%.txt has been created
	pause
)
cls
goto Main

:Delete 
:: This checks for and deletes a file if it finds it
echo What file would you like to delete? It will only look for ".txt" files.
set /p ufileinput=_
if exist %ufileinput%.txt (
	del %ufileinput%.txt
	echo The file has been deleted
	pause
) else (
	echo No file of the name "%ufileinput%.txt" exists.
	pause
)
cls
goto Main















