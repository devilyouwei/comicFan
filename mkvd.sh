#!/bin/bash
# create videos for comic

read -p "Enter the comic id: " id
read -p "Enter the chapter number: " chapter

for img in `ls $id/$chapter/*.jpg`; do
    echo "Crop Img: $img"
    convert -crop 800x1130+0+0 $img $img
done

ffmpeg -threads 4 -r 0.1 -i ./$id/$chapter/%d.jpg -y ./$id/$chapter/video.mp4
