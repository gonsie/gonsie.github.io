---
title: "Emacs Delete vs. Kill"
layout: post
categories:
tags:
- emacs
---
One thing that has always vexed me is the Emacs kill ring.
It's great that it makes a list of things you've killed, but often I just want delete things quickly without saving it.
So I need to change the default settings to enable both killing and deleting words and lines.

Basic nomenclature (for this blog post at least);

-   kill means removing text and putting it in the kill ring
-   delete means removing text and not putting it in the kill ring


## Understanding Key Bindings

The default behavior of Emacs can depend on the underlying operating system.
This is because key presses are first translated by the OS, then passed (if they don't trigger an OS function) to the application, e.g., Emacs.
This can be further complicated by the keyboard setup and, further still, by an Emacs instance running inside of a Terminal.

To figure out the name that Emacs itself has for each key, use `C-h k KEY` or `M-x describe-key KEY`.
This internal name will come in handy when rebinding these keys.

For extended keyboards, there are often two "delete" keys, one which performs a backspace and one which does a forward delete.
The forward delete is often found on the "keypad" or number pad and is thus called `kp-delete` by Emacs.


### Mac Keyboards

Mac keyboards have the following modifier keys: Shift, Control, Option (Alt), and Command.
While Shift and Control are already mapped for Emacs (known as `S` and `C` respectively), the Option and Command keys are not mapped.
I use Option/Alt as a meta (`M`) key and Command as a super (`s`) key.

{% highlight elisp %}
(setq mac-command-modifier 'super) ;; command -> s
(setq mac-option-modifier 'meta)   ;; option/alt -> M
{% endhighlight %}


## Default Commands

By default, the `delete` key removes a single letter (backwards).
In Emacs keybindings, this is sometimes denoted as `backspace` (in addition to sometimes being called `delete`).
`M-delete` (`ALT-delete` on a Mac keyboard) will remove a whole word, but place it in the kill ring.
Killing a line is simple: `C-k`, but this kills a line forwards.

Putting the most recently killed word or line back is `C-y`, called yanking.
Yanking previous items in the ring is achieved with `M-y`, which will cycle through the ring.


## Combinations

There is a 3 dimensional problem to solve here, with 16 possible combinations (14 unique operations):

1.  Removal direction (backwards or forwards)
2.  Removal type (kill or delete)
3.  Removal size (character, word, visual line, whole line)


### Direction

I use the Mac internal for marking the direction as backwards or forwards.
Even on laptop keyboards, I can use `Fn-delete` to get the forwards deletion.

The whole line removal does not have a direction, but must be bound to both `delete` and `kp-delete`.


### Removal Type

The un-modified delete key-press should trigger a character delete.
Using the meta (`M`) modifier triggers a word removal.
Using the control (`C`) modifier triggers a line removal.


### Saving Items to the Kill Ring

I use the Shift (`S`) modifier to explicitly trigger adding the removed text to the kill ring.


## Binding the Keys

The following table tracks all the combinations which must be implemented.
The implementation looks like:

{% highlight elisp %}
(global-set-key (kbd "<<keybinding>>") '<<function>>)
{% endhighlight %}

| Direction | Type   | Save  | Key Binding                             | Function                 |
|-----------|--------|-------|-----------------------------------------|--------------------------|
| Backwards | Char   | No    | `<delete>`                              | None needed              |
|           | <del>Char</del> | <del>Yes</del> |                                         | Not implemented          |
|           | Word   | No    | `<M-delete>`                            | `backward-delete-word` * |
|           | Word   | Yes   | `<M-S-backspace>`                       | `backward-kill-word`     |
|           | Line   | No    | `<C-backspace>`                         | `backward-delete-line` * |
|           | Line   | Yes   | `<C-S-backspace>`                       | `backward-kill-line` *   |
| Forwards  | Char   | No    | `<kp-delete>`                           | `delete-forward-char`    |
|           | <del>Char</del> | <del>Yes</del> |                                         | Not implemented          |
|           | Word   | No    | `<M-kp-delete>`                         | `delete-word` *          |
|           | Word   | Yes   | `<M-S-kp-delete>`                       | `kill-word`              |
|           | Line   | No    | `<C-kp-delete>`                         | `delete-line` *          |
|           | Line   | Yes   | `<C-S-kp-delete>`                       | `kill-line`              |
| Both      | Line   | No    | `<s-backspace>` and `<s-kp-delete>`     | `delete-current-line` *  |
| Both      | Line   | Yes   | `<s-S-backspace>` and `<s-S-kp-delete>` | `kill-whole-line`        |

The functions marked with a * must be implemented.

{% highlight elisp %}
;; from https://stackoverflow.com/a/12990359/1160876
(defun backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (backward-word arg) (point))))

(defun delete-word (arg)
  "Delete characters forwards until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-line (arg)
  "Delete (not kill) the current line, backwards from cursor.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (beginning-of-visual-line arg) (point))))

(defun delete-line (arg)
  "Delete (not kill) the current line, forwards from cursor.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (end-of-visual-line arg) (point))))

(defun backward-kill-line (arg)
  "Kill the current line, backwards from cursor.
With argument ARG, do this that many times."
  (interactive "p")
  (kill-region (point) (progn (beginning-of-visual-line arg) (point))))

;; from https://stackoverflow.com/a/35711240/1160876
(defun delete-current-line (arg)
  "Delete (not kill) the current line."
  (interactive "p")
  (save-excursion
    (delete-region
     (progn (forward-visible-line 0) (point))
     (progn (forward-visible-line arg) (point)))))
{% endhighlight %}


## Summary

I am very happy with how cleanly these keybindings map to functionality.
Let's see if I can actually put these to use!
