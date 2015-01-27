#!/bin/bash

# Preamble

PROGNAME=$(basename $0)
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

function error_exit
{
	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	exit ${2:-1}
}

# Argument validation

[[ -z "$1" ]] && error_exit "Input format not provided" 1
e=$1

# Go to the base directory

cd $DIR || error_exit "Unable to change to base $DIR" 2
[[ -x h264.sh ]] || error_exit "Conversion script not found" 3

# Check needed directories
[[ -d $e ]] || error_exit "Input directory does not exist"
[[ -d h264 ]] || error_exit "Output directory does not exist"
[[ -d completed ]] || error_exit "Completed directory does not exist"

cd $e
for f in *.$e; do
	b="$(basename "$f" .$e)"
	o="../h264/$b.mp4"
	a="../completed/$b.$e"
	../h264.sh "$f" "$o" && mv "$f" "$a" 
done
