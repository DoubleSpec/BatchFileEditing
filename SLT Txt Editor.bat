@echo off
goto Main
::^for easy testing
:Main
set ufileinput=tmp
set uservarinput=tmp
set usertxtinput=tmp
cls
::Original version "SaveLTest" finished on 1/4/2019. First real batch thing I wrote. Last edit to this on 1/5/2019
::Theres some commented out code here from my attempts at using the errorlevel return code from the choice statement. I also don't know how to get "set" to work after using if %ERRORLEVEL%. Anyways this just checks from highest to lowest which return code it got because it works from if equal to or greater than
title SLT Text Editor
echo Welcome to the SLT Text Editor! CodedBySheep (shh I know its scripting)
echo A batch (and thus dos compatible only) txt file editor. It can create, delete, save to and load from the first line of any text file in the same directory. Save and load are simple and do only what the name implies, however edit is a combination of them all. If you're unsure what files are in the directory of this program, theres an option to list the contents.
echo You can select by pressing the first letter of each options name.
:Choice
:: This choice label is here so you can use "files" and then go back to this to do other work without clearing the screen or filling it with intro text
::set ertm=0
choice /c SLCDEF /m "Save, Load, Create, Delete, Edit, or Files"
if %ERRORLEVEL% == 6 goto Files
if %ERRORLEVEL% == 5 goto Edit
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
::So Files uh, crazy hard stuff ik so like. It's the dir command. W o a h, my 17 yr old brain can't handle this WOihwuawdawdgwse4f
::Also fun useless note I have a headache rn this is just fun to work on tho.
:Files
dir
pause
goto Choice
:Save
:: This setlocal is for when I try to edit a variable in the if exist block. As of rn i dont think it helped
::setlocal EnableDelayedExpansion
set vari=temp
:: This asks for and checks for the file to save to, otherwise return to menu
echo What text file would you like to overwrite to? Just write the name only.
set /p ufileinput=_
if exist "%ufileinput%.txt" (
	echo The file has been found.
) else (
	echo Could not find "%ufileinput%.txt" in this directory.
	pause
	goto Main
)
:: This takes a users input, saves it to a variable, and then uses that variable to be entered into the file
echo Enter the text data to save. (This deletes anything already there)
:: set uvar=%uservarinput%
set/p uservarinput=_
set vari="%uservarinput%"
@echo "%vari%">"%ufileinput%.txt"
echo The data entry "%vari%" has been saved in %ufileinput%.txt
pause
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
:: what a big load uwu IM SORRY I HAD TO OK. If you're reading this, you either have a sick sense of fun like me or could use some humor.
:Load
:: Checks for and stores title name
echo What text file would you like to read from?
set /p ufileinput=_
if exist "%ufileinput%.txt" (
	echo The file was found.
) else (
	echo No txt file of that name was found.
	pause
	goto main
)
:: This loads the text data within file
set vari=temp
set/p vari=<"%ufileinput%.txt"
echo The first line of the file %ufileinput%.txt reads:%vari%
pause
goto Main
:Create
:: This takes a user input, checks for the files existance, and if it finds nothing it will create said file
echo What text file would you like to create? Type type the name only.
set /p ufileinput=_
if exist "%ufileinput%.txt" (
	echo File with same name already exists within this directoy.
) else (
	echo. 2>"%ufileinput%.txt"
	echo File %ufileinput%.txt has been created
)
pause
goto Main
:Delete 
:: This checks for and deletes a file if it finds it
echo What file would you like to delete? It will only look for ".txt" files.
set /p ufileinput=_
if exist "%ufileinput%.txt" (
	del "%ufileinput%.txt"
	echo The file has been deleted.
) else (
	echo No file of the name "%ufileinput%.txt" exists.
)
pause
goto Main
::PHAT NOTE:: DELETE THE EMPTY LINES AT THE END OF THIS FILE
:Edit
::This is supposed to be like all the features in one
setlocal enabledelayedexpansion
echo What text file would you like to edit?
set /p ufileinput=_
if exist "%ufileinput%.txt" (
	goto Edit2
) else (
	echo Could not find "%ufileinput%.txt"
	echo Would you like to create this file or return to menu?
	choice /c CM
	if %ERRORLEVEL% == 1 (
		if %ERRORLEVEL% == 2 (
			goto Main
		)
	)
	echo. 2>"%ufileinput%.txt"
	echo File "%ufileinput%.txt" was created. Edit or return to menu?
	choice /c EM
	if %ERRORLEVEL% == 1 (
		if %ERRORLEVEL% == 2 (
			goto Main
		)
	)
)
:Edit2
cls
set/p vari=<"%ufileinput%.txt"
echo The file "%ufileinput%" reads:"%vari%"
echo What would you like to overwrite with?
set/p usertxtinput=_
set vari="%uservarinput%"
@echo "%vari%">"%ufileinput%.txt"
echo The file has been overwritten.
pause
goto Main























::PHAT NOTE:: DELETE THE EMPTY LINES AT THE END OF THIS FILE
::Edit33
::This is supposed to be like all the features in one
::BUG:: IM REALLY TIRED BUT THE ALL I HAVE TO DO IS JUST FIX THE ERROR LEVELS I FORGOT ITS GREATER THAN OR EQUAL TO
echo What text file would you like to edit?
set /p ufileinput=_
if exist "%ufileinput%.txt" (
	goto Edit2
) else (
	echo Could not find "%ufileinput%.txt"
	echo Would you like to create this file or return to menu?
	choice /c CM
	if %ERRORLEVEL% == 2 (
	goto Main
	) else (
		echo. 2>"%ufileinput%.txt"
		echo File "%ufileinput%.txt" was created. Edit or return to menu?
		choice /c EM
		if %ERRORLEVEL% == 2 (
			goto Main
		) else (
			goto Edit2
		)
	)
)
::Edit233
cls
set /p vari=<"%ufileinput%.txt"
echo The file "%ufileinput%" reads:"%vari%"
echo What would you like to overwrite with?
set/p usertxtinput=_
@echo "%uservarinput%">"%ufileinput%.txt"
echo The file has been overwritten.
pause
goto Main