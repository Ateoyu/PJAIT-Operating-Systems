## Ex01
**Task:** Write a script that will scan the Documents directory and subdirectories for .txt files and display a complete list of them

**Solution:**
```bash
#!/bin/bash

find ~/Documents/ -type f -name "*.txt"
```
## Ex02
**Task:** Extend the previous script by packing this set into a compressed file named “\[user]\_backup\_\[date_executed]”. Such backups should be placed in the ~/.backups directory

**Solutions:**
```bash
#!/bin/bash

mkdir -p "$HOME/.backups"
find ~/Documents/ -type f -name "*.txt" -print0 |
tar -cvf "$HOME/.backups/$(whoami)_backup_$(date "+%Y-%m-%d_%H:%M:%S").gz" --strip-components=3 -T -
```
## Ex03
**Task:** Create a task that will execute this script periodically (e.g. once a day)

**Solutions:**
```bash
0 0 * * * ~/PJATK/4-Semestr/SOP/"Lesson 03 - Work"/./Zad01.sh
```
## Ex04
**Task:** Write a script + crontab that will periodically check disk space usage by backups in our directory and if this used space is greater than X (to be determined independently), it will notify the user. A command `df`to check the used space, `awk`to extract the appropriate value and a package `mailx`or similar may be useful.

**Solution:**
```bash
#!/bin/bash

total_disk_size=$(df -k ~/.backups | awk 'END{print $2}');
backup_size=$(du -csk ~/.backups/ | awk 'END{print $1}');

percent_occupied=$(bc <<< "scale=20; $backup_size / $total_disk_size * 100")

printf "Disk space occupied by .backups: %.20f%%\n" "$percent_occupied"

if [[ 1 -eq "$(bc <<< "$percent_occupied > 10")" ]]; then
    printf "WARNING: You exceeded 10%% disk space used by .backups/ directory, current usage: %s" "$percent_occupied" |
    mailx -s "Disk Space Alert" "$USER"
fi
```

```bash
0 * * * * ~/PJATK/4-Semestr/SOP/"Lesson 03 - Work"/./Zad04.sh
```