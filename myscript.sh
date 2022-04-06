#!/usr/bin/env bash

cd strokeaggregator/core;
NAME="$1";
SCAP=".scap";
#echo ${NAME};


FILENAME=$(echo "$NAME" | cut -f 1 -d '.');
#echo $FILENAME
#python svg-to-scap.py input/$NAME -o $1.scap
# python svg-to-scap.py input/$1 -o $1.scap
scapfile="$FILENAME$SCAP"
#echo ${scapfile}


python svg_to_scap.py input/$NAME -o output/$scapfile


cd ../../labeler
echo $(pwd)
sed
