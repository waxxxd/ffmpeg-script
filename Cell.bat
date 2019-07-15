@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

SET LOCATION=%%~dpA_
REM SET LOCATION=%%~dpA
SET FILENAME=%%~nA.mp4

SET TITLE=-metadata title="%%~nA"

REM SET VIDEO=-c:v copy

REM 
SET VIDEO_CODEC264=-c:v libx264
IF DEFINED VIDEO_CODEC264 (
	REM ultrafast superfast veryfast faster fast medium slow slower veryslow placebo DEFAULT=medium
	SET PRESET=-preset medium 
	
	REM animation film grain stillimage psnr ssim fastdecode zerolatency
	
	
	REM CRF=0-51, SANE RANGE=18-28, DEFAULT=23
	SET CRF=-crf 23
	
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
SET SCALE=scale="640:trunc(ow/a/2)*2"

REM
SET COLOUR=eq=contrast=1.2:brightness=0.15:saturation=1:gamma=1:gamma_r=1:gamma_g=1:gamma_b=1:gamma_weight=1

IF DEFINED SCALE (
	IF DEFINED COLOUR (
		SET VIDEO_FILTER=-vf %SCALE%,%COLOUR%
	) ELSE (
		SET VIDEO_FILTER=-vf %SCALE%
	)
) ELSE (
	IF DEFINED COLOUR (
		SET VIDEO_FILTER=-vf %COLOUR%
	)
)

REM SET AUDIO=-c:a copy
REM SET AUDIO -c:a aac -b:a 128k 
REM 
SET AUDIO=-c:a mp3 -b:a 128k
REM SET AUDIO=-c:a libvorbis -q 4.0

REM SET TRACK=-map 0:v -map 0:a:0
REM SET TRACK= -map 0:a:0
REM SET TRACK= -map 0:0

REM SET START=-ss 00:22:00
REM SET DURATION=-t 00:00:10

REM 
SET AUDIO_FILTER=-af "volume=1.20"

REM 
SET A_C=-ac 1

FOR %%A IN (%*) DO (
	mkdir "%LOCATION%"

	echo ffmpeg -i %%A %TITLE% -y %VIDEO% %AUDIO% %TRACK% %START% %DURATION% %AUDIO_FILTER% %A_C% %VIDEO_FILTER% "%LOCATION%\%FILENAME%"
	ffmpeg -i %%A %TITLE% -y %VIDEO% %AUDIO% %TRACK% %START% %DURATION% %AUDIO_FILTER% %A_C% %VIDEO_FILTER% "%LOCATION%\%FILENAME%"
	
)

REM shutdown -h
REM pause
