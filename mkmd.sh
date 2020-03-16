#!/bin/bash
# create readme automatically

# require, input id and name for comic
read -p "Enter the comic id: " id
read -p "Enter the commic name: " name

comicReadme="./$id/README.md"
# create readme for commic
if [ -f $comicReadme ];then
    echo "# $name">$comicReadme
    echo "">>$comicReadme
    echo "![poster](poster.jpg)">>$comicReadme
    echo "">>$comicReadme
fi

# only list dir and foreach dir
for chapter in `ls -vl $id | grep "^d" | awk '{print $9}'`
do
    childdir="$id/$chapter"
    lscharpter=`ls -A $childdir`
    iftrans=`ls -A $childdir|grep cc.txt`
    ifdel=`ls $childdir`
    # delete empty chapter
    if [ "$ifdel" = "" ]||[ "$ifdel" = "README.md" ];then
        rm -r $childdir
        echo "remove empty $chapter"
        continue
    fi
    echo "Insert Chapter: $chapter into $comicReadme"
    if [ "$iftrans" = "" ];then
        echo "- [Chapter $chapter](./$chapter/README.md)" >> $comicReadme
    else
        echo "- [Chapter $chapter (translated)](./$chapter/README.md)" >> $comicReadme
    fi
    echo "Create readme for chapter $chapter"
    # add img link to chapter readme
    chapterReadme="$id/$chapter/README.md"
    lsimg=`ls -v $id/$chapter/`
    # rewrite readme for each chapter
    echo "# Chapter $chapter">$chapterReadme
    echo "">>$chapterReadme
    for img in $lsimg
    do
        if [[ "$img" = *".jpg" ]];then
            echo "![$img]($img)">>$chapterReadme
            echo "">>$chapterReadme
        fi
    done
done
