---
title: Converting from Sublime Text to Emacs
layout: post
---

-   [Motivation](#motivation)
-   [Prerequisites](#prerequisites)
-   [The Basics](#the-basics)
-   [The Best from Sublime Text](#the-best-from-sublime-text)
-   [Things That Never Really Worked in ST](#things-that-never-really-worked-in-st)
-   [Org-mode](#org-mode)
-   [Conclusion](#conclusion)

Motivation
==========

Until recently, Sublime Text (ST) has been my go-to code editor,
especially when working on projects. The multi-cursor capabilities
completely changed my life and I can\'t imagine living without them.
Other than that, ST makes everything else pretty easy: simple package
management, straight forward project navigation, easy synchronization
across systems.

For the past couple of months, I have been working closely with someone
who is an expert in Emacs and uses org-mode throughout his workday. The
power of tangling and exporting from a single document makes so much
*sense*, I just have to try it. I\'ve always been a member of Team Emacs
and I even created my first GitHub read-me in org syntax. But, without
someone\'s door to knock on, I didn\'t truly understand the full power
of org-mode and it didn\'t stick.

In this post I attempt to document my transition from Sublime Text 3 to
Emacs. The main motivation is for full org-mode support. While there are
some packages for ST that provide some org-mode syntax, full
functionality is lacking. Thus, I want to take everything I\'ve learned
(all the productivity enhancing features) in ST and replicate it with
Emacs.

Throughout this post, I continually come to the same conclusion: Emacs
has support for the weird thing I want to do. Truly, [this XKCD
comic](https://www.xkcd.com/378/) is real.

Setup: I use a Mac (technically 2, one at home and one at work) with the
latest Emacs installed via Homebrew. Based on [this
post](https://blog.aaronbieber.com/2016/12/29/don-t-use-terminal-emacs.html)
from Aaron Bieber, I have been mainly using Emacs through the GUI
program.

Prerequisites
=============

I\'m sure there are several resources for those who are just [getting
started with Emacs](https://www.gnu.org/software/emacs/tour/index.html).
I will cover just the basics that you should know before reading the
rest of this post.

Assumptions
-----------

You should know the basics of Emacs, meaning:

-   Understand chords, such as `C-x C-c`.
-   Get help with `C-h ?`
-   Quit (usually used for a chord gone-wrong) with `C-g`
-   Understand how to check your Emacs environment
    -   `M-x describe-key`
    -   `M-x describe-variable`
    -   `M-x describe-function` (run this before trying
        `C-x M-c butterfly`).
-   Understand buffers and windows
    -   Switch between open windows with `C-x o`
    -   Remove this window with `C-x 0`
    -   Split this window in half horizontally, `C-x 2`, or vertically
        `C-x 3`.
    -   Switch to another buffer with `C-x b`

Knowing these things should get you pretty far... and prevent you from
breaking too many things. For the rest, just google it!

Package Management
------------------

Emacs supports many package managers, but the most popular one is
[MELPA](http://melpa.org/#/). Check the MELPA website for the latest
[installation instructions](http://melpa.org/#/getting-started). Once
MELPA is configured, you can manually install packages with:

{% highlight elisp %}
M-x package-install RET package-name
{% endhighlight %}

On top of MELPA, I use the [use-package](http://melpa.org/#/use-package)
package to organize all of the packages I need. This works especially
well for syncing between multiple machines.

Another solution could be [req-package](http://melpa.org/#/req-package).
This is built on top of use-package, but I haven\'t tried it yet.

Color Theme
-----------

Setting the terminal color scheme is actually a very hard thing to do.
Mainly the conflict arises from where the colors should actually be
specified: in the back-end or front-end. Should Emacs dictate what
\"red\" looks like, or should the terminal program? Plus, getting the
same color scheme in the GUI and terminal can be tricky.

Here is my code for initializing the Emacs color theme. It has a useful
snippet is to set background color for GUI Emacs (which should not be
done when in the Terminal).

{% highlight elisp %}
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-dusk)
     (when (display-graphic-p)
       ;; settings for GUI emacs
       (add-to-list 'default-frame-alist '(background-color . "#282B35"))
       (add-to-list 'default-frame-alist '(foreground-color . "White"))
       (set-frame-font "Inconsolata 18" nil t))))
{% endhighlight %}

I will cover my particular color theme in more detail in a separate
post.

The Basics
==========

There are a few basic things needed for setting up Emacs (or any
editor). If you already have a great Emacs configuration going, just
skip ahead.

Syncing Between Machines
------------------------

For years I have been syncing ST settings and packages with Dropbox.
This worked well until I started working for a company where arbitrary
cloud services are frowned upon. While a cloud solution could work
equally as well with Emacs, I would like my new setup to better support
remote machines.

For my regular UNIX settings (bash profiles and so forth) I use a
[dot-files](https://github.com/gonsie/dotfiles) git repo. This repo gets
cloned to any new machine and includes instructions for getting setup.
It also includes a `synch.sh` script which does two things:

1.  For new installations, any existing dot-files that would be over
    written are saved to a special folder. Then, all of my dot-files are
    installed and symlinked to my home directory.
2.  For existing installations, the synch script will diff the files in
    the repo to those installed. Thus, any changes I\'ve made locally
    can be added back to the repo and committed and shared.

For Emacs specifically, this is where
[use-package](http://melpa.org/#/use-package) comes in. Use-package will
auto-magically handle installing packages when I startup on a new
machine. For now, I have a setup with 3 separate Emacs-related dot
files:

1.  `.emacs`: This file is bare bones. It sets up MELPA and and includes
    instructions for setting up a new machine (such as installing
    use-package). It also makes the calls to load the other 2 files.
2.  `init.el`: This is the file where all my settings live. It doesn\'t
    necessarily need to be separate from the `.emacs` file, but for now,
    it is. All of my use-package declarations live in this file.
3.  `.emacs-custom.el`: This file is where all of my `M-x customize`
    settings go. Many of these variable are machine specific, e.g.,
    which packages are installed and where org files exist.

This setup is a work in progress and may be more convoluted than
necessary.

Trim Spaces
-----------

I absolutely hate extra white space and a newline at the end of a file
is a must. Here are the Emacs settings:

{% highlight elisp %}
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq require-final-newline t)
{% endhighlight %}

Which does the equivalent of these ST options:

{% highlight yaml %}
"trim_trailing_white_space_on_save": true
"ensure_newline_at_eof_on_save": true
{% endhighlight %}

Closing Parenthesis Insertion
-----------------------------

The `autopair` package is built-in to Emacs and will insert the closing
parenthesis. It isn\'t the smartest (such as inserting markup on a
selected word in org-mode), but it works for now. Additionally, since I
assume it is always on, there is no need to show it on my mode line
(which I\'ll get into later). Also, since I\'m now using Emacs and I
find myself editing more and more lisp, I\'ve turned on a mode which
shows the matching open or close parenthesis if one is selected.

{% highlight elisp %}
;; autopair
(autopair-global-mode)
(diminish 'autpair-mode)
(show-paren-mode 1)
{% endhighlight %}

Large Files
-----------

One of the greatest things about ST is its handling of large files. In
Emacs, I can at least set the threshold for warning me about the large
file:

{% highlight elisp %}
;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)
{% endhighlight %}

Adding Language Syntax
----------------------

Emacs has built-in support for many coding languages, but sometimes
you\'ll need to ensure that the right mode is triggered for the correct
filenames and/or extensions. Here are two examples for turning on CMake
file support.

In this first example, it assumes that `cmake-mode` has been installed
manually:

{% highlight elisp %}
;; CMake
(setq auto-mode-alist
      (append
       '(("CMakeLists\\.txt\\'" . cmake-mode))
       '(("\\.cmake\\'" . cmake-mode))
       auto-mode-alist))
{% endhighlight %}

In this second example, `use-package` syntax is used for lazy-loading.
This means we don\'t have to remember to package-install cmake-mode. It
also means that the cmake-mode package is not installed until I open a
CMake file.

{% highlight elisp %}
;; CMake
(use-package cmake-mode
  :mode ("\\.cmake\\'"
         "CMakeLists\\.txt\\'")
  :config (use-package cmake-font-lock))
{% endhighlight %}

Here is another example, but for Rust:

{% highlight elisp %}
;; rust
(use-package rust-mode
  :mode ("\\.rs\\'" . rust-mode))
{% endhighlight %}

The Best from Sublime Text
==========================

There are so many things that Sublime Text just gets right, some things
I never knew I needed until they were at my finger tips.

Project View
------------

One of the features from ST that I have come to expect is the project
sidebar. Having a file browser is key to orienting myself within the
project.

For this, I use [Neotree](http://melpa.org/#/neotree) (some
documentation found [here](https://www.emacswiki.org/emacs/NeoTree)).
Its look and feel can be customized, but I haven\'t experimented with
that yet. I stuck with the suggested keybinding of \<f8\>. To customize
it for Mac, I had to change the default system command to the `open`
program.

{% highlight elisp %}
;; neotree
(use-package neotree
  :bind ([f8] . neotree-toggle)
  :config (setq neo-default-system-application "open"))
{% endhighlight %}

Neotree supports a bunch of functionality in its buffer, including
\"quicklook\" and \"add file here\". The one thing that is missing is
the equivalent of the `dired-do-shell-command`. This would allow me to
place the cursor at a file and trigger some command-line input.
Keybindings which matched (or were similar) to dired\'s would be nice,
but at least neotree supports the `?` key.

Multiple Cursors
----------------

The arguably best thing about ST is the multiple cursors. Once you know
about it, there are some many small things I open in ST just to use it.

Emacs does have its very own
[multiple-cursors](http://melpa.org/#/multiple-cursors) package.
Unfortunately, there are several issues with getting the right
keybindings working on a Mac. Thus, I\'ve dedicated the \<f2\> and
\<f3\> keys for this. I\'ve also used ESC ESC as the quit-this-mode
command (similar to what would work in ST):

{% highlight elisp %}
;; multiple-cursors
(use-package multiple-cursors
  :bind (("<f2>" . mc/mark-previous-like-this)
         ("<f3>" . mc/mark-next-like-this)
         ("C-c <f2>" . mc/mark-all-like-this)
         ("<ESC> <ESC>" . mc/keyboard-quit))
  :ensure t)
{% endhighlight %}

As you get started with multiple-cursors mode, it will ask you several
questions to make sure you really intend to something at all cursors.
The answer is usually yes. Sometimes things get mucked up and multiple
cursors will behave weird in a particular mode. As documented
[here](https://lists.gnu.org/archive/html/Emacs-orgmode/2015-10/msg00380.html),
the solution is remove the `~/.emacs.d/.mc-lists.el` file.

Project-Wide Search
-------------------

After some preliminary exploration, I still haven\'t been able to get a
good cross-file search going. The built-in `M-x grep` does some nice
things, but isn\'t very reliable. I will investigate this further in a
future post.

Spell Check
-----------

My spelling is atrocious, so spell checking is a must. ST on Mac can
turn on the system wide spell checker (with additional functionality to
remember/ignore words). Unfortunately, getting spell checking on Emacs
is much more complicated.

The default spelling program in Emacs is ispell, or interactive spell.
To actually install the ispell dictionary on a Mac you must use homebrew
and tell Emacs where to find the program.

I define the ispell program variable in my custom file since location is
machine specific.

{% highlight elisp %}
(setq ispell-program-name "/usr/local/bin/aspell")
(setq ispell-list-command "--list")
{% endhighlight %}

The only missing element is an always-on spell checker. Another Emacs
package, [Flyspell](https://www.emacswiki.org/emacs/FlySpell), does the
trick. Now I just need to enable `flyspell-mode` by default for
text-type buffers:

{% highlight elisp %}
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))
{% endhighlight %}

Things That Never Really Worked in ST
=====================================

Now there are a couple of things that I could never really get working
with ST. This includes deep git integration and opening a shell. Of
course, Emacs supports these things! Over time, you\'ll slowly come to
the opinion that you should never have to leave Emacs.

Git
---

Emacs git support is done through [magit](https://magit.vc). This is an
amazing project which gives you full git control without leaving Emacs.
Magit works through a series of popups, meaning you only need to know
one keybinding. Once you are in a magit popup, you can figure out how to
do things with the `?` key.

{% highlight elisp %}
;; MAGIT
(use-package magit
  :bind ("C-x g" . magit-status)
  :ensure t)
{% endhighlight %}

Shell Integration
-----------------

Unsurprisingly, Emacs offers deep shell integration. This post on
[Mastering Emacs
Shells](https://masteringemacs.org/article/running-shells-in-emacs-overview)
goes into the nitty-gritty details. There may be some settings needed to
get `M-x shell` working properly with fish. However, `M-x ansi-term`
seems do everything needed, just be careful that you don\'t startup
Emacs inside your Emacs.

For very simple shell one-liners, there is always dired mode. The
command `!` allows you to run a shell command on the selected file. This
works great for generating dot output from a graphviz file. I would
really like a shortcut for opening the selected file from the system,
but `! open` works for now.

Org-mode
========

The absolutely best thing about Emacs is
[org-mode](https://orgmode.org). There is way too much to cover here, so
I\'ll talk about *why* you should consider org-mode and provide links to
checkout. Case-in-point, this entire post was created with org mode.
Unlike the other packages, I manually install org-mode when setting up a
new computer.

Basics Syntax & Outlining
-------------------------

Org-mode is a lot like markdown, at its core it is a syntax for markup
of plain text. Here is the basic markup:

|  Effect                          | Code|
|  --------------------------------| -------------------------------------------------------|
|  *italic*                        | `/italic/`|
|  **bold**                        | `*bold*`|
|  ~~strike through~~              | `+strike through+`|
|  <u>underlined</u>               | `_underlined_`|
|  `code`                         | `~code~`|
|  `verbatim`                    | `=verbatim=`|
|  <h1>Heading 1</h1>              | `* Heading 1`|
|  <h2>Heading 2</h2>              | `** Heading 2`|
|  [Link Text](http://gonsie.com)  | `C-c C-l` or `[[http://gonsie.com][Link Text]]`|

Also (as seen above), org supports spreadsheets (aka really smart
tables). This support includes extra whitespace so that the tables
always look aligned.

Org-mode does section folding with each heading. Hitting TAB will cycle
through the visibility of the children.

Org-mode also supports blocks, such as code blocks, quotes, examples,
and more:

{% highlight org %}
#+BEGIN_SRC rust
fn sample_code () -> u32 {
    10
}
#+END_SRC
{% endhighlight %}

Renders to:

{% highlight rust %}
fn sample_code () -> u32 {
    10
}
{% endhighlight %}

{% highlight org %}
#+BEGIN_QUOTE
Everybody lies
 -- Dr. House
#+END_QUOTE
{% endhighlight %}

Renders to:

> Everybody lies -- Dr. House

As you\'ll learn, the standard way to add markup/options/metadata within
an org document is the `#+SETTING` marker at the beginning of a line.
This is the way that org is able to support complex exporting to latex
documents.

Literate Programming
--------------------

Literate programming is the idea that a single document should include
the thought process used to create code as well as the code itself. This
works for R scripts, where the author is trying to tell a story about
the data while presenting and including the data itself.

### Export

Each org document can be exported, or converted, to a document in a
different language. Export options include LaTeX, Beamer, Markdown,
HTML, and more. The exporter pane is brought up with `C-c C-e`.

### Tangle

All the pieces come together with tangling. Tangling takes a piece of
code which is written your document and executes it. Then, it can even
embed result directly in the document itself.

Here are two examples of org-mode source code blocks.
To generate the RESULTS blocks, one would type `C-c C-c` within a source block.

#### Example 1: Shell Command

{% highlight org %}
#+BEGIN_SRC bash
hostname
#+END_SRC

#+RESULTS:
Eris.local
{% endhighlight %}
#### Example 2: Generate and Embed an Image

{% highlight org %}
#+BEGIN_SRC dot :file images/example_dot.png :cmdline -Kdot -Tpng
digraph g {
rankdir = LR;
a -> b;
}
#+END_SRC

#+RESULTS:
{% endhighlight %}
![]({{ site.baseurl }}/images/example_dot.png)

I\'ll just let that seep in. The possibilities are truly endless.

Agendas
-------

One great feature of org-mode is its ability to track to do items.
Getting this system setup and organized can be somewhat of a bear, so
I\'ll avoid getting overly detailed. Instead, I encourage you to start
with a bare bones setup and see what works for you. If you do decide
that org-mode agenda can fit into your daily workflow, I encourage you
to look around at what others have done.

First, you\'ll need to turn on the org-mode agenda functions with some
keybindings. The defaults are:

{% highlight elisp %}
;; org-mode agenda recommended keybindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)
{% endhighlight %}

Next, you\'ll need an easy way to keep track of any TODO item you
create. The easiest way I\'ve found is this on-save hook (from
[Frederick
Giasson](http://fgiasson.com/blog/index.php/2016/06/21/optimal-Emacs-settings-for-org-mode-for-literate-programming/)).
Through this hook, every org file is automatically \"filed\" and any to
do items inside will be found by the org-mode agenda builder.

{% highlight elisp %}
;; Add Org files to the agenda when we save them
(defun to-agenda-on-save-org-mode-file()
  (when (string= (message "%s" major-mode) "org-mode")
    (org-agenda-file-to-front)))

(add-hook 'after-save-hook 'to-agenda-on-save-org-mode-file)
{% endhighlight %}

This does mean that when files are deleted or moved the org agenda
complains.

Conclusion
==========

I\'ve been down the Emacs rabbit hole about 2 months now. It has been
fun and I\'m excited to continue to modify my setup and play with new
packages. You can find my setup [on GitHub](https://github.com/gonsie/dotfiles/blob/master/emacs/init.el).

In my brief exploration I\'ve found a number of extremely helpful
individuals:

-   [Sacha Chua](http://sachachua.com/blog/): Sacha is incredibly
    inspiring and a prolific contributor to the Emacs community. She
    writes a weekly roundup of Emacs and Org news.
-   [Frederick Giasson](http://fgiasson.com/blog/): He had the tip for
    automatically filing org files on save.
-   [Pragmatic Emacs](http://pragmaticemacs.com) This blog has a number
    of tips for using Emacs in academia and with LaTeX.
-   [Aaron Bieber](https://blog.aaronbieber.com) He had blog post on
    using GUI Emacs, which convinced me to try it.
