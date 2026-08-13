# Git Troubleshooting

## Check Repository

git status

## Check Remote

git remote -v

## Check Branch

git branch

## Problem: Nothing to Commit

Run:

git status

If files are untracked:

git add .

git commit -m "Add files"

## Problem: Push Rejected

First pull:

git pull --rebase origin main

Then:

git push origin main

## Problem: Wrong Branch

Check:

git branch

Rename branch:

git branch -M main

Push:

git push -u origin main

## Problem: Merge Conflict

Check:

git status

Open the conflicted file.

Resolve the conflict.

Then:

git add .

git commit -m "Resolve merge conflict"

## Undo Staging

git restore --staged filename

## Discard Local File Changes

git restore filename

WARNING:
This removes uncommitted changes.

## View Commit History

git log --oneline --graph --all

## Find Remote URL

git remote -v

## Change Remote URL

git remote set-url origin NEW_URL

## Git Safe Troubleshooting Flow

git status
    |
    v
git branch
    |
    v
git remote -v
    |
    v
git log --oneline
    |
    v
git diff
