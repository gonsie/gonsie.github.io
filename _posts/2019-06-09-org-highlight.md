---
title: "Highlighting in Org-Mode"
layout: post
categories:
tags:
---
I use org-mode to take a lot of notes and I frequently want to highlight some terms that I'm defining or a key sentence.
Overall, I want two things:

1.  I would like to add some markup syntax which will highlight a word or phrase, using ':' to mark the start and end of the phrase (similar to bold or italic markup).
2.  When I export this markup through HTML (or markdown) it the markup should get converted to the HTML5 `<mark>` tag.


## Extending Org Syntax

Extending the org syntax isn't the most straightforward.
At first, I tried to modify the `org-emphasis-alist` variable, but that didn't seem to work.
Instead, I was able to extend `org-font-lock` with an extra regex.

{% highlight elisp %}
(defun org-add-my-extra-markup ()
  "Add highlight emphasis."
  (add-to-list 'org-font-lock-extra-keywords
               '("[^\\w]\\(:\\[^\n\r\t]+:\\)[^\\w]"
                 (1 '(face highlight invisible nil)))))

(add-hook 'org-font-lock-set-keywords-hook #'org-add-my-extra-markup)
{% endhighlight %}

The elisp regular expression isn't the easiest to understand, but this is what it matches:

| Regex | Explanation |
|---|---|
| `[^\\w]` | something that's not a word |
| `\\(` | start of a capture group (not matching) |
| `:` | a colon |
| `[^\n\r\t]+` | a string of 1 or more characters that doesn't contain new-lines or tabs |
| `:` | a colon |
| `\\)` | end of the capture group (not matching) |
| `[^\\w]` | something that's not a word |

The start-and-end matching of something that's not a word means that colons in the middle of a URL are not matched and that the highlighted text can be followed by punctuation.
The parenthesis create a capture group, which is used later to define what has the highlight face.
Here is a diagram to try and explain the different pieces:

    '("[^\\w]\\(:\\[^\n\r\t]+:\\)[^\\w]" (1 '(face highlight invisible nil)))
      |      '--capture group---'      |  |  '--face definition-----------'
      '--regular expression to match---'  '--capture group number


## Exporting HTML

The next step is to extend the org-exporter.
This is easily done and a working example is even provided by [export engine manual](https://orgmode.org/manual/Advanced-Export-Configuration.html#Advanced-Export-Configuration).
I simply create a filter for any backend built on top of html (which should include my markdown and jekyll-md exporters).

{% highlight elisp %}
(defun my-html-mark-tag (text backend info)
  "Transcode :blah: into <mark>blah</mark> in body text."
  (when (org-export-derived-backend-p backend 'html)
    (let ((text (replace-regexp-in-string "[^\\w]\\(:\\)[^\n\t\r]+\\(:\\)[^\\w]" "<mark>"  text nil nil 1 nil)))
      (replace-regexp-in-string "[^\\w]\\(<mark>\\)[^\n\t\r]+\\(:\\)[^\\w]" "</mark>" text nil nil 2 nil))))

(add-to-list 'org-export-filter-plain-text-fucntions 'my-html-mark-tag)
{% endhighlight %}

I add this to my `org-config.el` file and success!


## Alternatives

Of course, org-mode already ships with some built-in highlighting functionality; namely, the syntax for defining a description list (which is a native HTML concept).
The following org formatting can be used to create a description list:

{% highlight org %}
- Emacs :: an extensible ,customizable, free/libre text editor
- Org mode :: keeping notes, maintaining TODO lists, planning projects, and authoring documents with a fast and effective plain-text system
{% endhighlight %}

Which becomes the following HTML:

{% highlight html %}
<dl>
<dt>Emacs</dt><dd>an extensible ,customizable, free/libre text editor</dd>
<dt>Org mode</dt><dd>keeping notes, maintaining TODO lists, planning projects, and authoring documents with a fast and effective plain-text system</dd>
</dl>
{% endhighlight %}

While this is a common use-case for highlighting, I don't always want my highlights to be in a list.


## Final Example

Here is a very brief example of a <mark>highlighted phrase</mark> which was exported properly.
I can also use this method to highlight a longer sentence, such as:
<mark>Should I implement this highlighting syntax and export functionality into Orgmode itself?</mark>
