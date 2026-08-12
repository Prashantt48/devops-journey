# Linux Basic Commands## 1. Navigation

### Print current directory
pwd

### List files
ls
ls -l
ls -la
ls -lh

### Change directory
cd /var/log
cd ..
cd ~

### Create directory
mkdir test
mkdir -p project/app/logs

### Remove directory
rmdir test
rm -rf test

## 2. File Operations

### Create file
touch file.txt

### Create multiple files
touch file1.txt file2.txt file3.txt

### Copy file
cp file.txt backup.txt

### Copy directory
cp -r source/ destination/

### Move/Rename file
mv file.txt newfile.txt

### Delete file
rm file.txt

## 3. View Files

### Display complete file
cat file.txt

### View first 10 lines
head file.txt

### View last 10 lines
tail file.txt

### Follow log file
tail -f /var/log/syslog

### View file page by page
less file.txt

### Number lines
nl file.txt

## 4. Search

### Find files
find /var/log -name "*.log"

### Find files by type
find /tmp -type f
find /tmp -type d

### Search text
grep "error" application.log

### Case-insensitive search
grep -i "error" application.log

### Recursive search
grep -r "error" /var/log/

### Show line numbers
grep -n "error" application.log

## 5. Disk Usage

df -h
du -sh /var/log
du -sh *
lsblk

## 6. System Information

uname -a
hostname
hostnamectl
uptime
date
whoami
id

## 7. Memory and CPU

free -h
top
ps aux
uptime

## 8. Archives

### Create tar archive
tar -cvf backup.tar /data

### Extract tar archive
tar -xvf backup.tar

### Create gzip compressed archive
tar -czvf backup.tar.gz /data

### Extract gzip archive
tar -xzvf backup.tar.gz

## 9. Package Management

### Ubuntu/Debian
sudo apt update
sudo apt install nginx
sudo apt remove nginx

### RHEL/CentOS
sudo yum install nginx
sudo dnf install nginx

## 10. Useful Commands

history
clear
man ls
which python
whereis nginx
echo $PATH
env
