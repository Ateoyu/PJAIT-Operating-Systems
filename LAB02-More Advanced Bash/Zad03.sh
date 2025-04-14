#!/bin/bash

resultsFile="results.txt"

cppFiles=$(ls | grep -E "s[[:digit:]]{5}\_z1.cpp")

for file in $cppFiles
do
    index=$(printf '%s' "$file" | grep -E -o "s[[:digit:]]{5}")
    printf '%s\n \n' "$index"

    if ! clang++ "$file" -o compiledProgram.out
    then
        prinf "Program doesn't compile."
        continue
    fi

    for num in 5 10 30;
    do
        printf '%s' "$num" | ./compiledProgram.out
        printf '\n'
    done

    read -r -p "Enter grade for $index, or press 'c' to see the code: " grade
    if [ "$grade" == 'c' ];
    then
        printf '\n%s code:\n \n' "$index"
        cat -n "$file"
        printf '\n'
        read -r -p "Enter grade for $index: " grade
    fi

    printf '%s\n' "$index    $grade" >> "$resultsFile"

    # copied from internet for a nice seperator :)
    printf '\n'
    printf '\n'
    for x in $(seq "$(tput cols)" ); do printf _; done; printf '\n'
    printf '\n'
    printf '\n'
done

printf 'All Results:\n'
cat -n "$resultsFile"
