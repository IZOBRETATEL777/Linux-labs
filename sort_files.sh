#!/bin/bash
path=$1
for i in `ls $path`
do
filePath="${path}/${i}"
ext=${filePath##*.}
mkdir -p $ext
mv $filePath $ext
done

