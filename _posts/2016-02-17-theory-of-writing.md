---
title: Theory of Writing
category: notes
layout: default
---

# My Theory on Writing

The base of my theory is this: content editing is a completely different process from layout design.
Each of these processes is further complicated by real-time collaborations and the necessity for version control.

## Git For Everything

As much as possible, both the layout and content editing process should be capture-able by git.
Essentially, this means it should be text-based.
Keynote presentations (and other complex documents) should not be in a git repository.
All generated files, including the document itself, should not be included in the repository.

## Content Editing

Text should be editing plain ascii text files, possibly with markup language (HTML or Markdown).

When using git, each sentence gets its own line.
Sentences are the basic unit in writing, using one-line-per-sentence allows for easy parsing of diffs.

## Layout Design

Layout design should be a separate process entirely.
Layout designs should be codified (such as LaTeX or CSS).

## The End Document

The step of building the final document is often overlooked.
Many people choose to capture the process of creating a document through makefiles or another build system.
Including this is not necessary, since the tool chain is often quite brittle.

Instead, offical or *released* versions of the document should be included in the repository, with a tag.
This helps track submitted versions and can be used to generate track-changes style documents.
