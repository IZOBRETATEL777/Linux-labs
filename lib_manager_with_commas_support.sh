#!/bin/bash

parm=$1
file=$3
shopt -s lastpipe

author=
title=
genre=

case $parm in
	"--author")
		author=$2
		;;
	"--title")
		title=$2
		;;

	"--genre")
		genre=$2
		;;
esac

cnt=0
res=""
# for skiping commas in the vlaues of tables
awk -F'"' -v OFS='' '{ for (i=2; i<=NF; i+=2) gsub(",", "", $i) } 1' $file \
	| while IFS="," read -r Title Author Genre SubGenre Height Publisher
do
	if [[ $(echo $Author | wc --words) -eq 3 ]]
	then
		parsedAuthor=$(echo $Author | awk -F " " '{print $3 " " $1}')
	else
		parsedAuthor=$(echo $Author | awk -F " " '{print $2 " " $1}')
	fi
	if [[ $parsedAuthor == $(echo $author | sed 's/_/ /') ]] || [[ $title == $Title ]] || [[ $genre == $Genre ]]
	then
		res+="${Title}; ${parsedAuthor}; ${Genre}; ${SubGenre}\n"
		((cnt++))
	fi
done
printf "${cnt} books in Total\n"
printf "${res}"

