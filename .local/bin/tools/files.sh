#!/usr/bin/bash

#" ____  __.      .__  .__
#"|    |/ _|____  |  | |__|__  ______.__.________
#"|      < \__  \ |  | |  \  \/  <   |  |\___   /
#"|    |  \ / __ \|  |_|  |>    < \___  | /    /
#"|____|__ (____  /____/__/__/\_ \/ ____|/_____ \
#"        \/    \/              \/\/           \/

#" File: files.sh
#" Author: Andre Hansen
#" Description: Script that shows file size and number of files in a folder.
# It takes a few parameters [-l location] [-e extension] [--extension extension] [-h] [--help] [-s] [--stats]
#" Last Modified: 2019-10-06


#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
#"                                  LICENSE                                   "
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
#"                 DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE               "
#"									     "
#"	Everyone is permitted to copy and distribute verbatim or modified    "
#" 	copies of this license document, and changing it is allowed as long  "
#" 			as the name is changed.                              "
#"                                                                           "
#" 		DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE		     "
#"	TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION      "
#"                                                                           "
#"  		0. You just DO WHAT THE FUCK YOU WANT TO.                    "
#"									     "
#"			Copyright 2019 Andre Hansen                          "
#"									     "
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function usage() {
  echo "USAGE: $0 [-l location] [-eextension] [--extension extension] [-h] [--help] [-s] [--stats]"
  echo "Examples:"
  echo "$0 -l /etc/ -e txt -s"
  echo "$0 -e img --stats"
  exit 1

}

LOC_SET=0	#0-location not set, use current location        1-location set
STATS=0		#0-do not display statistics			 1-display statistics

while [ $# -gt 0 ]
do
  case $1 in
    -l|--location)
	LOCATION="$2"
	if ! [ -d "$LOCATION" ]; then
	  useage
	fi
	LOC_SET=1
	shift
	shift
	;;

    -e|--extension )
	EXT="$2"
	shift
	shift
	;;

    -s|--stats )
	STATS=1
	shift
	;;

    -h|--help )
	shift
	usage
	;;

    * )
	usage
	;;

  esac


done

if [ $LOC_SET -ne 1 ]; then
  LOCATION=$(pwd)
fi

echo "Location: $LOCATION"

if [ "$EXT" != "" ]; then
  ls -l $LOCATION | awk '/^-/' | grep "\.$EXT$" &>/dev/null
  if [ $? -ne 0 ]; then
    echo "No file with extension: $EXT found"
    exit 2
  fi

  # Show size of files with specific extension
  ls -l $LOCATION | awk '/^-/' | grep "\.$EXT$" | awk -v stats=$STATS'{
    sum+=$5
    if (NR==1) {
      min=$5
      max=$5
      min_name=$9
      max_name=$9
    }

    if ($5 > max) {
      max=$5
      max_name=$9}

    if ($5 < min) {
      min=$5
      min_name=$9
    }

    }
    END{
      print "SUM:", sum/1024/1024 "MB"
      print "Files: ", NR
      if (stats==1) {
        print "Largest file:\t", max_name, max_name, max/1024/1024, "MB"
	print "Smallest file:\t", min_name, min/1024/1024, "MB"
      }
    }'

else
  ls -l $LOCATION | awk '/^-/' | awk -v stats=$STATS '{
    sum+=$5
    if (NR==1) {
      min=$5
      max=$5
      min_name=$9
      max_name=$9
    }

    if ($5 > max) {
      max=$5
      max_name=$9}

    if ($5 < min) {
      min=$5
      min_name=$9
    }

    }
    END{
      print "SUM:", sum/1024/1024 "MB"
      print "Files: ", NR
      if (stats==1) {
        print "Largest file:\t", max_name, max_name, max/1024/1024, "MB"
	print "Smallest file:\t", min_name, min/1024/1024, "MB"
      }
    }'

fi

