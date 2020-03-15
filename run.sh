#!/bin/bash
id=12431
chap=1
img=0
error=0
domain="https://img.onemanhua.com/comic"
read -p "Enter the comic id:" id
read -p "Enter the start chapter:" chap
while (($error<3))
do
    if [ ! -d $id  ];then
        mkdir $id
    fi
    if [ ! -d "$id/$chap"  ];then
        mkdir "$id/$chap"
    fi
    ((img++))
    imgpath=`printf "%04d" $img`
    url="$domain/$id/第$chap话/$imgpath.jpg"
    echo "Downloading $url"
    out="./$id/$chap/$img.jpg"
    if [ -f $out ];then
        echo "$out existed! Jump->"
        error=0
        continue
    fi
    `wget $url>/dev/null -qO $out`
    if (("$?" == 8))
    then
        ((chap++))
        ((error++))
        rm $out
        echo "End of chapter $chap--------------------------------------------------------------"
        img=0000
    else
        echo "Downloaed Successfully"
        error=0
    fi
done
