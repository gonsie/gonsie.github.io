---
title: "RSS Feeds by Email"
date: February 16, 2021
layout: post
categories:
tags: blog
---

While RSS is great, it's not easy to explain to those who haven't heard of it before.
Plus, it's hard to get someone started on using RSS since it requires a separate application.
TwoBitHistory has an great post on the [history of RSS](https://twobithistory.org/2018/09/16/the-rise-and-demise-of-rss.html) that covers it's fall from grace.

Without RSS, keeping up-to-date on your favorite websites from the independent web becomes a bit more difficult.
Most sites now feature a newsletter and email is a great alternative to RSS.
Julia Evans [describes the MailChimp process](https://jvns.ca/blog/2017/12/28/making-a-weekly-newsletter/) to turn an RSS feed into a weekly digest.


I've decided to use something even simpler: the [RSSby.email](https://rssby.email) service.
RSSby.email provides a daily email with posts from this (or any) RSS feed.
It is entirely managed by the subscriber via email (see the website for details on how to subscribe and various preferences you can set).

To facilitate the subscription process, I added an HTML `mailto` link to create the subscribe email for this site:

```
<a href="mailto:add@rssby.email?subject=subscribe&body=https://www.gonsie.com/blorg/feed.xml"><img src="/images/rss-email.png" id="rss"></a>
```

RSSby.email will automatically unsubscribe any websites that are not updated within 90 days... which should inspire me to post with some frequency.
