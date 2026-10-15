# CETAL Beamer theme (draft v0.1, 2026-10-14)

Beamer slides that implement the draft CETAL Style Guide. The A0 poster in `../../poster/` reuses
this theme. Unofficial until signed off.

| File | What it is |
| --- | --- |
| `beamerthemeCETAL.sty` | Beamer theme: 16:9 slides, title slide with the INFLPR \| CETAL lockup, sentence-style frame titles, grey footer, `\cetalclosingframe` for acknowledgements |
| `cetal-slides-example.tex` | Example deck using the theme |
| `cetal.mplstyle` | Matplotlib defaults: single-column size, Okabe–Ito colours, viridis, embedded TrueType fonts |
| `make_example_figure.py` | Builds `example-figure.pdf` used by the slides and the poster (synthetic data) |

## Build

```
python make_example_figure.py
latexmk -xelatex cetal-slides-example.tex
```

LuaLaTeX works too. Fonts: Source Sans 3 if installed, otherwise TeX Gyre Heros (ships with TeX Live).

## Logos and colours

The lockup uses `inflpr-logo.pdf` (the press-kit SVG converted with
`rsvg-convert -f pdf -o inflpr-logo.pdf logo-principal.svg`) and `CETAL_Logo_blue.png`, both in
`../../assets/logos/`. `latexmkrc` puts that folder on `TEXINPUTS`. If you copy the theme
elsewhere, copy the two logo files next to it; without them, a dashed placeholder and the word
"CETAL" are drawn.

Brand colours are `cetalprimary` (`#112C87`, the INFLPR logo blue) and `cetaltint` (`#E7EAF3`,
a 10 % tint used for the title and section slide panels).

## Funding line

The examples use the Core Programme as published by INFLPR: LAPLAS VII, contract 30N/2023.
INFLPR's own pages give two different project codes (PN 23 01 and PN-23 03 01), so the code is
left out until confirmed.
