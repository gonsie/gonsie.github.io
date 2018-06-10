---
title: GitHub Repositories on AMOS
category: notes
layout: old_default
---

# GitHub Repositories on CCI Machines

Since there are no holes poked in the RPI firewall for GitHub, we have to manually push from local machines to the landing pads.
The process is easy, but requires some set up. As always, I recommend using an SSH config file.

In this example, I will follow the best practices highlighted [here](ccni-gpfs.html).

My personal details are:

- Group: RSNT
- Username: RSNTgons
- Repository: ~/Projects/ROSS
- Nickname for CCI Machine: amos

## Setup

### CCI
Create and configure the target repository:

	$ ssh RSNTgons@lp01.ccni.rpi.edu
	$ ssh q
	$ cd /gpfs/lb/provisioned/RSNT/RSNTgons
	$ mkdir ROSS
	$ cd ROSS
	$ git init
	$ git config receive.denyCurrentBranch ignore

### Local
Your local machine should be on RPI campus (and thus allowed through the CCI firewall). Add the remote location to your local repository:

	$ cd ~/Projects/ROSS
	$ git remote add amos RSNTgons@lp01.ccni.rpi.edu:/gpfs/lb/provisioned/RSNT/RSNTgons/ROSS

Now you are ready to push your repository to the CCI.

## Updating your CCI repository

You must follow both of these step everytime you update your repository on the CCI machines. Your git repository must be `reset` after each push.

### Local Push

	$ cd ~/Projects/ROSS
	$ git push amos master

### CCI Receive

        $ ssh RSNTgons@lp01.ccni.rpi.edu
        $ ssh q
        $ cd /gpfs/lb/provisioned/RSNT/RSNTgons/ROSS
        $ git reset --hard HEAD

## WARNING

If you follow these instructions, any repository changes/commits you make on CCI machines will be **overwritten** when you do the `git push` command. It is recommended that you *do not* make any repository changes on CCI machines.

## Advanced Git

### Branches

When pushing to the CCI, you want to make sure you are pushing on top of the correct branch for a repository. This way, the `git reset` command simply resets the branch to the latest commit.

#### Scenario

You are developing a branch on your local machine, and would like to test it using the CCI.

#### Workflow

Create and switch to the branch you want to work on, on the CCI machine.

	$ git checkout -b newBranch

Push the branch from your local machine:

	$ git push amos newBranch

Reset the git head on the CCI machine:

	$ git reset --hard HEAD

Your CCI machine should now be up to date. When using multiple branches on your CCI machine, make sure the proper branch is checked out before you push changes on top of it.

### Commiting Changes on the CCI Machine

If you want to do development while on the CCI machines, you will need to pull your changes off of the machine. There is no direct step to go from the CCI to GitHub. You will need to use your local machine to pull from the CCI and push to GitHub. From your local machine the workflow looks like:

	$ git pull amos master
	$ git push origin master

