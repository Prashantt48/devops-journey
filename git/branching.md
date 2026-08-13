# Git Branching

## Check Current Branch

git branch

## Create Branch

git branch feature/linux

## Switch Branch

git switch feature/linux

## Create and Switch

git switch -c feature/linux

## List Branches

git branch

git branch -a

## Work on Feature Branch

git switch feature/linux

Create or modify files.

git add .

git commit -m "Add Linux documentation"

## Push Feature Branch

git push -u origin feature/linux

## Merge Branch

Switch to main:

git switch main

Pull latest changes:

git pull origin main

Merge feature branch:

git merge feature/linux

Push:

git push origin main

## Delete Local Branch

git branch -d feature/linux

## Delete Remote Branch

git push origin --delete feature/linux

## Recommended Workflow

main
 |
 +---- feature/linux
 |
 +---- feature/docker
 |
 +---- feature/kubernetes

Developer creates feature branch.

git switch -c feature/linux

Make changes.

git add .

git commit -m "Add Linux documentation"

Push branch.

git push -u origin feature/linux

Create Pull Request on GitHub.

Review.

Merge into main.

Update local main:

git switch main

git pull origin main
