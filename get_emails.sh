#!/bin/bash

mail_types=()
src=
dest=
last=0
for arg in $@
do
	if [[ $last -eq 1 ]]
	then
		dest=$arg
		touch $dest
		if [[ ! -f $dest ]]
		then
			echo "Impossible to create destinaion file!"
			exit
		fi
		break
	fi
	if [[ `echo $arg | grep -E '^(gmail|outlook|yahoo|aol)$'` ]]
	then
		mail_types+=('^[A-Za-z0-9_\-\.]+@'"$arg"'\.com$')
	else
		last=1
		src=$arg
		if [[ ! -f $src ]]
		then
			echo "Impossible to opne source file!"
			exit
		fi
	fi
done

mails=()
for mail in `cat $src`
do
	for exp in ${mail_types[@]}
	do
		if [[ `echo $mail | grep -E $exp` ]]
		then
			mails+=($mail)
			break
		fi
	done
done

echo ${mails[@]} | tr ' ' $'\n' | sort -u > $dest

