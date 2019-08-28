---
title: "Story: Beamer Slides at 30,000 Feet"
layout: post
tags: [ipad, story]
---

> I wrote this about six months ago.
> It was at the start of my journey towards replacing my laptop with an iPad as my only work device while on travel.
> Next month I'll have a more detailed post about some of the apps I've found and my current iPad setup.

For a long time the only barrier to using my iPad instead of a laptop on travel was one very specific use case: I wanted to be able to build TeX documents on an airplane (i.e., without an internet connection).
A friend of mine said "surely there must be a decent app" and immediately found [TexPad](https://www.texpad.com) for $20.
Ho hum, I didn’t really want to pay&#x2026; but my interest was piqued in the fact that it was a stand-alone app that could compile LaTeX and Beamer.

Then, one Monday I found myself in a bit of a predicament.
I was sitting at the airport with just my iPad heading off on a business trip where I would have to give a short presentation.
My slides (in Beamer) were over due and I had planned to SSH into a "real" computer to work on them.
Unfortunately, I found that my desktop machine, sitting back in my office, was turned off.

So, being down to the wire (with only an hour or so before I boarded and lost internet), I made the leap and purchased TexPad.
My existing slides and Beamer template were sitting in web-accessible git repos and were easily pasted into the app.
I tried to compile and realized that I still needed to download core Tex packages.
I spent the next 40 minutes anxiously watching the download bar as it fetched the prerequisite packages (or bundles as TexPad calls them), boarded my flight, and entered airplane mode.

My first impressions was good.
The TexPad app has a decent editor, with built-in fonts and color theme options.
The compiling time was quick enough (at least for 20 slides or so) and seemed to rival that of my desktop iMac.
Adding my Beamer style to the project worked as expected, though it did try to compile a pdf from the style file.

The only hiccups I had were around image importing.
I created a folder and tried to "add" images within it.
They didn’t appear.
No where in the file browser could the image files be seen, yet when I tried to import again the app claimed that "a file with that name already exists."
Finally, I found a different button for adding a image to the project (rather than just importing the file to TexPad).
Here the options of the images I had already tried to import appeared.
And then, my slide deck built completely.
At 30,000 feet, it was glorious.

TexPad is easy to use, mostly it *just works*.
I have always considered the TeX ecosystem to be strongly tied to Unix, a proper filesystem, and thousands of hours of effort from a vast community of folks.
I truly had never considered a commercial iPad app to be able to rival all of that.
But it does, and wonderfully so.

Despite such a positive experience, I am still hesitant to achieve my entire workflow on the iPad.
My next hurdle is Emacs.
This experience only reminds me of how powerful emacs and org-mode truly are.
Editing raw Beamer by hand is such a pain when compared with the simple elegance of org structured documents.
That said, I’m not without hope.
