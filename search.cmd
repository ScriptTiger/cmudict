@echo off

rem =====
rem For more information on ScriptTiger and more ScriptTiger scripts visit the following URL:
rem https://scripttiger.github.io/
rem Or visit the following URL for the latest information on this ScriptTiger script:
rem https://github.com/ScriptTiger/cmudict
rem =====

title ScriptTiger CMU Dictionary Search
echo ScriptTiger CMU Dictionary Search
echo Copyright (c) 2019 ScriptTiger
echo.
goto skip_license

MIT License

Copyright (c) 2019 ScriptTiger

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

:skip_license
set ini=search.ini
set cmudict=cmudict.dict
set phones=cmudict.phones
if exist %ini% for /f "tokens=*" %%0 in (%ini%) do set %%~0
if not exist "%cmudict%" echo Cannot find the CMU dictionary file!&pause&exit /b
if not exist "%phones%" echo Cannot find the CMU phones file!&pause&exit /b
set find=findstr /b /r /i

:0
echo 1] Search by word
echo 2] Search by sound
echo 3] View the list of phones
echo X] Exit
choice /c 123x /n
cls
goto %errorlevel%

:1
set /p search=Search what word? || goto 0
set search=%find% "^%search%[^a-z]" "%cmudict%"
goto search

:2
set /p search=Search what sound? || goto 0
set search=%search: =.%
if "%search:~,1%"=="$" (
	set search=%find% "^[a-z][a-z]*[^a-z,',-]%search:~1%" "%cmudict%"
) else (
	set search=%find% "^[a-z][a-z]*[^a-z,',-].*%search%" "%cmudict%"
)
goto search

:3
more "%phones%"
goto 0

:4
exit /b

:search
%search% | more
choice /m "Save results to file?"
if %ERRORLEVEL%==2 goto 0
set /p input=Name of file to export results to? || goto 0
%search% > %input%.txt
goto 0
