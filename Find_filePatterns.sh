#! /bin/bash


if [ $# -lt 2 ];
then       
	echo "usage:$0 <file type> <pattern>"
	exit 102
elif [ $# -eq 2 ];
then
find *.$1|xargs grep $2

else

find *.$1 |xargs grep -i -e $2 -e $3
fi
