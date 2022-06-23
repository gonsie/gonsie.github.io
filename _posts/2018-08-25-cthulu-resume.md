---
title: "A One-Webpage, Printable Resume"
layout: post
categories:
tags:
- css
- html
- git
---

I've had my resume as single, printable webpage for over 5 years ([initial git commit](https://github.com/gonsie/gonsie.github.io/commit/c3b13b29035b6692d324b36d9e42ebf0db780361) in 2012).
Since all of the styling and content is self contained, it is very easy to used.

I've made a template of the resume available [on GitHub](https://github.com/gonsie/Cthulu-Resume).
It is based on [this one page CSS tricks resume](https://css-tricks.com/one-page-resume-site/) which was originally developed by [Chris Coyier](http://github.com/chriscoyier).


## Why HTML and CSS

I'm a firm believer in the separation of style and content.
Here, resume content is separated from the style that is applied (as with all well-structured HTML and CSS pages).
While I do think that GUI tools are more useful for viusal design, CSS does allow the expression of visual design through programatic means.
Unlike LaTeX, which hides much of the fine-grained layout control, CSS is a fully featured layout controller.
Even better, it understands the difference of the media by which the content is presented, allowing this resume template to take advantage of non-printing items.

One basic improvement for this project would be to refactor the CSS and abstract some concepts.
This would make it easier to change the fonts and overall proportions (rather than messing with strict pixel values).


## Usefullness in Teaching Git

I use the template as an easy way to teach git to students.
After a basic introduction to git concepts and command, I have the students fork the template repo and create resumes of their own.
Each student can add as litte or as much information, and they can play around with the HTML formatting.
Indeed, this has the added bonus of getting them on GitHub and using GitHub pages.
