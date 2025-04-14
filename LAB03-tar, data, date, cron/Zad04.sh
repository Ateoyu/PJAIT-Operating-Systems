#!/bin/bash

total_disk_size=$(df -k ~/.backups | awk 'END{print $2}');
backup_size=$(du -csk ~/.backups/ | awk 'END{print $1}');

percent_occupied=$(bc <<< "scale=20; $backup_size / $total_disk_size * 100")

printf "Disk space occupied by .backups: %.20f%%\n" "$percent_occupied"

if [[ 1 -eq "$(bc <<< "$percent_occupied > 10")" ]]; then
    printf "WARNING: You exceeded 10%% disk space used by .backups/ directory, current usage: %s" "$percent_occupied" |
    mailx -s "Disk Space Alert" "$USER"
fi
