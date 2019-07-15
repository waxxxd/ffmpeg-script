#!/bin/bash
mkdir ./in
mkdir ./in_temp
mkdir ./in_done
mkdir ./out
mkdir ./out_temp

cd ./in

for fullname in *
do

	inputbasename="${fullname##.}"
	inputfilename="${inputbasename%.*}"
	inputfileextension="${inputbasename##*.}"

	mv "${inputbasename}" ../in_temp

	ffmpeg -i "../in_temp/${inputbasename}" -metadata title="${inputfilename}" -y -c:v libx264 -preset slow -crf 28 -c:a mp3 -b:a 128k -af "volume=1.20" -ac 1 -vf scale="720:trunc(ow/a/2)*2",eq=contrast=1.15:brightness=0.1:saturation=1:gamma=1:gamma_r=1:gamma_g=1:gamma_b=1:gamma_weight=1 "../out_temp/${inputfilename}.mp4"
	# ,eq=contrast=1.15:brightness=0.1:saturation=1:gamma=1:gamma_r=1:gamma_g=1:gamma_b=1:gamma_weight=1 "_/${inputfilename}.mp4"

	mv "../in_temp/${inputbasename}" ../in_done/
	mv "../out_temp/${inputbasename}" ../out/

	# mv "${inputfilename}{inputfileextension}" ../encoded/

done
