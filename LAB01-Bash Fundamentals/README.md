## Ex01
**Task:** In the Documents directory, create the following directory hierarchy:
```
 Example
 ├── JAZ
 ├── Przepisy
 │   ├── Kolacje
 │   ├── Obiady
 │   └── Sniadania
 ├── SOP
 └── PRI
```

**Solution:**
```bash
  853  pwd
  854  ls
  855  cd Documents/
  856  mkdir Example
  857  cd Example/
  858  mkdir JAZ && mkdir Przepisy && mkdir SOP && mkdir PRI
  859  ls
  860  cd Przepisy
  861  mkdir Kolacje && mkdir Obiady && mkdir Sniadania
  862  ls
```
## Ex02
**Task:** Write a script that will download the file [mhyla.com/repo/cars.txt](https://mhyla.com/repo/cars.txt), sort it descending, number the lines and save the first 20 to the file lista.txt

**Solution:**
```bash
#!/bin/bash

curl -o zad02File.txt https://mhyla.com/repo/cars.txt
sort -r zad02File.txt | nl | head -n 20 > lista.txt
```
## Ex03
**Task:** Write a script that will accept a number from the user 1-20 and display a car from the list.txt file with an index equal to that number

**Solution:**
```bash
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
```
### Useful Websites
- Conditionals in bash explanation:
   https://www.pluralsight.com/resources/blog/cloud/conditions-in-bash-scripting-if-statements
- curl and wget for downloading a file from web: 
  https://www.warp.dev/terminus/curl-vs-wget
- sed documentation: https://www.gnu.org/software/sed/manual/sed.html#Command_002dLine-Options