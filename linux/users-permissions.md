# Linux Users, Groups and Permissions

## 1. Current User

whoami
id

## 2. User Information

cat /etc/passwd

### Check a specific user
id username

## 3. Create User

sudo useradd devopsuser

### Create user with home directory
sudo useradd -m devopsuser

### Set password
sudo passwd devopsuser

## 4. Delete User

sudo userdel devopsuser

### Delete user and home directory
sudo userdel -r devopsuser

## 5. Groups

### List groups
groups

### Create group
sudo groupadd devops

### Add user to group
sudo usermod -aG devops devopsuser

### Check group membership
groups devopsuser

## 6. File Ownership

### Check ownership
ls -l

### Change owner
sudo chown user file.txt

### Change owner and group
sudo chown user:group file.txt

### Recursive ownership
sudo chown -R user:group directory/

## 7. File Permissions

ls -l file.txt

Example:

-rwxr-xr--

Owner = rwx
Group = r-x
Others = r--

r = read
w = write
x = execute

## 8. chmod

### Numeric permissions

chmod 755 script.sh
chmod 644 file.txt
chmod 700 private.sh

### Add execute permission
chmod +x script.sh

### Remove write permission
chmod -w file.txt

## 9. Permission Numbers

Read    = 4
Write   = 2
Execute = 1

7 = 4 + 2 + 1 = rwx
6 = 4 + 2     = rw-
5 = 4 + 1     = r-x
4 = 4         = r--

Example:

chmod 755 script.sh

Owner  = rwx
Group  = r-x
Others = r-x

## 10. sudo

sudo command

### Edit sudo configuration
sudo visudo

## 11. Check File Permissions

stat file.txt
ls -l file.txt

## 12. Special Permissions

### SUID
chmod u+s file

### SGID
chmod g+s directory

### Sticky Bit
chmod +t directory

Example:
chmod 1777 /shared

## 13. Important Files

/etc/passwd
/etc/shadow
/etc/group
/etc/sudoers

## Interview Questions

1. What is chmod 755?
2. What is the difference between chmod and chown?
3. What is SUID?
4. What is SGID?
5. What is the sticky bit?
6. How do you add a user to a group?
7. How do you check which groups a user belongs to?
