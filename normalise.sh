#!/bin/bash

sourcePath=$PWD

mkdir -p /opt/ffmpeg

mkdir -p '/opt/ffmpeg/in'
mkdir -p '/opt/ffmpeg/temp'
mkdir -p '/opt/ffmpeg/out'
mkdir -p '/opt/ffmpeg/done'

mv * /opt/ffmpeg/in

for fullname in '/opt/ffmpeg/in/*'
do

	inputbasename="${fullname##.}"

	inputfilename="${inputbasename%.*}"
	inputfileextension="${inputbasename##*.}"

	ffmpeg -i "${inputbasename}" -metadata title="${inputfilename}" -y -c:v libx264 -preset slow -crf 23 -c:a mp3 -b:a 128k -vf scale="720:trunc(ow/a/2)*2" "/opt/ffmpeg/temp/${inputfilename}.mp4"
# 	# ,eq=contrast=1.15:brightness=0.1:saturation=1:gamma=1:gamma_r=1:gamma_g=1:gamma_b=1:gamma_weight=1 "_/${inputfilename}.mp4"

# 	# echo "${inputfilename.inputfileextension}"
	mv "${fullname}" /opt/ffmpeg/done/
	mv "/opt/ffmpeg/temp/${inputfilename}.mp4" /opt/ffmpeg/out/

done
