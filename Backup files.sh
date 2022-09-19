#!/bin/bash

path=$1

for i in `ls $path`
do
cp ${path}/${i} ${path}/${i}.backup
done
