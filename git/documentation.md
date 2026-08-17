## Important Git Interview Questions

## You should prepare these:

## Beginner
Q1 What is Git?

Ans:- 
Git is a distributed version control system used to track changes in source code and files.
It allows developers to:
Track code changes
Create branches
Collaborate with other developers
Maintain different versions of code
Revert changes
Merge changes
Work locally without always requiring a central server
Git maintains the complete history of changes in a repository.

Q2 Git vs GitHub?
Ans: 
Git is the version control software, whereas GitHub is a cloud-based platform that hosts Git repositories and provides collaboration features.

Git                         	GitHub
Version control system  	Repository hosting platform
Runs locally            	Cloud/web platform
Tracks changes          	Hosts repositories
Branching/merging       	Pull Requests
Commit history          	Code review
CLI tool                	Web UI + Git services

Q3 What is a repository?
Ans : 
A Git repository is a directory that contains the project files along with Git's metadata and history.
There are two common types:
Local repository
Located on your machine.
Developer Machine
      ↓
Local Git Repository

Remote repository
Hosted on platforms such as GitHub/GitLab.
Developer
    ↓
Local Repository
    ↓
Remote Repository

The .git directory contains Git's internal information.

Q4 What is a commit?
Ans:
A commit is a snapshot of changes recorded in the Git repository.
A commit contains information such as:
Changes
Author
Timestamp
Commit message
Parent commit
Commit hash

Example:
git commit -m "Add Kubernetes deployment"
A commit receives a unique SHA/hash.


Q5 What is staging?
Ans: 
The staging area is an intermediate area between the working directory and the Git repository.
The typical flow is:
Working Directory
       ↓
    git add
       ↓
Staging Area
       ↓
   git commit
       ↓
Git Repository


Q6 git add vs git commit?
Ans :-
git add
Moves changes into the staging area.
git add file.txt

git commit
Records staged changes into the local repository.

git commit -m "Update configuration"

Flow:

Modify file
    ↓
git add
    ↓
Staging
    ↓
git commit
    ↓
Local repository

Q7 git fetch vs git pull?
Ans:
git fetch
Downloads changes from the remote repository but does not modify your current working branch.
git fetch origin

git pull

Normally performs:
git fetch
+
git merge

So:
git pull

downloads remote changes and integrates them into your current branch.

Q8 What is .gitignore?
Ans: 
.gitignore specifies files and directories that Git should not track.
Common examples:
.env
*.log
node_modules/
target/
*.tmp

For example:
.env
*.log

This prevents sensitive files, generated files, and temporary files from accidentally being committed.
Important interview point:
.gitignore does not automatically remove a file that is already tracked.

Q9 What is a branch?
Ans :
A branch is a separate line of development that allows developers to work on changes independently without directly modifying the main production code.
Example:

main
 │
 ├── feature/login
 │
 ├── feature/payment
 │
 └── bugfix/redis-timeout

Typical workflow:

main
 ↓
feature branch
 ↓
Development
 ↓
Pull Request
 ↓
Code Review
 ↓
Merge


Q10 What is HEAD?
Ans:
HEAD is a reference that points to the current checked-out commit or branch.

Normally:
HEAD
 ↓
main
 ↓
Latest Commit

If I switch to another branch:

git switch feature
HEAD points to the feature branch.
```text
You can check it with:
git status

or:
git log --oneline


## intermediate

Merge vs rebase?
What is a Pull Request?
How do you resolve merge conflicts?
What is git stash?
git reset vs git revert?
What is cherry-pick?
What is a detached HEAD?
How do you undo the last commit?
How do you recover deleted commits?
What is a remote repository?


## Devops focused

DevOps-focused
How does Git integrate with Jenkins?
How does Git trigger CI/CD?
How does Git work with Argo CD?
What is GitOps?
What branching strategy does your organization use?
How do you protect the main branch?
How do you handle a production hotfix?
How do you resolve conflicts during a PR?
What happens after a PR is merged?
How would you design a Git workflow for a DevOps team?
