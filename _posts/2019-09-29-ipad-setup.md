---
title: "My iPad Setup"
date: August 29, 2019
layout: post
categories: ipad
tags:
---

For almost a year now, my iPad has been my main computing device while traveling (the only other device being my phone).
Making the switch has been relatively easy, once I decided to buy any (and every) app I thought would make my life easier.
Any downsides I've come across have been more than compensated by not having to carry around 5 extra pounds of laptop.
In this post I'll detail some challenges and highlight the best apps that I've found.

<a id="org0160e31"></a>

## My Recommendations

![img](/images/ipad-best-apps.jpeg)

Before I get too into the weeds, here is the bottom line up front.
These are my must-have apps.
The prices may be higher than most apps, but I guarantee that they are worth every dollar.

| Name | Price | Description |
|---|---|---|
| [Texpad](https://www.texpad.com) | $19.99 | TeX and LaTeX editing and compiling |
| [GoodNotes 5](https://www.goodnotes.com) | $7.99 | Digital notebook, for the Apple pencil |
| [Working Copy](https://workingcopy.app) | Pro $15.99 | Git & GitHub |
| [Blink Shell](http://www.blink.sh) | $19.99 | SSH terminal |
| [Prompt](https://www.panic.com/prompt/) by [Panic](https://panic.com) | $19.99 | SSH terminal |
| [iA Writer](https://ia.net) | $8.99 | Plain text writing app |
| [PCalc](https://www.pcalc.com) | $9.99 | Calculator with *all* the bells and whistles |
| [Terminology](http://agiletortoise.com/terminology/) | $1.99 | Dictionary & Thesaurus |


<a id="org02cb3ea"></a>

## Hardware Setup

Of course, it all starts with an iPad.
I have a 9.7-inch iPad Pro (generation 1), with 32 GB of space.
It’s small and light.
The small screen means that it’s not great for multitasking / split-screen, but it's usable when I need it.
I also have the Apple keyboard cover (approximately 1 pound).
I also have an Apple Pencil, but I don't usually carry that with me.
I would consider the next generation iPad just for the Pencil magnets.


<a id="org93d1798"></a>

### Some thoughts on the Apple Pencil

I often take handwritten notes, but digital notes just aren't quite the same.
That said, I did give it a shot and found [GoodNotes](https://www.goodnotes.com) to be an absolutely stunning app.
It allows you to create different notebooks and comes equipped with great page templates.
As a bonus, users of GoodNotes 4 (which I purchased back in 2016 when I first got my iPad) were given a free or subsidized upgrade to GoodNotes 5 when it was released earlier this year.

Some other fun apps, just to use the pencil:

-   [Amaziograph](https://amaziograph.com)
-   [iOrnament](http://science-to-touch.com/en/iOrnament.html)
-   [Paper](https://paper.bywetransfer.com)


<a id="orgbc54452"></a>

## The Holy Grail

I already told [my story](https://www.gonsie.com/blorg/texpad-story.html) of compiling slides at 30,000 feet and I cannot recommend [Texpad](https://www.texpad.com) enough.
If you need to do any TeX at all, get Texpad, **it works**.
The TeX/LaTeX suite is such a beast, with tons of packages, and archaic flags.
I’m a CLI person, but I still use MacTex's provided TexShop GUI app to actually compile my tex files.
What even is the comiple command, `pdflatex --some --flag`?
I don’t actually know the magical incantation.
But Texpad knows. And Texpad works.


<a id="orgee40c94"></a>

## Coding

The technical aspects of my day job are coding.
Heck, with Emacs and Org-mode, even writing, text editing, building a poster, making slides, etc. is coding.
Coding on an iPad can happen in two ways:

1.  SSH into a remote machine (say, a desktop sitting back in your office)
2.  Download source to the iPad and edit it directly.

My preferred method is (1) SSH-ing back to my office desktop machine.
This means that any work I do is waiting for me when I return from my trip, plus I have access to emacs, compilers, Unix, the office intranet&#x2026;
There are two very good apps for this: [Panic’s Prompt](https://www.panic.com/prompt/) and [Blink](http://www.blink.sh).
While I love and support the folks over at Panic, my go to is Blink.
Blink allows key remapping, meaning caps-lock is control and \` is Esc.
Thank goodness because typing on a plane is RSI-inducing enough.
Blink also supports MOSH, which I haven’t yet tried.

Sometimes, I don’t want to SSH anywhere, or I want to do some git work without internet access.
For that there is [Working Copy](https://workingcopy.app) (unlock all the features with an in-app-purchase).
This app is a dream.
It has fully functioning support for git, with built in code editing and diff viewing (including an image diff viewer).
The built-in text editor is great and did I mention it does all of git!?
Pushing to GitHub does require some set up: you have to request permission for the app from any organizations that you want to push to.


<a id="org865e32c"></a>

## Plain Text Editing

It's taken me a long time to figure out a good text editing app, one that works great for plain text, not necessarily code.
Of course, org-mode has spoiled me.
I really want plain text&#x2026; but with some syntax highlighting.
I'd also really like the readline shortcuts to work (C-a, C-e, C-f, C-b, etc.).
And a dark mode with fixed width fonts (Inconsolata or Fira Code please).
With these "simple" requirements, it's taken me quite a while to find a text editing app that I like.

The best plain app I've found is [iA Writer](https://ia.net).
I've heard good things about this app for a long time, but with emacs on my Mac I've never had a good reason to invest.
These folks really understand *plain* text.
Doesn't get in the way or force markdown on me, smooth to use, and files are stored as .txt (or even .org) which are easily accessed by the File browser.


<a id="orge677f85"></a>

## Missing Essentials

There are two basics that are completely missing on the iPad: a calculator and a stand-alone dictionary/thesaurus app.

For a calculator I use PCalc, based on [recommendation from Daring Fireball](https://daringfireball.net/linked/2008/07/10/pcalc).
PCalc is great and has every feature you'd ever need: unit conversions, paper tape, hexadecimal/octal/binary conversions, color themes, and more.
Plus, it gives you a chance to practice your [reverse Polish notation](https://en.wikipedia.org/wiki/Reverse_Polish_notation).

I frequently use the built-in MacOS dictionary when writing, mostly for the thesaurus.
On the iPad, I've found [Terminology](http://agiletortoise.com/terminology/).
It has great support for keyboard shortcuts, works offline, and provides tons of related words (from the Princeton [WordNet lexical database](https://wordnet.princeton.edu)).


<a id="org2dbaff2"></a>

## The Rest

![img](/images/ipad-suite-apps.jpeg)

If your are gearing up to use your iPad as a main computing device, there are a bunch of apps you should have *just in case*.
Mostly, they are the typical suites of office software and video conferencing platforms.
Personally, I wouldn't choose to use any of these, but no one asks me.
That said, when I have had to use these office-suite apps, I have been surprised at how seamlessly they work.
It is completely possible to edit a budget spreadsheet (full of advanced macros) while waiting for your flight.
