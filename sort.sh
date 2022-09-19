#!/bin/bash
path=$1
for file in `ls -a $path`
do
	ext=${file##*.}
	folder=""
	case $ext in
		java)
			folder="Java_files"
			;;
		c)
			folder="C_files"
			;;
		txt)
			folder="txt_files"
			;;
	esac
	if [[ -z $folder ]]
	then
		continue;
	fi
	mkdir -p $folder
	mv $file "`pwd`/${folder}"
done

