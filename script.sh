#!/usr/bin/env bash

cd strokeaggregator/core;
# get the filename from the cmd line argument
NAME="$1";
SCAP=".scap";

# format (.svg) is  removed and .scap is added to the name
FILENAME=$(echo "$NAME" | cut -f 1 -d '.');
export FILENAME
scapfile="$FILENAME$SCAP"


# the .svg to .scap conversion is applied. The resulting .scap file
# is saved in labeler/data for the javascript application
python svg_to_scap.py input/$NAME -o ../../labeler/data/$scapfile

# we navigate to labeler
cd ../../labeler

# we save the full name of the newly generated file.
# this name will be entered into the inputs.js file
longname="\"1\": [\"data/$FILENAME"
export longname
echo $longname

# following line changes the filename in inputs.js for the first sequence
# to the current file (entered through terminal)
# labeler just runs with this single file on the web-app
perl -i -pe 's/"1":.?\["[a-z]\w+\/[a-zA-z]\w+/$ENV{longname}/' inputs.js
# the browser is opened at the port before the servver is setup
open http://localhost:9001
# the server is then set up. This is necessary as stopping server stops process
python -m http.server 9001

## IMPORTANT: for the first time, it is necessary to reload the page opened at
## this port. This is because the server is live only AFTER page has been opened
## To stop the process, we need to press Ctrl+C to kill terminal process.
