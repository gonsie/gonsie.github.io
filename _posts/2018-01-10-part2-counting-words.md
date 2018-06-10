---
title: "Part 2: Counting Words"
layout: post
---

*This post is part of a series.*

-   [Part 1: Using Org to Develop E-lisp Snippets]({{ site.baseurl }}{% post_url 2018-01-10-part1-org-for-dev-elisp %})
-   (You are here) Part 2: Counting Words

<hr />

- [Exploring Existing Functionality](#org71ee782)
- [Marking and Counting](#org02a74e3)
- [Jaunting](#org6527a27)
- [Count All the Things!](#org98fd9b5)


I often use an separate (Org) file to develop written content, especially when I am filling out an application that has essay questions.
The answers often have a word-count or character-count limit.
Let's use Emacs and Org to count words!

<a id="org71ee782"></a>

## Exploring Existing Functionality

First, I use builtin documentation (and tab completion) to compile some useful functions.
Actually, I flailed a lot and bugged my friend who knows a bunch about Emacs and Org.

The `count-words` function is obviously a good place to start.
The documentation indicates that functions works on either a region or buffer and that it acts differently if called from lisp (rather than interactively).
I don't know anything about regions, but the Emacs Lisp documentation for "The Region" mentions two more useful functions: `region-beginning` and `region-end`.

Looking through all the Org functions, two stick out: `org-mark-subtree` and `org-babel-mark-block`.
These functions create a region on a specified chunk of Org content.

Finally, I'll need to go to the Org location to mark the region.
There are a few functions that look good for that: `org-goto` (though that seems to be very interactive) and `org-id-goto`.
Also, I come across `org-babel-goto-named-src-block`.
I already know how to name a source block.
For the other go-tos, making an Org ID is easy enough: `org-id-get-create`.
(Note, although `org-id-new` looks promising, I eventually learn that it doesn't do what I want).


<a id="org02a74e3"></a>

## Marking and Counting

I need to create an Org section for each answer that I want to word count.
I can either use a header/node/subtree or a source block (of text).
In the first case, I'll add a unique ID to the header (by invoking the `org-id-get-create`) so I can use the `org-id-goto`.
In the source block case, I can simply give it a name.

{% highlight elisp %}
** Describe Blah (100 words)
:PROPERTIES:
:ID:       460D55A4-7C61-485C-8778-075406BAE8A4
:END:

My answer is that blah.
{% endhighlight %}

{% highlight elisp %}
#+NAME: question1
#+BEGIN_SRC text
Blah blah blah.
#+END_SRC
{% endhighlight %}

The snippet for counting words in a subtree looks something like:

{% highlight elisp %}
#+NAME: subtree-method
#+BEGIN_SRC elisp
(org-id-goto "460D55A4-7C61-485C-8778-075406BAE8A4")
(org-mark-subtree)
(count-words (region-beginning) (region-end))
;; note that this snippet does not work
#+END_SRC
{% endhighlight %}

Unfortunately, the first snippet doesn't work.
Instead, it shows the error "Wrong type argument: markerp nil".

Let's try the source block way:

{% highlight elisp %}
#+NAME: src-block-method
#+BEGIN_SRC elisp
(org-babel-goto-named-src-block "question1")
(org-babel-mark-block)
(count-words (region-beginning) (region-end))
#+END_SRC
{% endhighlight %}

Huzzah! This one works.
Strangely, the result appears below the question block, not where I would expect it (below the code snippet).


<a id="org6527a27"></a>

## Jaunting

My friend (who actually reads books) shows me an awesome Emacs lisp function<sup><a id="fnr.6" class="footref" href="#fn.6">6</a></sup>:

> `save-excursion`: Save point, and current buffer; execute BODY; restore those things.

Turns out, this function is all over a bunch of e-lisp code.
Let's try it!
First, the subtree version of counting words:

{% highlight elisp %}
#+NAME: subtree-method
#+BEGIN_SRC elisp
(save-excursion
  (org-id-goto "460D55A4-7C61-485C-8778-075406BAE8A4")
  (org-mark-subtree)
  (count-words (region-beginning) (region-end)))
#+END_SRC
{% endhighlight %}

Low and behold! It suddenly works.
Plus, the results appear below the current code block.
Using `save-excursion` also fixes the source block method, making the results block appear near it.

One remaining issue with the subtree method is that it counts the Org properties drawer in the word count.


<a id="org98fd9b5"></a>

## Count All the Things!

Finally, our word counting snippet should work on a bunch of subtrees or blocks.
Let's pass some input to the snippets.
Also, we should pretty print the results.
Finally, I've included the code to count the characters as well.
The source block method ends up looking like:

{% highlight elisp %}
#+NAME: questions
- question1
- question2
- question3

#+BEGIN_SRC elisp :var blks=questions  :results output
(save-excursion
  (while blks
    (setq b (car (car blks)))
    (setq blks (cdr blks))
    (org-babel-goto-named-src-block b)
    (org-babel-mark-block)
    (princ b)
    (princ "\t")
    (princ (count-words (region-beginning) (region-end)))
    (princ " words\t")
    (princ (- (region-end) (region-beginning)))
    (princ " chars\n")))
#+END_SRC

#+RESULTS:
: question1	3 words	16 chars
: question2	3 words	16 chars
: question3	3 words	16 chars
{% endhighlight %}

The same can be done for the subtree method, but with IDs as the input.

## Footnotes

<sup><a id="fn.6" href="#fnr.6">6</a></sup> Documentation for [Emacs Lisp save-excursion](https://www.gnu.org/software/emacs/manual/html_node/eintr/save_002dexcursion.html#save_002dexcursion)
