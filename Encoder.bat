@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

PATH=%PATH%;%~dp0\..\bin;

SET LOCATION=%%~dpA_
REM SET LOCATION=%%~dpA
SET FILENAME=%%~nA.mp4

SET TITLE=-metadata title="%%~nA"

REM SET VIDEO=-c:v copy

REM 
SET VIDEO_CODEC264=-c:v libx264
IF DEFINED VIDEO_CODEC264 (
	REM ultrafast superfast veryfast faster fast medium slow slower veryslow placebo DEFAULT=medium
	SET PRESET=-preset faster
	
	REM -tune film animation grain stillimage psnr ssim fastdecode zerolatency
	
	REM CRF=0-51, SANE RANGE=18-28, DEFAULT=23
	SET CRF=-crf 25
	
	SET "VIDEO=!VIDEO_CODEC264! !PRESET! !CRF!"
)

REM SET VIDEO_CODEC265=-vcodec libx265
IF DEFINED VIDEO_CODEC265 (
	REM ultrafast superfast veryfast faster fast medium slow slower veryslow placebo DEFAULT=medium
	SET PRESET=-preset slow
		
	REM CRF=0-51, SANE RANGE=18-28, DEFAULT=28 (Compares to x264 at about half the size)
	SET CRF=crf=28
	
	SET "VIDEO=!VIDEO_CODEC265! !PRESET! -x265-params !CRF!"
	
)

REM 
SET SCALE=scale=640:-2

REM 		   eq=gamma:contrast:brightness:saturation:rg:gg:bg:weight
REM SET COLOUR=eq=contrast=1.2:brightness=0.2:saturation=1:gamma=1:gamma_r=1:gamma_g=1:gamma_b=1:gamma_weight=1

IF DEFINED SCALE (
	SET VIDEO_FILTER=-vf %SCALE% %COLOUR%
)

IF DEFINED COLOUR (
	SET VIDEO_FILTER=-vf %SCALE% %COLOUR%
)

REM 
SET AUDIO=-c:a copy
REM SET AUDIO -c:a aac -b:a 128k 
REM SET AUDIO=-c:a mp3 -b:a 128k
REM SET AUDIO=-c:a libvorbis -q 4.0

REM SET TRACK=-map 0:v -map 0:a:0
REM SET TRACK= -map 0:a:0
REM SET TRACK= -map 0:0

REM SET START=-ss 00:00:00
REM SET DURATION=-t 00:00:30

REM SET AUDIO_FILTER=-af "volume=1.20"

FOR %%A IN (%*) DO (
	mkdir "%LOCATION%"

	echo ffmpeg -i %%A %TITLE% -y %VIDEO% %AUDIO% %TRACK% %START% %DURATION% %AUDIO_FILTER% %VIDEO_FILTER% "%LOCATION%\%FILENAME%"
	ffmpeg -i %%A %TITLE% -y %VIDEO% %AUDIO% %TRACK% %START% %DURATION% %AUDIO_FILTER% %VIDEO_FILTER% "%LOCATION%\%FILENAME%"
	
)

pause