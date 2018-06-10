---
layout: old_default
title:  Unix and the Command Line
---

* this will become a table of contents
{:toc}

Understanding and using the command line is a key skill for any computer user.
The <mark>command line interface (CLI)</mark>[^1] is the original way in which humans interacted with computers.
This interaction is done through the <mark>shell</mark>.
It is no longer necessary to use computers in this way since most tasks can be accomplished through the GUI[^2].
Nevertheless, the command line interface remains the most common, easiest to use, and best supported way in which expericenced users accomplish daily tasks.

### Installation

In general the Mac OS is a Unix operating system, one that is very similar to Linux operating systems.
Windows, on the other hand, is a DOS-based operating system which is very different from -nix.
For any of these systems, there is a built-in application for the interacting with your computer via a CLI.

#### Mac Installation

You're in luck!
Since Mac OS is based upon Unix, there is nothing for you install.
To access the command line interface, simply run the Terminal application.
The Terminal application can be found in the Utilities folder inside the Application folder.

#### Linux Installation

Just like a Mac, you are working with a -nix based system and there is nothing new to install!
To access the command line interface, simply run the Terminal application.
The Terminal application can most likely be found where ever your other Applications exist.

#### Windows Installation

Since Windows is not a -nix-based operating system, the command line interface that comes with your machince is vastly different from a -nix shell.
For your own information, the Windows CLI is called [PowerShell](https://en.wikipedia.org/wiki/Windows_PowerShell).
For this workshop you will need to install a -nix-like interface for your computer.

***Step 1: Install Babun***

[Babun](http://babun.github.io) is an open source project which brings the Unix command line to your Windows machine.

Download Babun Here: <http://projects.reficio.org/babun/download>.

This project is built on top of the popular [Cygwin](http://cygwin.com) project.
If you already have Cygwin installed, it is not necessary to install Babun, but you can.
The two projects will not clash.

***Step 2: ???***

As you may have noticed, I do not have a Windows machine.
Thus, I do not know what step 2 is.
You probably need to run an installer?
See what happens and, if you want, let me know the important steps so I can share those with others.

### Commands on the Command Line

Welcome to the command line interface!
You are probably staring a big blank box with some text in the upper left corner, maybe something like:

```
MyMacBook:~ elsa$
```

Hit the Enter or return key.
You should see the same text appear over and over.
This text is called the <mark>prompt</mark>.
It is very common to have `$` or `>` symbol at the end of your prompt text, indicating where you will enter commands.

#### Lingo

| Command | Arugment | Option | Argument for Option | Another Option |
|---------+----------+--------+---------------------+----------------|
| g++     | main.cpp | -o     | main.out            | -W             |


<mark>Commands</mark> take <mark>arguments</mark> and have <mark>options</mark>.
One-letter options usually start with a single dash (`-`) while multi-letter options start with two dashes (`--`).
Options may also take an argument.

#### Bread-and-Butter Commands

| Example Usage                 | Description                                             |
|-------------------------------+---------------------------------------------------------|
| `ls ~/Desktop`                | list files (on the desktop)                             |
| `pwd`                         | present working directory, or, where am I?              |
| `cd ~/Desktop`                | change directory (to the desktop)                       |
| `mkdir FOLDER`                | make a directory (called FOLDER)                        |
| `cat notes.txt`               | concatenate the contents (of notes.txt) to the terminal |
| `echo "hello"`                | repeat after me                                         |
| `cp notes.txt notes-copy.txt` | make a copy (of notes.txt to new file notes-copy.txt)   |
| `mv notes-copy.txt tmp.txt`   | move the file (renames notes-copy.txt to tmp.txt)       |
| `man git`                     | read the man pages (about the git command)              |
| `rm notes.txt`                | remove (the notes.txt file)                             |

#### Learning More About Commands

Almost all commands come with either a `-h` or `--help` option.
Sometimes, the text is more detailed in the "longer" `--help` option.
The manual for each command, called the <mark>man pages</mark>, are also installed.
These are accessed by the command `man`.

#### Try it!

Get to know the commands on your own by trying to accomplish the following tasks:

- When you open a new terminal window, where are you?
  This is called your <mark>home</mark> directory.
- Make a new folder on the desktop.
  What happens if you try to put a space in the name of the folder?
- Use any software you choose to write a file in your new folder.
  - How can you see the contents of the file?
  - Can you move that file to a new folder?
- Does your computer have the `open` command?
  If so, what does it do?

### Filenames and Paths

A [file system](https://en.wikipedia.org/wiki/File_system) is different from the operating system.
This is an important distinction when we are working with files.

### Redirection

### Dotfiles

As you may have seen through the `ls` command, there are several *hidden* files in your file system.
These filenames usually begin with a dot (`.`), such as `.gitconfig` or `.gitignore`.
To list all files in a directory, including the hidden files, use `ls -A`.

Dotfiles usually hold the settings for the command line tools you use.
This includes color settings, command shortcuts, environment variables, load packages, and more!

#### Repositories

Since dotfiles customize how you interact with the command line, many people have shared their personal dotfiles through GitHub.
By browsing the dotfiles repositories, you can find new tricks that will make your life easier!

#### .inputrc

The .inputrc file works with the bash shell (and others) to customize how you interact with the command line itself.
I find the following settings to be *essential* on any shell that I use:

- Allowing the use of the arrow keys to view the most recently entered commands
- Showing all matching possibilities when multiple exist (useful when trying to TAB complete a filename)
- Allowing for case-insensitive matching when typing a path or filename

Simply place the following in a `.inputrc` file in your home directory:

```
"\e[A": history-search-backward
"\e[B": history-search-forward
set show-all-if-ambiguous on
set completion-ignore-case on
```

---

[^1]: [Wikipedia: command line interfaces and the shell](https://en.wikipedia.org/wiki/Command-line_interface)

[^2]: [Wikipedia: GUI or Graphical User Interface](https://en.wikipedia.org/wiki/Graphical_user_interface)
