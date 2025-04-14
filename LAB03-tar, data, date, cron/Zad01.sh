#!/bin/bash

mkdir -p "$HOME/.backups"
find ~/Documents/ -type f -name "*.txt" -print0 |
tar -cvf "$HOME/.backups/$(whoami)_backup_$(date "+%Y-%m-%d_%H:%M:%S").gz" --strip-components=3 -T -
