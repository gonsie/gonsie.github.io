---
title: GitHub Repositories on AMOS
category: notes
layout: notes
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

