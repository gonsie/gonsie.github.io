---
layout: page
title: "RSS Feeds"
---


## <a href="./feed.xml"><img src="/images/rss.png" id="nav-icon"/>RSS Feed</a>

RSS (Rich Site Summary or Really Simple Syndication) is a set of XML feed file formats of varying degrees of use for syndicating time-stamped content from web sites.[^1] RSS feeds allow users to access updates from a website in a standardized, computer-readable format.[^2] It is also the backing technology for podcast distribution.

Besides the <mark><a href="./feed.xml">standard RSS feed</a></mark> for my entire blog, you can also subscribe using email or by topic (details below).

## <a href="mailto:add@rssby.email?subject=subscribe&body=https://www.gonsie.com/blorg/feed.xml"><img src="/images/rss-email.png" id="nav-icon"/>RSS by Email</a>

As explained in a [blog post](/blorg/rss-by-email.html), readers can access my website through their inboxes with the [RSSby.email](https://rssby.email) service.
RSSby.email provides a daily email with posts from this (or any) RSS feed.
It is entirely managed by the subscriber via email (see the website for details on how to subscribe and various preferences you can set).

Any of the topics below can be subscribed to by sending an email:

    To: add@rssby.email
    Subject: subscribe
    Body: https://www.gonsie.com/blorg/feeds/TAG.xml

Where `TAG` is replaced with one of the tags below. For the full site feed you can [click this link](mailto:add@rssby.email?subject=subscribe&body=https://www.gonsie.com/blorg/feed.xml) or use `blorg/feed.xml`.

## Topical RSS Feeds

I generate an RSS feed for each topic or "tag" that I've used on my blog.

{% for tag in site.tags %}
  {% capture tagname %}{{ tag | first }}{% endcapture %}
  <a href="/blorg/feeds/{{ tagname }}.xml">
  <span class="post-tag">{{ tagname }}</span>
  <img src="/images/rss.png" style="width:30px;margin:-.7em 0;"/>
  </a>
{% endfor %}

## Footnotes

[^1]: https://indieweb.org/RSS
[^2]: https://en.wikipedia.org/wiki/RSS
