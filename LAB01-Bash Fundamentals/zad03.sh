#!/bin/bash

num=0
while (( num > 20 || num < 1 ))
do
	echo Enter a number between 1-20.
	read num
	if (( num > 20 ));
	then
		echo "ERR: Number is greater than 20, enter a number between 1-20."
		echo
		continue
	fi

	if (( num < 1 ));
	then
		echo "ERR: Number is less than 1, enter a number between 1-20."
		echo
	fi
done

sed -n "$num{p;}" lista.txt
