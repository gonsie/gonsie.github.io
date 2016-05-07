---
layout: default
title:  Git
---

* this will become a table of contents
{:toc}

Git is a program for <mark>version tracking</mark>.
It tracks the changes that you (and others) make to files within a <mark>repository</mark>.

### Installing Git

The installation step for any software package or application depends on the machine where it is being installed[^3].
The "official" instructions for installing Git on your system can be found [here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

To test if you have git installed, type the `git` command into your terminal.
If you **do** have git installed, you will see a long messages describing how to use the git program.
The message starts with:

```
usage: git [--version] [--help] [-C <path>] [-c name=value]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]
    ...
```

#### Mac Installation

If you tried the `git` command in your terminal and you **do not** have git installed on you system, a message will display with details about how to install it.

#### Linux Installation

If you are running a Linux machine, you should open your Terminal application and install git through your package manager.

On a Fedora system the command is:
```
$ sudo yum install git-all
```

On a Debian-based system, such as Ubuntu, the command should be:
```
$ sudo apt-get install git-all
```

#### Windows Installation

If you used the instructions above to install Babun, you are all set!
If you would like to install git at a system-level, follow the ["official" instructions](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git#Installing-on-Windows).

### Command Line Git

Git, as a command line tool, is a program which takes its own set of commands.

#### Man Pages

The git program on your computer which takes it own set of commands.
Thus, `man git` may not contain useful information about a particular git command.
Instead, you can lookup `man git-init` or `man git-pull`.

### Setting Up Your Computer

When you make a commit, some additional information is automatically recorded, including:

- Date and Time
- Author of the Commit (you!)
- Author's email address

To configure the *global* git settings for your computer, type the following:

```
$ git config --global user.name "My Full Name"
$ git config --global user.email myemail@domain.com
```

### Git GUIs

I believe that learning git on the command line

Now that you know the basics of the git commands, you can understand what the GUI's are doing for you.

---

[^3]: Requiring machine-specific installation instructions can be a pain for programmers.
      Recently, programmers have been able to take advantage operating-system-level virtualizations called <mark>containers</mark>, such as [Docker](https://www.docker.com).
      Containers serve as way to specify the dependencies of a certain piece of software and abstract the need to specify the underlying hardware.
