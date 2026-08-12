# Linux Processes and Services

## 1. Process Information

### Show running processes
ps

### Show all processes
ps aux

### Process tree
pstree

### Real-time process monitoring
top

### Better process monitoring if installed
htop

## 2. Find Process

ps aux | grep nginx

pgrep nginx

pidof nginx

## 3. Process ID

Every process has a PID.

Example:

ps aux | grep redis

## 4. Kill Process

### Gracefully terminate
kill PID

### Forcefully terminate
kill -9 PID

### Kill by process name
pkill nginx

## 5. Process Priority

### Start process with priority
nice -n 10 command

### Change priority
renice 10 -p PID

## 6. Background Processes

command &

### Show jobs
jobs

### Bring job to foreground
fg

### Send job to background
bg

## 7. Services

### Check service
systemctl status nginx

### Start service
sudo systemctl start nginx

### Stop service
sudo systemctl stop nginx

### Restart service
sudo systemctl restart nginx

### Reload service
sudo systemctl reload nginx

### Enable service at boot
sudo systemctl enable nginx

### Disable service
sudo systemctl disable nginx

## 8. Service Logs

journalctl -u nginx

### Follow service logs
journalctl -u nginx -f

### Logs since today
journalctl -u nginx --since today

### Last 100 lines
journalctl -u nginx -n 100

## 9. System Logs

ls -lh /var/log/

tail -f /var/log/syslog

tail -f /var/log/messages

## 10. CPU and Memory

top

free -h

uptime

vmstat

## 11. Disk

df -h

du -sh /var/log/*

## 12. Open Files

lsof

lsof -i :6379

## 13. Process Troubleshooting

### Find high CPU processes
ps aux --sort=-%cpu | head

### Find high memory processes
ps aux --sort=-%mem | head

### Find process using port
sudo lsof -i :8080

## Production Troubleshooting Flow

Application is slow
        |
        v
Check CPU
        |
        v
Check Memory
        |
        v
Check Disk
        |
        v
Check Process
        |
        v
Check Service
        |
        v
Check Logs
        |
        v
Check Network
