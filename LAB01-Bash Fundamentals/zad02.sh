#!/bin/bash

curl -o zad02File.txt https://mhyla.com/repo/cars.txt
sort -r zad02File.txt | nl | head -n 20 > lista.txt

cu
