#!/bin/bash

path=$1

for file  in `ls -a $path`
do
	if [[ -n `echo $file | grep -E '.*pass(word)?.*'` ]]
	then
		echo $file
	fi
done

