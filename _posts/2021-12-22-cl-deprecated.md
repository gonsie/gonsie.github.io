---
title: "Package cl is deprecated"
layout: post
categories:
tags:
- emacs
- cl
- packages
---

> Package cl is deprecated

I've been ignoring this startup message for maybe a year now (since the release of Emacs 27).
After recently updating all my packages (and completely breaking my emacs setup) I decided to go through all the startup messages and start fixing things.


## The Fix

Searching around the fix is straight forward.
Instead of requiring `cl` the correct name is now `cl-lib`.

{% highlight elisp %}
(require 'cl-lib)
{% endhighlight %}

I knew of one place where I had used `cl` (I used the `return-from` function to do an early exit from a `while` loop), but after making the change, I was still getting the startup message.
Unfortunately that meant the startup message was coming from one of the many packages I had installed, how would I ever find it?


## Finding `cl` requirements

Luckily, we have the [emacs stackexchange](https://emacs.stackexchange.com/questions/58489/how-do-i-debug-package-cl-is-deprecated), with this handy snippet:

{% highlight elisp %}
(require 'loadhist)
(file-dependents (feature-file 'cl))
{% endhighlight %}

Showing the one place with a `cl` requirement:

`Users/gonsie/.config/emacs/elisp/color-theme-6.6.0/color-theme.el`

Unfortunately this is in one of the packages I've been hand carrying around for over 10 years (longer than my dotfiles repo has existed).
It's finally time to update the implementation of my preferred color theme, but that is a post for another day.
