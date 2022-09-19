#!/bin/bash

pdf_cnt=0
hidden_cnt=0

path=$1
filename="total.txt"

for file in `ls -a $path`
do
	if [[ -f $file && ${file##*.} == "pdf" ]]
	then
		((pdf_cnt++))
	fi
	
	if [[ -f $file && `echo $file | grep -E '^\.'` != "" ]]
	then
		((hidden_cnt++))
	fi
done

echo "Total PDFs: "$pdf_cnt > $filename
echo "Total hiddnes: "$hidden_cnt >> $filename

