#!/bin/bash

if (( $# != 1 )); then
    printf "Only pass 1 parameter, you passed %s" "$#"
    exit 1;
elif ! [[ -f $1 ]]; then
    printf "Only pass files as parameters."
    exit 1;
fi


if  ! matchedLines=$(grep -E -n "s[[:digit:]]{5}" "$1"); then
    printf "No occurances of string \"s[5digits]\" in this file."
    exit 1;
fi

printf "Matched Lines:\n"
printf "%s\n" "$matchedLines"

printf "\nMatched Indexes:\n"
printf "%s" "$matchedLines" | grep -E -o "s[[:digit:]]{5}"
