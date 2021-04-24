---
title: "Part 1: Using Org to Develop Elisp"
layout: post
tags: [emacs, elisp, org]
---

*This post is part of a series.*

-   (You are here) Part 1: Using Org to Develop E-lisp snippets
-   [Part 2: Counting Words]({{ site.baseurl }}{% post_url 2018-01-10-part2-counting-words %})

<hr />

- [Useful Commands](#org408d605)
- [The Power of Introspection](#orgf8927c2)
- [Starting with Org Blocks](#org6ddd2d2)

One of the powers of Org mode is the ability to run blocks of code and collect the output.
This allows you to capture code, context for writing the code (as actual text), and results in a single document.
This blog-post will describe how I've started to learn Emacs lisp using org and Emacs itself.


<a id="org408d605"></a>

## Useful Commands

In Emacs, there are many ways to trigger the same actions.
I find that memorizing chords is terribly difficult (if I have any memorized its through muscle memory rather than my brain knowing what I'm typing).
Here is a short table of commands I've needed to get at the documentation builtin to Emacs.
Usually I run these via `M-x FUNCTION`, which allows me to get at tab-completion if I don't remember the exact name.

| Chord               | Function                           | Out Come                                                                          |
|---------------------|------------------------------------|-----------------------------------------------------------------------------------|
| `C-h f FUNCTION` | `describe-function`            | show doc page for function                                                        |
| `C-k F FUNCTION` | `Info-goto-emacs-command-node`  | show manual page for function                                                 |
| `C-h k KEY`       | `describe-key`                  | show doc page for a chord                                                         |
| `C-h K KEY`       | `Info-goto-emacs-key-command-node` | show manual page for chord                                                |
| `C-h C-f`         | `view-emacs-FAQ`               | show GNU Emacs FAQ                                                                |
| `C-h i`            | `info`                           | Bring up info documentation browser to the last info page you were looking at     |
| `C-h i m elisp RET` |                               | Shortcut to ELisp documentation                                                   |
| `C-h i d`         |                                    | Top level info directory                                                          |
|---------------------|------------------------------------|-----------------------------------------------------------------------------------|
| `C-c C-c`         | `org-ctrl-c-ctrl-c`            | Great function name. Does a bunch of things, namely running the source code block |
| `C-c '`           | `org-edit-special`              | Edit block/table in a separate buffer popup                                       |

Helpful web pages:

-   [Orgmode Source Code Editing](https://orgmode.org/org.html#Editing-source-code)
-   [Org Easy Templates](https://orgmode.org/org.html#Easy-templates)
-   [Org Source Block Header Arguments](https://orgmode.org/org.html#Specific-header-arguments)
-   [GNU Manual on Lisp in Emacs](https://www.gnu.org/software/emacs/manual/html_node/eintr/index.html#Top) and the page on [save-excursion](https://www.gnu.org/software/emacs/manual/html_node/eintr/save_002dexcursion.html#save_002dexcursion)


<a id="orgf8927c2"></a>

## The Power of Introspection

I do not learn through text books.
Often, I find that they have all this extra narrative, when all I really want is the equation or detailed function documentation.
This does make it somewhat difficult for me to learn new programming languages as I'm not going to sit down a read a book.
This is where an IDE can really help.

> In psychology, the process of introspection relies exclusively on observation of one's mental state.
> Introspection is closely related to human self-reflection and is contrasted with external observation<sup><a id="fnr.1" class="footref" href="#fn.1">1</a></sup>.

In programming, introspection is the ability to look at the code itself, as a program is running.
Emacs allows this (in a sense) through the `describe-function` and `describe-key` functions.
Users can view both documentation and even the source code itself<sup><a id="fnr.2" class="footref" href="#fn.2">2</a></sup>.
Using the `describe-function` function, along with tab completion, you can guess at functions that may exists and start to build e-lisp snippets.

Built-in documentation isn't technically introspection, but it is nice.
To bring up the "Emacs Lisp" manual, type `C-h i m elisp RET`.

Despite my dislike of narrative, I now present a basic walk-through for getting started with Org mode code blocks.


<a id="org6ddd2d2"></a>

## Starting with Org Blocks

Now that we know how to bring up documentation without leaving Emacs, lets code!
I'm sure we could create a new elisp file / project, but who has time?
I would rather do my day job and learn a little new elisp when the opportunity arises.
This means I'm already working on something while writing in Org-mode.

### Basics: Running and Results

Org source blocks contain snippets of code that can be executed.
First, make sure executing e-lisp code through Org babel in enabled (usually in your `init.el` or `.emacs` file):

{% highlight elisp %}
(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)))
{% endhighlight %}

Let's start with a very basic Emacs lisp snippet.
Typing `<s TAB` will automatically create a source code block (this is called a template<sup><a id="fnr.3" class="footref" href="#fn.3">3</a></sup>).

{% highlight elisp %}
#+NAME: calc
#+BEGIN_SRC elisp
(- 10 2)
#+END_SRC
{% endhighlight %}

Placing the cursor within the block at hitting `C-c C-c` triggers the run (type `y` to allow the snippet to run on your computer).
The results appear in the document.

{% highlight elisp %}
#+RESULTS: calc
        : 8
{% endhighlight %}

### String Manipulations

Elisp isn't my go-to calculator, but it is a handy way to run simple calculations.
Let's get more complicated with some quick text parsing.
Here I create 2 lists of items, then print all the permutations through an Org block.

{% highlight elisp %}
#+NAME: letters
- A
- B
- C

#+NAME: numbers
- 1
- 2

#+NAME: str-permute
#+BEGIN_SRC elisp :var s1=letters s2=numbers :results output
(while s1
  (setq x (car s1))
  (setq s1 (cdr s1))
  (setq tmp s2)
  (while tmp
    (setq y (car tmp))
    (setq tmp (cdr tmp))
    (princ (car x))
    (princ (car y))
    (princ "\n")))
#+END_SRC

#+RESULTS: str-permute
: A1
: A2
: B1
: B2
: C1
: C2
{% endhighlight %}

A few notes about this example:

1.  To edit the e-lisp code in an "Emacs-Lisp" mode buffer, move the cursor in to the source block and type `C-c '`.
    This ensures proper indentation and other major mode niceness.
    Note that this can work for any major mode<sup><a id="fnr.4" class="footref" href="#fn.4">4</a></sup>, including text.
2.  Notice the `:results output` header argument on the code block<sup><a id="fnr.5" class="footref" href="#fn.5">5</a></sup>.
    There are a bunch of arguments, but the results one always messes me up.
    In this case, I want to print the output as the snippet executes, not the return value of the snippet.
3.  Do not forget to `cdr` your while loop variable.
    Should you forget, use `C-g` to kill the execution.
4.  Emacs print functions are weird and the documentation is obtuse&#x2026; I just use `princ`.
    Unfortunately there is no easy to `princ` many items in a single, variable argument command (and I don't want figure out how to build strings).


## Footnotes

<sup><a id="fn.1" href="#fnr.1">1</a></sup> [Introspection](https://en.wikipedia.org/wiki/Introspection). *Wikipedia, The Free Encyclopedia*. Accessed Jan. 4, 2018.

<sup><a id="fn.2" href="#fnr.2">2</a></sup> Okay, this isn't technically programmatic introspection, more like "built-in documentation."
On the other hand, Emacs is somewhat unique in how users can interact with the documentation and the underlying code.

<sup><a id="fn.3" href="#fnr.3">3</a></sup> Documentation for [Org Easy Templates](https://orgmode.org/org.html#Easy-templates)

<sup><a id="fn.4" href="#fnr.4">4</a></sup> Documentation for [Org source blocks](https://orgmode.org/org.html#Editing-source-code)

<sup><a id="fn.5" href="#fnr.5">5</a></sup> Documentation for [Org source block header arguments](https://orgmode.org/org.html#Specific-header-arguments)
