# Common git commands

# --------------------------------------------------------------------------------
#  Concepts
# --------------------------------------------------------------------------------
# Remote - A remote repository located on some server.
# Local - The local repository that resides on your machine.
# Working Directory - The contents of files on disk.
# Staging - The layer between the local repository and working directory. "Staged" changes are changes ready to be committed into the repository.
# HEAD - Current commit that is checked out.

# --------------------------------------------------------------------------------
#  Creating Repositories
# --------------------------------------------------------------------------------
# Clone a remote repository into a local repository in directory some-repo.
git clone URL some-repo
cd some-repo

# --------------------------------------------------------------------------------
#  Inspection
# --------------------------------------------------------------------------------
# HEAD is the current commit that is checked out.
# See what files are tracked or what changes are not committed.
git status

# See commit history of all files or a single file.
git log
git log filename

# See commit history; one line one commit.
git log --oneline

# See commit history for all branches.
git log --oneline --branches=*

# See last 7 commits.
git log -n 7

# --------------------------------------------------------------------------------
#  Making Changes
# --------------------------------------------------------------------------------
# Stage changes for all files/single file.
git add *
git add filename

# See modifications in all files/single file.
git diff *
git diff filename

# See differences between branch1 and branch2.
git diff branch1..branch2

# Save changes to the local repository.
git commit -m "Commit message"

# --------------------------------------------------------------------------------
#  Stashing - Switching between changes
# --------------------------------------------------------------------------------
# Save staged and unstaged modifications to tracked files and revert these modifications.
git stash

# Associate a message with the stash as a reminder.
git stash save "Stash message"

# Same as stash but also save untracked files.
git stash -u

# Same as stash -u but also save changes to ignored files.
git stash -a

# See all stashes.
git stash list

# Reapply the top-most stash/a specific stash.
git stash pop
git stash pop 'stash@{1}'

# See differences in each file stashed.
git stash show -p

# Create a new branch based on a stash.
git stash branch branchname 'stash@{0}'

# Delete a single stash.
git stash drop 'stash@{2}'

# Delete all stashes.
git stash clear

# --------------------------------------------------------------------------------
#  Ignoring certain changes.
# --------------------------------------------------------------------------------
# Add directory-name/* to ignore the contents of the directory.

# --------------------------------------------------------------------------------
#  Create pointers to certain commits.
# --------------------------------------------------------------------------------
# Tags come in two types: annotated and lightweight. Annotated tags contain more
# metadata like tagger name, email, and date.

# List all tags
git tag

# List all tags containing the regex expression.
git tag -l *EC*

# Create a lightweight tag at HEAD/another commit.
git tag tagname
git tag tagname adc69aadffad9dce5883dbb6d98ae9624c999ce4

# Create an annotated tag at HEAD/another commit.
git tag -a tagname -m "tag message"
git tag -a tagname -m "tag message" adc69aadffad9dce5883dbb6d98ae9624c999ce4

# Update an existing tag with -f.
git tag -a -f initial-change -m "tag message" adc69aadffad9dce5883dbb6d98ae9624c999ce4

# Inspect/checkout the commit from a tag. This puts HEAD in a detached state; it's not
# associated with any branch.
git checkout tagname

# Revert back the checkout to a tag.
git switch -

# Create a branch at HEAD when it's detached.
git switch -c branchname

# Remove a tag.
git tag -d tagname

# Pushing tags. By default, tags are not pushed to remote repositories.
git push origin tagname
git push origin --tags tag1 tag2

# --------------------------------------------------------------------------------
#  Undoing.
# --------------------------------------------------------------------------------
# Make local copy point to an older commit; HEAD becomes detached.
git checkout adc69aa

# Modify a file such that it matches and older version.
# This older version can be modified and then committed as a new commit.
# HEAD is not detached.
git checkout adc69aa filename

# Make local copy point to another branch.
git checkout branchname

# After fetch --all, make HEAD point to a remote branch. Detaches HEAD.
git checkout origin/remotebranch

# Create a new commit that undoes the last commit.
git revert HEAD

# Revert all commits and modifications to tracked files to a remote branch's/
# local branch's last commit.
git reset --hard origin/remotebranch
git reset --hard branchname

# Revert the version of filename to HEAD's version.
git reset HEAD filename
git reset commitreference filename

# Undo all staged changes.
git reset --mixed

# Discard changes of filename in working directory.
git checkout -- filename

# Include current staged changes into last commit and change commit message.
git commit --amend -m "new message"

# Change a commit but don't change commit message.
git commit --amend --no-edit

# --------------------------------------------------------------------------------
#  Branching
# --------------------------------------------------------------------------------
# See all local branches.
git branch

# See all remote branches.
git branch -r

# See all branches.
git branch -a

# Rename current branch to new_name
git branch -m new_name

# Rename branch old_name to new_name
git branch -m old_name new_name

# Create a new branch called newbranch.
git checkout -b newbranch

# Create a new branch based on another local branch.
git checkout -b newbranch otherbranch

# Create a new branch based on another remote branch
git checkout -b newbranch origin/otherbranch

# --------------------------------------------------------------------------------
#  Merging Branches
# --------------------------------------------------------------------------------
# Merge local branch or origin/remotebranch into the current branch.
git merge otherbranch
git merge origin/remotebranch

# Merge otherbranch into current branch and ensure that it is not a fast-forward merge.
# A fast-forward merge occurs when the base commit of one of the branches is the tip
# of otherbranch.
git merge --no-ff otherbranch

# Take commits from current branch and apply to head of otherbranch.
git rebase otherbranch

# Move the base of a branch branchname from oldbranch to newbranch.
git rebase --onto newbranch oldbranch branchname

# --------------------------------------------------------------------------------
#  Syncing with Remote Repositories
# --------------------------------------------------------------------------------
# View references/aliases to remote repositories. -v includes the URL.
# When a remote repository is cloned, git automatically creates origin to refer to it.
git remote
git remote -v

# Add remote repositories.
git remote add name URL

# Remove remote repositories.
git remote rm name

# Rename a remote.
git remote rename oldname newname

# Download but don't merge from origin.
git fetch

# Download but don't merge from a remotename.
git fetch remotename

# Download but don't merge contents from all remotes.
git fetch --all

# Download but don't merge a specific branch from a remote.
git fetch origin branchname

# Push local changes of current branch to origin or a remotename.
git push
git push remotename

# Push all branches to remotename.
git push remotename --all

# Push the local branchname to remotename.
git push remotename branchname

# Delete branchname on remotename.
git push remotename --delete branchname

# Download changes for current branch from origin and merge immediately.
git pull

# Download and merge for current branch from a remotename.
git pull remotename

# Pull from a remotename but don't create a commit when merging.
git pull --no-commit remotename

# Pull and instead of merging, rebase to integrate local branch.
git pull remotename --rebase

# More details on what is downloaded and merged.
git pull --verbose
