# The `blorem` Package

Do you wish typst blind text was not so repetitive?

## Getting Started

`blorem` exports a single function, `lorem`.
When used with a single argument, it is identical to the standard `lorem` function.
However, it lets you use a different seed for the random text
and optionally keep the first few words (Lorem ipsum...) as an identifier of blind text.

```typst
#import "@preview/blorem:99.99.99": lorem

#lorem(30, seed: 0, header: true)

#lorem(30, seed: 1)
```

Due to the way typst releases and manifest work,
I use version `99.99.99` as a stand-in for the current commit branch.
This is replaced on releases for a semantic version scheme.
