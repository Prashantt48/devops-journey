## Important Git Interview Questions

## You should prepare these:

## Beginner

1. What is Git?

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

2. Git vs GitHub?

Ans: 

Git is the version control software, whereas GitHub is a cloud-based platform that hosts Git repositories and provides collaboration features.

Git                                  	GitHub
Version control system  	        Repository hosting platform
Runs locally            	        Cloud/web platform
Tracks changes          	        Hosts repositories
Branching/merging       	        Pull Requests
Commit history          	        Code review
CLI tool                	        Web UI + Git services

3. What is a repository?

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

4. What is a commit?

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


5. What is staging?

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


6. git add vs git commit?

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

7. git fetch vs git pull?

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

8. What is .gitignore?

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

9. What is a branch?

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


10. What is HEAD?

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
You can check it with:
git status

or:
git log --oneline


## intermediate

01. Merge vs rebase?

Ans:

Merge
Merge combines two branches and generally creates a merge commit when needed.

main
 A---B---C
      \
       D---E feature
            \
             M

Advantages:

Preserves branch history
Safer for shared branches
Doesn't rewrite existing commits

Command:

git merge main

Rebase
Rebase moves/replays your commits on top of another branch.

Before:


main     A---B---C
              \
feature         D---E


After rebase:


main     A---B---C
                  \
feature            D'---E'

Advantages:
Cleaner linear history
Useful before creating a PR

But rebase rewrites commit history.

02. What is a Pull Request?

Ans : 
A Pull Request is a request to merge changes from one branch into another branch.

Example:

feature/payment
       ↓
Pull Request
       ↓
main

A PR usually involves:
Code review
Automated tests
Security checks
Approval
Merge

In a DevOps environment, CI pipelines are commonly triggered when a PR is created or updated.

03. How do you resolve merge conflicts?

Ans: 
A merge conflict occurs when Git cannot automatically determine which changes should be retained.

Example:

Developer A → modifies same line
Developer B → modifies same line
                     ↓
                Conflict

My process is:

Identify conflict
      ↓
Open conflicted file
      ↓
Understand both changes
      ↓
Keep correct implementation
      ↓
Remove conflict markers
      ↓
git add
      ↓
git commit / continue merge
      ↓
Run tests

Conflict markers look like:

HEAD
Current branch
Incoming branch
feature

After resolving:

git add file

Then complete the merge.


04. What is git stash?

Ans:
git stash temporarily stores uncommitted changes so that I can switch branches or perform another Git operation without committing incomplete work.

Example:

git stash

Later:

git stash pop

Useful when:
I am working on a feature but suddenly need to switch to another branch for a production issue.
I can stash my unfinished changes, fix the production issue, and then restore my work.


05. git reset vs git revert?

Ans:
Reset

Moves the branch pointer backward and can modify/remove commits from the current branch history.

Types include:

--soft
--mixed
--hard

Example:

git reset --soft HEAD~1
Revert

Creates a new commit that reverses the changes introduced by an earlier commit.

git revert <commit>
Interview answer:

For shared or production branches, I prefer git revert because it preserves the existing history. I use git reset mainly for local or private branches when I need to modify local history.



06. What is cherry-pick?

Ans:
git cherry-pick applies the changes from a specific commit to the current branch.

Example:

main
 A---B---C


hotfix
 A---B---C---D

If I need only commit D in another branch:

git cherry-pick D

It is useful when I need a specific fix without merging the entire branch.

Production example:
If a bug fix exists in a development branch but I need only that particular fix in the production branch, I can cherry-pick the specific commit after appropriate testing and approval.

07. What is a detached HEAD?

Ans:
A detached HEAD occurs when HEAD points directly to a commit rather than a branch.

For example:
git checkout <commit-id>

You are now inspecting that particular commit.

HEAD
 ↓
Commit

instead of:

HEAD
 ↓
Branch
 ↓
Commit

If you make commits in detached HEAD and want to keep them, create a branch:

git switch -c my-new-branch

08. How do you undo the last commit?

Ans:
There are multiple approaches depending on the situation.

If I want to keep the changes staged:
git reset --soft HEAD~1
If I want to keep the changes but unstage them:
git reset HEAD~1
If I want to discard the commit and its changes:
git reset --hard HEAD~1
For a shared branch:
git revert HEAD

Interview answer:

I choose the method based on whether the commit has already been pushed and whether I need to preserve the changes. For shared branches, I prefer revert rather than rewriting history.


09. How do you recover deleted commits?

Ans:
Git often retains unreachable commits for some time.
I can use:

git reflog

reflog records movements of HEAD and branch references.

For example:

git reflog

Find the required commit and create a branch:

git switch -c recovery <commit-id>

This is a very useful Git recovery mechanism.

10. What is a remote repository?

Ans:
A remote repository is a Git repository hosted somewhere outside the local machine, such as GitHub, GitLab, or Bitbucket.

Example:

Local Repository
      ↓
    origin
      ↓
GitHub Repository

Check remotes:

git remote -v

origin is commonly the default name given to the primary remote repository.

## Devops focused

1. How does Git integrate with Jenkins?

Git acts as the source code repository, while Jenkins performs CI/CD automation.

Typical workflow:

Developer
    ↓
GitHub
    ↓
Webhook
    ↓
Jenkins
    ↓
Checkout Code
    ↓
Build
    ↓
Test
    ↓
Security Scan
    ↓
Docker Build
    ↓
Push Image

Jenkins can trigger builds based on:

Push
Pull Request
Webhook
Scheduled job
Manual trigger

2. How does Git trigger CI/CD?

Answer:

A common mechanism is a webhook.

For example:

Developer
    ↓
git push
    ↓
GitHub
    ↓
Webhook
    ↓
Jenkins
    ↓
Pipeline

Jenkins receives the webhook and starts the appropriate pipeline.

The pipeline might:

Checkout
 ↓
Build
 ↓
Test
 ↓
Docker Build
 ↓
Security Scan
 ↓
Push Image
 ↓
Deploy

3. How does Git work with Argo CD?

This is especially important for Kubernetes/GitOps interviews.

Argo CD continuously monitors a Git repository containing the desired Kubernetes configuration.

Git Repository
      ↓
Kubernetes YAML / Helm
      ↓
Argo CD
      ↓
Kubernetes Cluster

Argo CD compares:

Desired State
     vs
Actual State

If auto-sync is enabled, Argo CD can synchronize the cluster with the desired state.

Interview answer:

Git acts as the source of truth, while Argo CD continuously reconciles the Kubernetes cluster with the configuration stored in Git.

4. What is GitOps?

Answer:

GitOps is a methodology where Git is used as the source of truth for infrastructure and application configuration, and automated systems continuously reconcile the actual environment with the desired state.

Typical flow:

Developer
    ↓
Git
    ↓
Pull Request
    ↓
Review
    ↓
Merge
    ↓
Argo CD
    ↓
Kubernetes

Key principles:

Git as source of truth
Declarative configuration
Automated reconciliation
Version control
Auditable changes
Easy rollback

5. What branching strategy does your organization use?

For a DevOps interview, a good answer is:

We use a controlled branch-based workflow. Developers work on feature or bug-fix branches, create Pull Requests against the main/development branch, and changes go through code review and automated CI checks before merging. Production changes are controlled through protected branches and release processes.

Example:

main
 │
 ├── feature/*
 ├── bugfix/*
 └── hotfix/*

Don't claim a specific strategy such as GitFlow unless you actually used it.

6. How do you protect the main branch?

Answer:

I would use GitHub/GitLab branch protection policies.

Typical controls:

Pull Request required
Minimum approvals
CI checks required
No direct push
No force push
Code review
Status checks
Security scanning
Required reviewers

Workflow:

Developer
    ↓
Feature Branch
    ↓
Pull Request
    ↓
CI Checks
    ↓
Code Review
    ↓
Approval
    ↓
Merge
    ↓
Main

7. How do you handle a production hotfix?

A good interview answer:

First, I identify and validate the production issue. I create a dedicated hotfix branch from the appropriate production/release branch, implement the minimum required change, test it, raise a Pull Request, and run the required CI checks. After approval, I merge and deploy through the controlled production process. I then ensure the fix is also propagated to the main development branch if required.

Example:

Production
    ↓
hotfix/redis-timeout
    ↓
Fix
    ↓
Test
    ↓
PR
    ↓
Review
    ↓
CI
    ↓
Production

8. How do you resolve conflicts during a PR?

Answer:

I first understand which changes are required from both branches.

Typical process:

git fetch origin
git checkout feature
git rebase origin/main

Then resolve conflicts.

git status

Edit conflicted files and then:

git add <file>
git rebase --continue

After completing the rebase, I run tests.

If the branch has already been pushed, rebasing may require:

git push --force-with-lease

I would use this only when appropriate and after ensuring that I am not overwriting someone else's work.

9. What happens after a PR is merged?

A typical DevOps workflow is:

Pull Request
     ↓
Code Review
     ↓
CI Checks
     ↓
Approval
     ↓
Merge
     ↓
Main Branch
     ↓
CI/CD Pipeline
     ↓
Build
     ↓
Test
     ↓
Docker Image
     ↓
Registry
     ↓
Deployment

In a GitOps environment:

Main
 ↓
Manifest/Image version update
 ↓
Argo CD
 ↓
Kubernetes

10. How would you design a Git workflow for a DevOps team?

This is an excellent senior-level interview question.

My answer:

I would design the workflow around protected branches, short-lived feature branches, Pull Requests, mandatory code reviews, automated CI checks, and controlled production deployment.

Architecture:

                    GitHub
                       │
              ┌────────┴────────┐
              ↓                 ↓
         Feature Branch     Hotfix Branch
              │                 │
              └────────┬────────┘
                       ↓
                  Pull Request
                       ↓
                  Code Review
                       ↓
                  Jenkins CI
              ┌────────┼────────┐
              ↓        ↓        ↓
            Build     Test    Security
                       │
                       ↓
                    Approval
                       ↓
                    main
                       ↓
                  Docker Image
                       ↓
                    Registry
                       ↓
                    Argo CD
                       ↓
                  Kubernetes

I would also implement:

Protected main
PR approval
Automated testing
Security scanning
No direct production changes
Versioned releases
Rollback strategy
Git audit history
Separate application and environment configuration where appropriate
