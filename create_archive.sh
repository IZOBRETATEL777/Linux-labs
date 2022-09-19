#!/bin/bash

path=$1
mkdir to_zip -p
rm -rf to_zip/.
for i in `cat $path`
do
mv *.$i to_zip

done
zip zipped.zip to_zip/. -r9

