@echo off
setlocal enabledelayedexpansion
::I always have this first goto for debugging and stuff
goto Main

::Honestly the main and firstrun are just artifacts I havent bothered to clean up
::Main checks for snakesetup, which should tell if all the variables have been initialized in render setup
:Main
title IDFK
goto Main2
::call :runthrumap0
::call :mapsetup
echo Welcome to a snake demo turned to a map and player movment demo. Have fun
pause
cls
:Main2
set failmove=f
call :setmap
set currenthdpos=bb
set currenthdposdata=%currenthdpos%
set aximovement=tmp






:movecheck
set currentcheckposX=%currenthdposdata:1,1%
set currentcheckposY=%currenthdposdata:2,1%


if %lastchoice%==w (
	set aximovement=vertical
	set /a OBcheckX=%currenthdposdataX%-1
	set /a OBcheckY=%currenthdposdataY%-1
	if %currentcheckposY%==0 (
		echo FAM U DON FUCKED MAN U CAN GO UP
		set failmove=t
	) else ( 
		set OBcheck2Y=%OB
		
		
		
	)	
)
:: CHECK FOR OBSTACLES





:makemove
set /a currentmoveY=%currentcheckposY%-1

:: o=head  u= empty  y=wall
:setmap
set aa=u00
set ab=y01
set ac=u02
set ba=u10
set bb=o11
set bc=u12
set ca=u20
set cb=u21
set cc=u22
goto :eof

:OBvarset
set a=0
set b=1
set c=2
set 0=a
set 1=b
set 2=c

:OBcheck
set currentcheckposX=%currenthdposdata:1,1%
set currentcheckposY=%currenthdposdata:2,1%
if %aximovement%==vertical (
	set /a randomcheck=%currentcheckposY%-1
	
	
	
	
	set randomcheck=!%randomcheck%!
	set randomcheck=!%currentcheckposX%!%randomcheck%
	if %randomcheck%==y
)
















































:run0start
::This waits for the first user input, then moves to run1 which auto moves for you
::comment out yourmovement later on  <nvm
echo your controls are "wasd"
choice /c wasd /n /m Your_Movement
if %errorlevel% == 4 goto runD
if %errorlevel% == 3 goto runS
if %errorlevel% == 2 goto runA
if %errorlevel% == 1 goto runW

:run1tick
::Either accepts user input or defaults to the last user input recorded. This is the games core tick
choice /c wasd /n /t 1 /d %lastchoice% /m Your_Movement
if %errorlevel% == 4 goto runD
if %errorlevel% == 3 goto runS
if %errorlevel% == 2 goto runA
if %errorlevel% == 1 goto runW
::this could be optmized theres a lot of repetition here but goto is the only command I could get to work with errorlevel 
::These set the last choice variable and start to render the scene
:runD
set lastchoice=d
goto logic1
:runS
set lastchoice=s
goto logic1
:runA
set lastchoice=a
goto logic1
:runW
set lastchoice=w
goto logic1

:render
::reads the variables and displays the map. Returns to run1 main loop
::cls
echo %aa%%ab%%ac%
echo %ba%%bb%%bc%
echo %ca%%cb%%cc%
goto run1tick

::for /x %%x in (1,1, 50) do echo %%x
::ok game logic goes here
::so find o, move in desired direction if possible

:logic1
::find, save pos of, and remove head
set oposfound=tmp
set oposfoundA=tmp
set oposfoundB=tmp
set oposmoveA=tt
set oposmoveB=tt
set loops=10
call :logic1loop
set oposmoveA=%oposfoundA%
set oposmoveB=%oposfoundB%
call :movecheck
echo jj %headposmoveA%%headposmoveB%
echo fff %oposfound%
goto render


:logic1loop
call :runthrumap1
if %runthru2%==o (
	set oposfound=%runthru%
	set oposfoundA=%runthru:~0,1%
	set oposfoundB=%runthru:~1,1%
	set %runthru%=u
)
set /a loops=%loops%-1
if %loops%==0 (
	goto :eof
)
goto logic1loop
::for /l %%G in (1, 1, 10) do (
:movecheck
:: Find if the head can move and then find where it would move to
::echo run3bb %poscheck%
if %lastchoice%==w (
	if %oposfoundA%==a (
		echo cannot move up
		set %oposfound%=o
		goto render
	)
	if %oposfoundA%==b (
		set oposmoveA=a
	)
	if %oposfoundA%==c (
		set oposmoveA=b
	)
)
if %lastchoice%==s (
	if %oposfoundA%==c (
		echo cannot move down
		set %oposfound%=o
		goto render
	)
	if %oposfoundA%==b (
		set oposmoveA=c
	)
	if %oposfoundA%==a (
		set oposmoveA=b
	)
)
if %lastchoice%==a (
	if %oposfoundB%==a (
		echo cannot move left
		set %oposfound%=o
		goto render
	)
	if %oposfoundB%==b (
		set oposmoveB=a
	)
	if %oposfoundB%==c (
		set oposmoveB=b
	)
)
if %lastchoice%==d (
	if %oposfoundB%==c (
		echo cannot move right
		set %oposfound%=o
		goto render
	)
	if %oposfoundB%==b (
		set oposmoveB=c
	)
	if %oposfoundB%==a (
		set oposmoveB=b
	)
)
goto :eof


:: x=food   o=snake  u=blank     
:mapsetup
::Sets the map
set aa=u
set ab=u
set ac=u
set ba=u
set bb=o
set bc=u
set ca=u
set cb=u
set cc=u
goto :eof

:runthrumap0
set runthru=tmp
set runthrupos=1
set maprunpos=0
set runthrulock=f
set runthru2=0
goto :eof

:runthrumap1
:: this is supposed to be a label that I can call upon to cycle through all the map positions remembering the last one saved
set maprunpos=1
if %runthrupos% LEQ %maprunpos% (
	if %runthrupos% EQU %maprunpos% (
		set runthru=aa
		set runthru2=%aa%
		set /a runthrupos+=1
		goto :eof
	)
)
set maprunpos=2
if %runthrupos% LEQ %maprunpos% (
	if %runthrupos% EQU %maprunpos% (
		set runthru=ab
		set runthru2=%ab%
		set /a runthrupos+=1
		goto :eof
	)
)
set maprunpos=3
if %runthrupos% LEQ %maprunpos% (
	if %runthrupos% EQU %maprunpos% (
		set runthru=ac
		set runthru2=%ac%
		set /a runthrupos+=1
		goto :eof
	)
)
set maprunpos=4
if %runthrupos% LEQ %maprunpos% (
	if %runthrupos% EQU %maprunpos% (
		set runthru=ba
		set runthru2=%ba%
		set /a runthrupos+=1
		goto :eof
	)
)
set maprunpos=5
if %runthrupos% LEQ %maprunpos% (
	if %runthrupos% EQU %maprunpos% (
		set runthru=bb
		set runthru2=%bb%
		set /a runthrupos+=1
		goto :eof
	)
)
set maprunpos=6
if %runthrupos% LEQ %maprunpos% (
	if %runthrupos% EQU %maprunpos% (
		set runthru=bc
		set runthru2=%bc%
		set /a runthrupos+=1
		goto :eof
	)
)
set maprunpos=7
if %runthrupos% LEQ %maprunpos% (
	if %runthrupos% EQU %maprunpos% (
		set runthru=ca
		set runthru2=%ca%
		set /a runthrupos+=1
		goto :eof
	)
)
set maprunpos=8
if %runthrupos% LEQ %maprunpos% (
	if %runthrupos% EQU %maprunpos% (
		set runthru=cb
		set runthru2=%cb%
		set /a runthrupos+=1
		goto :eof
	)
)
set maprunpos=9
if %runthrupos% LEQ %maprunpos% (
	if %runthrupos% EQU %maprunpos% (
		set runthru=cc
		set runthru2=%cc%
		set /a runthrupos+=1
		goto :eof
	)
)

set maprunpos=10
if %runthrupos% EQU %maprunpos% (
	set runthrulock=t
)
goto :eof






