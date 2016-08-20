@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

PATH=%PATH%;%~dp0\..\bin;

SET LOCATION=%%~dpA_
REM SET LOCATION=%%~dpA
SET FILENAME=%%~nA.mp4

SET TITLE=-metadata title="%%~nA"

SET VIDEO=-c:v copy

SET AUDIO=-c:a copy

SET UNPACK=-bsf:v mpeg4_unpack_bframes

REM SET TRACK=-map 0:v -map 0:a:0
REM SET TRACK= -map 0:a:0
REM SET TRACK= -map 0:0

REM SET START=-ss 00:22:00
REM SET DURATION=-t 00:00:01

FOR %%A IN (%*) DO (
	mkdir "%LOCATION%"

	echo ffmpeg -i %%A %TITLE% -y %VIDEO% %AUDIO% %TRACK% %START% %DURATION% %UNPACK% "%LOCATION%\%FILENAME%"
	ffmpeg -i %%A %TITLE% -y %VIDEO% %AUDIO% %TRACK% %START% %DURATION% %UNPACK% "%LOCATION%\%FILENAME%"
	
)

REM shutdown -h
REM pause