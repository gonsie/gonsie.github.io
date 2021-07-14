---
title: "WIP: Comments"
date: July 14, 2021
layout: post
categories: social, blog, wip
tags:
---

*WIP stands for work in progress.*

If you've visited my site in the last month or so, you may have noticed a (poorly-stylized) comment box at the bottom of each of my blog posts.
I'm working on setting a static-site friendly comment system. The goal is having all the comment data live within the blog repository (i.e., not using a third-party hosted service such as Disqus).

The general idea for the system is:
1. Readers fill out a comment form that is processed through a third-party, which essentially forwards the text to my email.
   *Status:* complete, using [formsubmit.co](https://formsubmit.co).
2. I receive the comments in my email and add those comments to my blog repo.
   *Status:* workflow not finalized.
3. Comments appear on the relevant post.
   *Status:* not started, requires html/css design plus Jekyll infrastructure/Liquid to make the right ones appear.

Right now, I am able to accept comments.
I've even received a few useful ones (some helpful folks pointed out that my site was broken in dark mode on some browsers).
I am thinking about letting commenters include their GitHub username, that way comments could appear as commits to my blog repository and folks could have their identity linked... but I haven't worked out all the detail yet.

Anyways, feel free to leave comments, I do get them and read them all! The comments just won't appear on the site itself, yet.
