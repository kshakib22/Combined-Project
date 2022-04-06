#!/usr/bin/env bash

cd strokeaggregator/core;
NAME="$1";
SCAP=".scap";
#echo ${NAME};


FILENAME=$(echo "$NAME" | cut -f 1 -d '.');
export FILENAME
echo $FILENAME
#python svg-to-scap.py input/$NAME -o $1.scap
# python svg-to-scap.py input/$1 -o $1.scap
scapfile="$FILENAME$SCAP"
#echo ${scapfile}

longname="\"1\": [\"data/$FILENAME"
echo $longname
python svg_to_scap.py input/$NAME -o output/$scapfile


cd ../../labeler
echo $(pwd)

# the following line changes the only filename present in inputs.js
# to the current file (entered through terminal)
perl -i -pe 's/"1":.?\["[a-z]\w+\/[a-zA-z]\w+/$ENV{longname}/' inputs.js
open http://localhost:8000
python -m http.server
