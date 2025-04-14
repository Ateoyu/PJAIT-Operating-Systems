## Ex01
**Task:** Write regular expressions that check:
1. **Whether the given text is an email address**
```bash
printf "ateosu@gmail.com" | grep -E "^[[:alnum:]]+@[[:alnum:]]+\\.[[:alpha:]]+$"
```
2. **Whether the given text is a valid name (starts with a capital letter and contains only letters)**
```bash
printf "Marcel" | grep -E "^[[:upper:]]{1}[[:alpha:]]+$"
```
3. Whether the given text is a valid Polish postal code (69-420)
```bash
printf "69-420" | grep -E "^[[:digit:]]{2}\-{1}[[:digit:]]{3}$"
```
## Ex02
**Task:** Write a script that checks whether exactly one argument is given to it (remember `$#,` `$@)` and whether it is a file, and then searches for all occurrences of the string “s\[5digits]” in this file

**Solution:**
```bash
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
```
## Ex03 (Extra)
**Task:**
**FOR AN ADDITIONAL POINT** Write a script that will help a poor lecturer in checking tests. There are 32 cpp files in the directory, named according to the pattern - \[index number]\_z1.cpp. The task that will be checked consisted of reading a number <25 from the user and printing its factorial. The poor lecturer would like:
- The student's index number without the extension and the task number to be displayed at the top of the screen
- Below are the results of calling the checked task with the values ​​5, 10 and 30
- The script allowed him to enter the number of points for the task and place it together with the index number itself in a text file or display the task code in case of doubt
- After entering the grade, he should automatically move on to the next student.

**Solution:**
```bash
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
```