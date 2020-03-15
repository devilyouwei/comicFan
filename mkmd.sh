#!/bin/bash
# create readme automatically

# require, input id and name for comic
read -p "Enter the comic id:" id
read -p "Enter the commic name:" name

comicReadme="./$id/README.md"
# create readme for commic
if [ -f $comicReadme ];then
    echo "# $name">$comicReadme
    echo "">>$comicReadme
    echo "![poster](poster.jpg)">>$comicReadme
    echo "">>$comicReadme
fi

# add chapter link to comic readme
for chapter in `ls -v $id`
do
    childdir="$id/$chapter"
    lscharpter=`ls -A $childdir`
    iftrans=`ls -A $childdir|grep cc.txt`
    if [ "$chapter" != "README.md" ]&&[ "$lscharpter" != "" ];then
        echo "Insert Chapter: $chapter into $comicReadme"
        if [ "$iftrans" == "" ];then
            echo "- [Chapter $chapter](./$chapter/README.md)" >> $comicReadme
        else
            echo "- [Chapter $chapter (translated)](./$chapter/README.md) :ok_hand:" >> $comicReadme
        fi
        echo "Create readme for chapter $chapter"
        # add img link to chapter readme
        chapterReadme="$id/$chapter/README.md"
        lsimg=`ls -v "$id/$chapter"`
        # rewrite readme for each chapter
        echo "# Chapter $chapter">$chapterReadme
        echo "">>$chapterReadme
        for img in $lsimg
        do
            if [ "$img" != "cc.txt" ]&&[ "$img" != "README.md" ];then
                echo "![$img]($img)">>$chapterReadme
                echo "">>$chapterReadme
            fi
        done
    fi
done
