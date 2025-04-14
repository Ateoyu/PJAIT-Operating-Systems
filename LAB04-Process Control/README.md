**Task:** Apart from task 6, to settle today's tasks, all I need is a file with the result of the command`history`
## Ex01
**Task:** Run a program (e.g. openttd) in the background using the nohup command and verify its operation using the command `ps`. Change its priority using the `renice` command to compare the impact on the program's performance. Then use the `kill` command to kill the process.

**Solution:**
```bash
  921  nohup openttd &
  922  ps
  923  sudo renice +2 5837
  924  ps -o pid,nice,command=CMD
  931  kill 5837
```
## Ex02
**Task:** Run the program in the background using the `nohup` command and redirect its output to a text file.

**Solution:**
```bash
nohup openttd &> Zad02outputFile.txt &
```
## Ex03
**Task:** Use the `top` or `htop` command to monitor resource usage by various processes on your system. Identify processes that are using the most memory or processing power and change their priority using the `renice` command.

**Solution:**
```bash
  942* htop
  943  renice -10 1768
  944  renice -5 8156
```
## Ex04
**Task:** Use the `nice` command to run a program with a lower priority than the standard one. Then do another task on your computer and watch the program run in the background with a lower priority.

**Solution:**
```bash
nice -n 19 openttd
```
## Ex05
**Task:** Start any process, then pause it with the `kill -STOP` command. Then resume it with the `kill -CONT` command.

**Solution:**
```bash
  963  openttd &
  964  kill -STOP 10137
  965  kill -CONT 10137
```
## Ex06
**Task:** 1. Create a script that automatically starts a program after the system starts. Then restart the system and make sure the program starts automatically - uncle google or the I will help if necessary.

**Solution:**
### Script:
```bash
#!/bin/bash

now=$(date '+%F_%H:%M:%S')
printf "%s\n" "$now" >> "pc_reboot_datetime.txt"
```
#### Crontab solution 
It should work on both Mac and Linux, but cron is deprecated on Mac.
Apple deprecated `Crontab` in favour of `launchd`
```bash
@reboot sh ~/PJATK/4-Semestr/SOP/"Lesson 04 - Work"/Zad06.sh
```
#### Launchd solution
1. Place the `.plist` in the `~Library/LaunchDaemons/` directory for system-wide tasks, regardless of which user logs in.
2. Ensure `chown root:wheel` and `chmod 644`.
3. Make sure to run:
```bash
sudo launchctl load com.sop.lab04.zad06.plist
```
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.system.openttd</string>

    <key>ProgramArguments</key>
    <array>
        <string>/Users/ateoyu/PJATK/4-Semestr/SOP/Lesson 04 - Work/zad06.sh</string>
    </array>

    <key>RunAtLoad</key>
    <true/>

    <key>KeepAlive</key>
    <true/>

    <key>UserName</key>
    <string>ateoyu</string>
</dict>
</plist>
```
