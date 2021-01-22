---
title: "Automatic Dark Mode for Your Website"
date: January 22, 2021
layout: post
categories: 
tags:
---

With HTML5 filters and media quieries, it's simple to enable an automatic dark mode on your website. Use the following CSS snippet:

```html
@media (prefers-color-scheme: dark) {
  html {
    filter: invert(1) hue-rotate(180deg);
  }
}
```

It's not perfect, but rather a quick and dirty way to stop blinding yourself when you're editing your website at 2 am.