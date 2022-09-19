#!/bin/bash
file=$1
mCnt=0
fCnt=0
for line in `cat $file`
do
   ch=`echo $line | cut -d "," -f6`
   if [[ $ch == "M" ]]
   then
   ((mCnt=mCnt+1))
   fi;
   if [[ $ch == "F" ]]
   then
   ((fCnt=fCnt+1))
   fi;
done
echo "M:$mCnt"
echo "F:$fCnt"


