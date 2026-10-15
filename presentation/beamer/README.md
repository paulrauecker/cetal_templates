# CETAL Beamer theme (draft v0.1, 2026-10-14)

Beamer slides that implement the draft CETAL Style Guide. The A0 poster in `../../poster/` reuses
this theme. Unofficial until signed off.

| File | What it is |
| --- | --- |
| `beamerthemeCETAL.sty` | Beamer theme: 16:9 slides, title slide with the INFLPR \| CETAL lockup, sentence-style frame titles, grey footer, numbered section slides, tint blocks, booktabs tables, `\cetalclosingframe` for acknowledgements |
| `cetal-slides-example.tex` | Example deck using the theme |
| `cetal.mplstyle` | Matplotlib defaults: single-column size, Okabe–Ito colours, brand greys for axes, maths in Source Sans 3, embedded TrueType fonts |
| `make_example_figure.py` | Builds `example-figure.pdf` used by the slides and the poster (synthetic data) |

## Build

```
python make_example_figure.py
latexmk -xelatex cetal-slides-example.tex
```

LuaLaTeX works too. Fonts, all SIL OFL: Source Sans 3 for text (otherwise TeX Gyre Heros, which ships
with TeX Live), Fira Math for maths through `unicode-math` (otherwise Beamer's sans maths) and
Source Code Pro for code. Fira Math is on CTAN as `firamath`.

## Logos and colours

The lockup uses `inflpr-logo.pdf` (the press-kit SVG converted with
`rsvg-convert -f pdf -o inflpr-logo.pdf logo-principal.svg`) and `CETAL_Logo_blue.png`, both in
`../../assets/logos/`. `latexmkrc` puts that folder on `TEXINPUTS`. If you copy the theme
elsewhere, copy the two logo files next to it; without them, a dashed placeholder and the word
"CETAL" are drawn.

Brand colours are `cetalprimary` (`#112C87`, the INFLPR logo blue), `cetaltint` (`#E7EAF3`, the
panels), `cetaltext`, `cetalgrey`, `cetalrule` and `cetalalert`; the data palette is `oiblue` …
`oiblack`. They come from `../../assets/tokens.toml`: edit that and run
`python3 tools/sync_tokens.py` from the repository root, not the `.sty`.

## Slide elements

- Content is top-aligned (`\begin{frame}[c]` centres one frame).
- `block`, `alertblock`, `exampleblock`: tint panels with a primary, vermillion or dark title.
- Tables: use booktabs (`\toprule`, `\midrule`, `\bottomrule`); the rules are drawn in the primary
  colour. No vertical rules.
- `\alert{..}` for colour emphasis; `\textbf` stays dark.
- `\url` is set in the primary colour; links made with `\href` are not coloured.
- Section slides show the number ("01"); `\cetalsectionnumbersfalse` in the preamble turns that off.
- The footer carries a light CETAL logo (`CETAL_Logo_blue_footer.png`, 50 % opacity) left of the
  slide number; `\cetalfooterlogofalse` turns it off.
- `\cetalclosingframe[funder logos]` uses the title slide's panel and lockup.

## Funding line

The examples use the Core Programme as published by INFLPR: LAPLAS VII, contract 30N/2023.
INFLPR's own pages give two different project codes (PN 23 01 and PN-23 03 01), so the code is
left out until confirmed.
