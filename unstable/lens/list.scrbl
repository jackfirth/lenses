#lang scribble/manual

@(require lens/doc-util/main)


@title{List Lenses}

@defmodule[unstable/lens/list]

@defproc[(list-ref-nested-lens [index exact-nonnegative-integer?] ...) lens?]{
  Constructs a lens that views into a tree made from nested lists.
  Indexing starts from zero in the same was as @racket[list-ref-lens].
  @lenses-unstable-examples[
    (define first-of-second-lens (list-ref-nested-lens 1 0))
    (lens-view first-of-second-lens '(1 (a b c) 2 3))
    (lens-set first-of-second-lens '(1 (a b c) 2 3) 'foo)
]}