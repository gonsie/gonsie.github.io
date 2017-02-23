---
layout: default
title: Notes
---

<!-- This is a special file -->
<!-- The "notes" collection is not parsed by jekyll -->

<ul>
{% for page in site.categories.notes %}
  <li><a href="{{ page.url }}">{{ page.title }}</a></li>
{% endfor %}
</ul>

<!-- collection contents -->

{% for x in site.collections %}
{% if x.label != "posts" %}

{% for cpage in site.[x.label] %}
{% capture y %}{{ cpage.url | split: "/" | last }}{% endcapture %}
{% if y == "index.html" %}
<h2><a href="{{ cpage.url }}">{{ cpage.title }}</a></h2>
<p><em>{{ cpage.content }}</em></p>
{% endif %}
{% endfor %}

<ul>
{% for cpage in site.[x.label] %}
{% capture y %}{{ cpage.url | split: "/" | last }}{% endcapture %}
{% unless y == "index.html" %}
  <li><a href="{{ cpage.url }}">{{ cpage.title }}</a></li>
{% endunless %}
{% endfor %}
</ul>

{% endif %}
{% endfor %}
