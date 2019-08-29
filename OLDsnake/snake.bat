@echo off
setlocal enabledelayedexpansion
::I always have this first goto for debugging and stuff
goto FirstRun

::Honestly the main and firstrun are just artifacts I havent bothered to clean up
::Main checks for snakesetup, which should tell if all the variables have been initialized in render setup
:FirstRun
set snakesetup=f
goto Main
:Main
title Snake Game
::goto rendersetup
::set snakesetup=f
if %snakesetup%==t goto run0start
cls
goto rendersetup

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
goto run2
:runS
set lastchoice=s
goto run2
:runA
set lastchoice=a
goto run2
:runW
set lastchoice=w
goto run2

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

:run2checkforo
::checks if the temp variable set by run 2 (looking for the head) is o (the head)
if %poscheck%==o (
	::echo found head
	set oposfound=%poscheckpos%
	set oposfoundA=%poscheckpos:~0,1%
	set oposfoundB=%poscheckpos:~1,1%
	rem ::NOTE:: this goto render is for debugging   
	rem echo %oposfoundA% and %oposfoundB%
	::goto render
	goto run3
)
goto :eof

:run4testforposition
::will it blend? anyways this just checks if the map position saved as poscheck2 is equal to updatedpos (where the head should move)
if %poscheck2pos%==%updatedpos% (
	set poscheck2true=t
)
goto :eof

:run5checkforoldpos
:: checks if last saved of old postition and current temp check are the same
if %poscheck3%==%oposfound% (
	set poscheck3true=t
)
goto :eof

:run2
::find the head man
set poscheck=temp
set poscheck=%aa%
set poscheckpos=aa
call :run2checkforo
set poscheck=%ab%
set poscheckpos=ab
call :run2checkforo
set poscheck=%ac%
set poscheckpos=ac
call :run2checkforo
set poscheck=%ba%
set poscheckpos=ba
call :run2checkforo
set poscheck=%bb%
set poscheckpos=bb
call :run2checkforo
set poscheck=%bc%
set poscheckpos=bc
call :run2checkforo
set poscheck=%ca%
set poscheckpos=ca
call :run2checkforo
set poscheck=%cb%
set poscheckpos=cb
call :run2checkforo
set poscheck=%cc%
set poscheckpos=cc
call :run2checkforo

echo this is a "failsafe" in run2
goto run3

:run3
:: Find if the head can move and then find where it would move to
::echo run3bb %poscheck%
set failmove=f
if %lastchoice%==w (
	if %oposfoundA%==a (
		echo cannot move up
		set failmove=t
	)
	if %oposfoundA%==b (
		set oposfoundA=a
	)
	if %oposfoundA%==c (
		set oposfoundA%=b
	)
)
if %lastchoice%==s (
	if %oposfoundA%==c (
		echo cannot move down
		set failmove=t
	)
	if %oposfoundA%==b (
		set oposfoundA=c
	)
	if %oposfoundA%==c (
		set oposfoundA=a
	)
)
if %lastchoice%==a (
	if %oposfoundB%==a (
		echo cannot move left
		set failmove=t
	)
	if %oposfoundB%==b (
		set oposfoundB=a
	)
	if %oposfoundB%==c (
		set oposfoundB=b
	)
)
if %lastchoice%==d (
	if %oposfoundB%==c (
		echo cannot move right
		set failmove=t
	)
	if %oposfoundB%==b (
		set oposfoundB=c
	)
	if %oposfoundB%==a (
		set oposfoundB=b
	)
)
goto run4

:run4
::updated the map with the new position
set poscheck2=temp
set poscheck2true=f
if %failmove%==t (
	goto render)
set updatedpos=%oposfoundA%%oposfoundB%

set poscheck2=%aa%
set poscheck2pos=aa
call :run4testforposition
if %poscheck2true%==t (
	set aa=o
)
set poscheck2=%ab%
set poscheck2pos=ab
call :run4testforposition
if %poscheck2true%==t (
	set ab=o
)
set poscheck2=%ac%
set poscheck2pos=ac
call :run4testforposition
if %poscheck2true%==t (
	set ac=o
)
set poscheck2=%ba%
set poscheck2pos=ba
call :run4testforposition
if %poscheck2true%==t (
	set ba=o
)
set poscheck2=%bb
set poscheck2pos=bb
call :run4testforposition
if %poscheck2true%==t (
	set bb=o
)
set poscheck2=%bc%
set poscheck2pos=bc
call :run4testforposition
if %poscheck2true%==t (
	set bc=o
)
set poscheck2=%ca%
set poscheck2pos=ca
call :run4testforposition
if %poscheck2true%==t (
	set ca=o
)
set poscheck2=%cb%
set poscheck2pos=cb
call :run4testforposition
if %poscheck2true%==t (
	set cb=o
)
set poscheck2=%cc%
set poscheck2pos=cc
call :run4testforposition
if %poscheck2true%==t (
	set cc=o
)
::NOTE: RENDER FOR DEBUG
::goto render
goto run5

:run5
:: this removes the last position of the head
echo %oposfound%
set poscheck3=tempp
set poscheck3true=f

set poscheck3=%aa%
call :run5checkforoldpos
if %poscheck3true%==t (
	set aa=u
)
set poscheck3=%ab%
call :run5checkforoldpos
if %poscheck3true%==t (
	set ab=u
)
set poscheck3=%ac%
call :run5checkforoldpos
if %poscheck3true%==t (
	set ac=u
)
set poscheck3=%ba%
call :run5checkforoldpos
if %poscheck3true%==t (
	set ba=u
)
set poscheck3=%bb%
call :run5checkforoldpos
if %poscheck3true%==t (
	set bb=u
)
set poscheck3=%bc%
call :run5checkforoldpos
if %poscheck3true%==t (
	set bc=u
)
set poscheck3=%ca%
call :run5checkforoldpos
if %poscheck3true%==t (
	set ca=u
)
set poscheck3=%cb%
call :run5checkforoldpos
if %poscheck3true%==t (
	set cb=u
)
set poscheck3=%cc%
call :run5checkforoldpos
if %poscheck3true%==t (
	set cc=u
)

echo poscheck 3 = %poscheck3% and true = %poscheck3true%
echo opos found = %oposfound%
::it is now done with game logic, time to render!
goto render

:: x=food   o=snake     u=blank
:rendersetup
::Sets the map
set snakesetup=t
set aa=u
set ab=u
set ac=u
set ba=u
set bb=o
set bc=u
set ca=u
set cb=u
set cc=u
goto Main









