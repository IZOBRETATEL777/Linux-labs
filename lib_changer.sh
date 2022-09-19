#!/bin/bash

if [[ $# -lt 4 ]]
then
	echo "Too few arguments"
	exit
fi

arg=$1
to_find=$2
new_val=$3
file=$4

if [[ ! -f $file ]]
then
	echo "Cannot reach the file!"
	exit
fi

case $arg in
	--author)
		if [[ ${#arg} -eq 2 && ! `echo $to_find | grep -E '^.+_.+$'` ]]
		then
			echo "Wrong usage!"
			exit
		fi
		field=2
		to_find=`echo $to_find | sed 's/\(\w\+\)_\(\w\+\)/\2 \1/'`
		new_val=`echo $new_val | sed 's/\(\w\+\)_\(\w\+\)/\2 \1/'`
		;;
	--title)
		;;
	--genre)
		;;
	*)
		echo "Unknow parameter!"
		exit
		;;
esac


while IFS=',' read Title Author Genre SubGenre Height Published
do
	case $to_find in
		$Title)

			sed -i "s/$Title\(, *$Author, *$Genre, *$SubGenre, *$Height, *$Published\)/$new_val\1/" $file
			;;
		$Author)
			sed -i "s/\($Title, *\)$Author\(, *$Genre, *$SubGenre, *$Height, *$Published\)/\1$new_val\2/" $file
			;;
		$Genre)
			sed -i "s/\($Title, *$Author, *\)$Genrei\(, *$SubGenre, *$Height, *$Published\)/\1$new_val\2/" $file
			;;
	esac
done < $file
