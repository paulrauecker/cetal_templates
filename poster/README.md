# CETAL poster (draft v0.1, 2026-10-14)

A0 portrait poster: three columns, funder band and QR code. It is built on the Beamer theme in
`../presentation/beamer/`, which also provides the colours, fonts, INFLPR | CETAL lockup and
`example-figure.pdf`. Unofficial until signed off.

## Build

```
latexmk -xelatex cetal-poster.tex
```

`latexmkrc` adds `../presentation/beamer/` and `../assets/logos/` to `TEXINPUTS`, so the theme,
the example figure and both logos are found there. Without latexmk, set it by hand (XeLaTeX twice,
because the tint band behind the title is sized from the first run):

```
TEXINPUTS=../presentation/beamer//:../assets/logos//: xelatex cetal-poster.tex
```

Logos, brand colours and the funding line: see `../presentation/beamer/README.md`.
