# Git Commands

## Repository Setup

### Initialize repository

git init

### Check Git version

git --version

### Check repository status

git status

## Clone Repository

git clone https://github.com/USERNAME/REPOSITORY.git

cd REPOSITORY

## Git Configuration

git config --global user.name "Your Name"

git config --global user.email "your@email.com"

git config --global --list

## Working with Files

### Check status

git status

### Add one file

git add README.md

### Add directory

git add linux/

### Add everything

git add .

## Commit

git commit -m "Add Linux documentation"

## View Commits

git log

git log --oneline

git log --oneline --graph --all

## Remote Repository

### Show remote

git remote -v

### Add remote

git remote add origin https://github.com/USERNAME/REPOSITORY.git

### Change remote

git remote set-url origin https://github.com/USERNAME/REPOSITORY.git

## Push

git push origin main

### First push

git push -u origin main

### Future pushes

git push

## Pull

git pull origin main

## Fetch

git fetch

## Difference

git diff

### Staged changes

git diff --cached

## Remove File

git rm file.txt

## Rename File

git mv old.txt new.txt

## Git Log

git log --oneline

git log --stat

## Useful Commands

git status
git branch
git remote -v
git log --oneline
git diff
git fetch
git pull
git push
