---
layout: post
title: "Org and Jekyll: A Survey"
tags: [org, emacs]
---

<div id="table-of-contents">
<div id="text-table-of-contents">
<ul>
<li><a href="#sec-1">My Current Process</a></li>
<li><a href="#sec-2">Survey of Related Work</a></li>
<li><a href="#sec-3">Future Work</a></li>
<li><a href="#sec-4">Conclusions</a></li>
</ul>
</div>
</div>

I am getting more into Org mode and I've started to use it in my blogging process.
I host my blog on GitHub pages with Jekyll.
I would like to keep my posts in markdown and not push HTML direct to `_site`.
At first I thought I needed to build my own org exporter for Jekyll, but I've realized there a number of solutions (and blog posts about those solutions) already out there.

This post is a survey of existing approaches to blogging with Org and Jekyll.

## My Current Process<a id="sec-1" name="sec-1"></a>

![Blogging Process]({{ site.baseurl }}/images/blorg-process.png)

My current process includes several non-optimal "fix up" steps that I would like to eliminate.
Ideally, the Emacs publish transformation would spit-out the markdown exactly as I want it.
A bonus would be to take advantage of the Org publish workflow (rather than just an export of the document).
Then, I would be able to make any copy edits directly on the Org draft and the publish/deploy process could happen at the push of a button.

## Survey of Related Work<a id="sec-2" name="sec-2"></a>

Before codifying my workflow, I've surveyed the work of others.
I have found a number of blog posts that discuss each author's experience with and workflow for blogging with Org mode and Jekyll.

There are three categories of approaches:
1.  Support a Jekyll-centric workflow by developing a Jekyll plugin / converter.
2.  Support an Org and Emacs-centric workflow by building on the org-publish functionality.
    This approach transforms the Org content directly to HTML.
3.  Support the Org-publish workflow by transitioning away from Jekyll altogether (i.e., using a different platform).

### Jekyll-centric Approaches<a id="sec-2-1" name="sec-2-1"></a>

Jekyll-centric approaches often attempt to make Org syntax a first-class citizen in Jekyll.
However, none of these tools have been adapted by the Jekyll community and thus remain outside of Jekyll itself.
This means that org-based blogs are not able to take advantage of automatic publishing by GitHub Pages.

1.  [*An Org-Mode Jekyll Plugin* by Joel's Journal](https://joelmccracken.github.io/entries/org-mode-jekyll-plugin/)

    This post takes a *literate programming* approach to developing the Jekyll plugin for understanding org documents.
    This post is great review of what is happening under the hood (including details on the I/O streams, which can be complex).

2.  [*eggcaker/jekyll-org* on GitHub](https://github.com/eggcaker/jekyll-org)

    Yet another Jekyll plugin.
    Maybe I'm missing something as to why this approach is so attractive.

3.  [*tjaartvdwalt/jekyll-org-mode-converter* on GitHub](https://github.com/tjaartvdwalt/jekyll-org-mode-converter)

    The ReadMe in this project is the equivalent of blog post.
    It covers some other, existing projects and again uses the Jekyll converter/plugin approach.

### Org-publish Approaches<a id="sec-2-2" name="sec-2-2"></a>

There are many "hacks" that smash together Jekyll and Org.
Unfortunately, it seems that neither Jekyll nor Org are used in all their glory.
Each workflow contains a bunch of new elisp for getting everything to work.

1.  "Official" Guidance: [*Using org to Blog with Jekyll* on Worg](https://orgmode.org/worg/org-tutorials/org-jekyll.html)

    Worg provides some guidance for blogging with Org.
    This is the unofficial starting place for many Org bloggers and describes several Org-centric workflows.

2.  [*Using org-mode to blog with Jekyll* by Martin Foot](https://www.mfoot.com/blog/2015/11/17/using-org-mode-to-write-jekyll-blogs/)

    This post expands on the Worg guidance for generating HTML for Jekyll.
    It uses the HTML blocks to export the Jekyll front matter.
    It includes the elisp snippets to set up proper project publishing.
    As such, it's a great starting place for new bloggers.

3.  [*Using org-mode with Jekyll* by Levlaz](https://levlaz.org/using-org-mode-with-jekyll/)

    This post again starts from the Worg guidance (and a bad experience with Google Docs).
    He includes the elisp `org-publish` snippet which moves the draft out of `_org` and into `_posts`.

4.  [*Org-jekyll* by Juan Reyero](http://juanreyero.com/open/org-jekyll/)

    The first line of the posts mentions that author is no longer using this method.
    I really appreciate having this information up front!

    The post uses org-publish to export subtrees from a single org document as individual posts.

### Other Platform Approaches<a id="sec-2-3" name="sec-2-3"></a>

It is important to recognize that there are some other approaches.
Some users have transitioned away from Jekyll completely, while new platforms have appeared to enable to blogging.

1.  [*Blogging with Org mode* by Superloopy.io](https://www.superloopy.io/articles/2017/blogging-with-org-mode.html)

    **Approach**:
    -   Originally tried upstreaming a Jekyll plugin.
    -   Moved away from Jekyll altogether, now using org-publish

    Superloopy's post has a lot of great ideas and discussion of the task.

    First, I completely agree that setting up the Jekyll tech stack is a huge pain.
    That is somewhat mitigated by the fact that GitHub will automatically publish them with Jekyll for you.
    Also, it is disappointing that the gem/jekyll-plugin was ignored.

    The post also describes a way to lower the barriers to blogging through a capture template (which looks fantastic).
    The post also includes code for publishing direct from org and converting existing jekyll-markdown posts back to org.

2.  [*yoshinari-nomura/org-octopress* on GitHub](https://github.com/yoshinari-nomura/org-octopress)

    The org-octopress package contains exporters for octopress and jekyll.
    These exporters have a number of features I will want:
    -   support for automatically adding yaml frontmatter
    -   setting the layout in the frontmatter (with a default value)
    -   some filename and date functionality

    This package still exports to HTML, rather than the markdown that I want.
    But, if I can easily get it into my workflow, it might make sense to use this rather than developing a new tool.

## Future Work<a id="sec-3" name="sec-3"></a>

At the start of this survey I thought that an `ox-jekyll` solution would already exist.
On the contrary, I haven't found one that builds on top of markdown and native Jekyll parsing.

I will have to develop my own.
This exporter will have to fit neatly in existing workflows (if I want to make it useful to others).
I have a number of assumptions about the setup of projects and org files that I will have to be careful about or document clearly.

## Conclusions<a id="sec-4" name="sec-4"></a>

I've learned a lot from this review, including some useful takeaways for my own blogging purposes:

-   I should make sure my blog has a header.
    I've been working on this post offline and with the relevant web pages already open.
    If I were looking at a post on my own blog, I would have no context/meta-information on the page.
-   Starting the post with any update about its contents is such a courtesy to the reader.
    I must do this for my own posts.

One key take away: there are **a ton** of people using Emacs and Org to blog (and write and do work).
The influence of literate programming means that many of these people write blog posts about their workflow.
As a result of this project, I've added about 5 blogs to my RSS feed.
