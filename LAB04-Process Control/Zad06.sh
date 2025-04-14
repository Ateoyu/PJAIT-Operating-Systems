#!/bin/bash

now=$(date '+%F_%H:%M:%S')
printf "%s\n" "$now" >> "pc_reboot_datetime.txt"
