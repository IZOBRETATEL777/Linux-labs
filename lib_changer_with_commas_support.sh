#!/bin/bash

parm=$1
shopt -s lastpipe

author=
title=
genre=
new_val=

if [[ "$#" -eq 4 ]]
then
	new_val=$3
	file=$4
else
	file=$3
fi

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

	if [[ -z $new_val ]] && [[ $parsedAuthor == $(echo $author | sed 's/_/ /') ||  $title == $Title  ||  $genre == $Genre ]]
	then
		res+="${Title}; ${parsedAuthor}; ${Genre}; ${SubGenre}\n"
		((cnt++))
	elif [[ ! -z $new_val ]]
	then
		((cnt++))
		is_repl=false
		case $parm in
			"--author")
				if [[ $parsedAuthor == $(echo $author | sed 's/_/ /') ]]
				then
					Author=$(echo $new_val | awk -F "_" '{print $2 ", " $1}')
					if [[ $(echo $Author | wc --words) -eq 2 ]] 
					then
						Author="\"${Author}\""
					fi
					is_repl=true
				fi
				;;
			"--title")
				if [[ $title == $Title ]]
				then
					Title=$new_val
					is_repl=true
				fi
				;;
			"--genre")
				if [[ $genre == $Genre ]]
				then
					Genre=$new_val
					is_repl=$true
				fi
				;;
		esac
		if $is_repl
		then
			res="${Title},${Author},${Genre},${SubGenre},${Height},${Publisher}";
			sed -i "${cnt}s/.*/$res/" $file
		fi
	fi
done
if [[ -z $new_val ]] 
then
	printf "${cnt} books in Total\n"
	printf "${res}"
fi


