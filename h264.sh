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

[[ -z "$1" ]] && error_exit "Input file not provided" 1
[[ -z "$2" ]] && error_exit "Output file not provided" 2

# Convert file

ffmpeg -i "$1" -c:v libx264 -crf 20 -preset veryslow -c:a libfaac -b:a 128k -ac 2 "$2" || error_exit "FFmpeg returned with error" 3 
