---
title: "Jekyll Portfolio"
layout: post
categories:
tags:
---
So I recently learned that the future of Jekyll is, well, [grim](https://www.bridgetownrb.com/future/rip-jekyll/).
I have quite the history with jekyll, I've been creating websites with it since 2012 (most especially this one).
To mark the end of my jekyll era, I've collected a portfolio of all the sites I've developed and contributed to.

A few of them feature some clever liquid to make updating/expanding easy for others.
Here I've collected my portfolio of sites, all of which are still live, thanks to github and the power of static sites.
Looking over this collection, I mainly see a lot of acronyms&#x2026;


## My Website

-   [gonsie.com](https://gonsie.com)
-   Converted to Jekyll site in 2012 (still in use)
-   [Accent](http://jekyllthemes.org/themes/accent/) theme by Ankit Sultana (blog)

![gonsie.com screenshot](/images/portfolio/portfolio-gonsie.png)

The only real blog in my portfolio, this site has a bunch of sections and cruft left around from past projects.
Recently, I've created some post templates which allow me to post easily quotations and photos.


## ROSS

-   [ross.cs.rpi.edu](https://ross-org.github.io)
-   Launched 2013 (still in use)
-   [Polar Bear Theme](http://jekyllthemes.org/themes/polar-bear-theme/) by Camille Diez

![ROSS webpage screenshot](/images/portfolio/portfolio-ross.png)

The ROSS (Rensselaer's Optimistic Simulation System) website hosts much of the user documentation for the simulator I worked on during graduate school.
This is/was one of my more successful sites.
My idea to build up documentation for ROSS (which was severely lacking) was to require a 'blog post' to the website for nearly every pull request.
Each blog post contains a jekyll tag, which places that entry in the proper section of the overall documentation table of contents.


## XPDES

-   [xpdes.org](https://xpdes.github.io)
-   2014
-   [Hyde](http://jekyllthemes.org/themes/hyde/) theme by Mark Otto

![XPDES webpage screenshot](/images/portfolio/portfolio-xpdes.png)

The Extreme Parallel Discrete-Event Simulation (PDES) was a consortium of PDES researchers from several institutions.
The site had some liquid to group 'people' pages by institution; the posts were for meeting agendas.
The consortium lasted until 2016.


## NYχ

-   [nychi.tech](https://nychi.github.io)
-   2016
-   [Long Haul](http://jekyllthemes.org/themes/long-haul/) theme by Brian Maier Jr.

![NYχ webpage screenshot](/images/portfolio/portfolio-nychi.png)

The New York Capitol Hackathon for Inclusivity was a hackathon I help organize in April 2016.
We needed a quick website.
This site includes some nice liquid for automatically generating the navigation menu from all pages that exist.

{% highlight markdown %}
  {% for p in site.pages %}
    {% if p.title != "Thank You" %}
      <li class="element">
        <a href="{{ p.url
- prepend: site.baseurl }}">{{ p.title }}</a>
      </li>
    {% endif %}
  {% endfor %}
{% endhighlight %}


## IHPCSS

-   [ihpcss.github.io](https://ihpcss.github.io)
-   2018
-   [Git-Wiki](http://jekyllthemes.org/themes/git-wiki-for-documentation/) theme (and functionality) by Yehonal

![IHPCSS wiki screenshot](/images/portfolio/portfolio-ihpcss.png)

This wiki theme is very cool with tons of functionality.
I created this site because there was a lot of information that I wanted to organize for students at the International HPC Summer School.
I hoped the wiki feature would allow other to add content, but the site was voted down and the content migrated to a different system.


## HUST

-   [hust-workshop.github.io](https://hust-workshop.github.io)
-   I joined 2019 (still in use)
-   [SinglePaged](http://jekyllthemes.org/themes/singlepaged/) Theme by Tim O'Brien

![HUST workshop webpage screenshot](/images/portfolio/portfolio-hust.png)

The HUST site was initially developed by [Chris Bording](https://github.com/chrisbuwahpc), but I started co-organizing the workshop (and running the website) in 2019.
This single-paged site uses post files to hold the content.
Any posts from the current year (as specified by the frontmatter in the index.md) are displayed.
This allows us to easily keep the content file from previous years, without them getting in the way.


## PSIP

-   [bssw-psip.github.io](https://bssw-psip.github.io)
-   2019
-   [Cayman Theme](http://jekyllthemes.org/themes/cayman-theme/) by Pietro Menna

![PSIP webpage screenshot](/images/portfolio/portfolio-psip.png)

This really simple site hosts a bunch of markdown documentation for the Productivity and Sustainability Improvement Planning software improvement process.
The coolest thing was an interactive [Rate Your Project Survey](https://bssw-psip.github.io/ptc-catalog/survey.html) which calculates a cumulative score for items checked off on the page (using javascript).


## Jekyll Resume

-   [gonsie.com/jekyll-resume/resume.html](https://www.gonsie.com/jekyll-resume/resume.html)
-   2019
-   A jekyll implementation of the [One Page Resume](https://css-tricks.com/one-page-resume-site/) by Chris Coyier

![C'thulu Resume screenshot](/images/portfolio/portfolio-resume.png)

I've used Chris Coyier's one page resume since 2012 (slightly before I started using jekyll).
In 2019 I created a template jekyll repository which I use to teach students about markdown and static websites.
The template renders a resume written in markdown to a nice one page resume website.
This site is a better demonstration of my markdown and css skills (rather than jekyll or liquid).
