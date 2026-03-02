---
title: "Emacs Carnival: Org Mode Completions"
layout: post
categories:
tags:
- emacs
- orgmode
---
I'm so happy to be joining [this month's emacs carnival](https://sachachua.com/blog/2026/01/emacs-carnival-february-2026-completion/)!
I love the idea behind these carnivals and I think it's such a good way of building community virtually.

This month's topic is Emacs completions.
I'm going to share a sort of "hack"&#x2026; a way that I've been able to achieve completions within core org mode.


## Org Mode Tempo Templates

Org Mode has long supported a template expansion mechanism, some times called "easy templates" or "structured templates".
The default behavior changed dramatically in [version 9.2](https://orgmode.org/worg/org-release-notes.html#orgf815049), and is now built on top of the Emacs builtin `tempo.el`.

*Update* To get the behavior described here, you must add `(require 'org-tempo)` to your config.

Essentially, you start a new line with `<X` (where `X` is a pre-defined key), then hit `TAB` to have the template expanded.
For example, starting a new line with:

{% highlight org %}
<s
{% endhighlight %}

and hitting `TAB` will expand to:

{% highlight nil %}
#+begin_src

#+end_src
{% endhighlight %}

Super handy and very easy to remember.


### Default templates

The default are not entirely documented, though most are listed on the [Structured Templates manual page](https://orgmode.org/manual/Structure-Templates.html).

Listed again here for convenience:

| Key | Expansion |
|---|---|
| <a | `#+BEGIN_EXPORT ascii … #+END_EXPORT` |
| <c | `#+BEGIN_CENTER … #+END_CENTER` |
| <C | `#+BEGIN_COMMENT … #+END_COMMENT` |
| <e | `#+BEGIN_EXAMPLE … #+END_EXAMPLE` |
| <E | `#+BEGIN_EXPORT … #+END_EXPORT` |
| <h | `#+BEGIN_EXPORT html … #+END_EXPORT` |
| <l | `#+BEGIN_EXPORT latex … #+END_EXPORT` |
| <q | `#+BEGIN_QUOTE … #+END_QUOTE` |
| <s | `#+BEGIN_SRC … #+END_SRC` |
| <v | `#+BEGIN_VERSE … #+END_VERSE` |

In addition to those blocks, there are also some quick tags:

| Key | Expansion |
|---|---|
| <L | `#+latex:` |
| <H | `#+html:` |
| <A | `#+ascii:` |
| <i | `#+index:` |
| <I | `#+include:` (will interactively find file to include) |

You can see that there is sort of a convention, uppercase letters usually insert a tag, whereas lowercase letters are mainly for blocks (though it's definitely not perfect).


### Additional Templates

Some additional templates can be defined by packages.
For example, the [org-re-reveal](https://gitlab.com/oer/org-re-reveal) package adds:

| Key | Expansion |
|---|---|
| <n | `#+begin_notes ... #+end_notes` |


## Basic Customization

You can add your own tags and blocks.
In fact, there is actually no need for the "keys" to single characters.


### Adding Tags

Adding another tag is very easy, seen here:

{% highlight elisp %}
(add-to-list 'org-tempo-keywords-alist '("N" . "name"))
{% endhighlight %}

Which results in this completion:

| Key | Expansion |
|---|---|
| <N | `#+name:` |


### Create a New Hotkey

I don't like the `<E` hotkey for export block, instead I would like that to be `<x`.
That is easily added with:

{% highlight elisp %}
(add-to-list 'org-tempo-tags '("<x" . tempo-template-org-export))
{% endhighlight %}


### Create a Completion

You can define your own completion with the `tempo-define-template` function (see the doc string for full details).
It is very flexible!
You can specify where the cursor (or "prompt") ends up after the completion, or you can interactively prompt (via the minibuffer) for additional details.
There are more advance features, including auto indentation and dealing with regions.


## My Custom Completions

There is no requirement that these templates be simply blocks or tags.
I've implemented about 5 custom templates, but here are a few that I think would be most useful for others.


### Properties Drawer<sup><a id="fnr.1" class="footref" href="#fn.1" role="doc-backlink">1</a></sup>

Org headings can have properties, specified by the [properties drawer](https://orgmode.org/manual/Property-Syntax.html):

{% highlight org %}
:PROPERTIES:

:END:
{% endhighlight %}

I add this as `<p` via this implementation code:

{% highlight elisp %}
(tempo-define-template "org-properties-block"
                       '(":PROPERTIES:" n
                         (p) n
                         ":END:" n %))
(add-to-list 'org-tempo-tags '("<p" . tempo-template-org-properties-block))
{% endhighlight %}


### Title Block

This is one that I use most frequently.
It's a title block that I start all my org documents with.
It also executes a function call to `format-time-string` to get today's date in my preferred format.
By having this completion, all of my org documents get a title with a date and I always know when I started working on a document!

My desired result:

{% highlight org %}
#+title:
#+author: Elsa Gonsiorowski
#+date: February 28, 2026
{% endhighlight %}

The implementation code:

{% highlight elisp %}
(tempo-define-template "org-title-block"
                       '("#+title: " (p) n
                         "#+author: Elsa Gonsiorowski" n
                         (concat "#+date: " (format-time-string "%B %e, %Y")) n %))
(add-to-list 'org-tempo-tags '("<t" . tempo-template-org-title-block))
{% endhighlight %}

I also implement another completion that is a slightly different title block which I use for starting all my blog posts.
It includes the all the options that I want by default.


## Finally

In writing this article I stumbled across orgmode documentation page for [Completions](https://orgmode.org/manual/Completion.html).
I had no idea these `M-tab` completions existed!
(Clearly, since I implemented my own completion for the properties drawer).
I'll definitely be trying these out.

# Footnotes

<sup><a id="fn.1" href="#fnr.1">1</a></sup> The `:properties:` keyword can also be added with the `M-tab` completion on `:`
