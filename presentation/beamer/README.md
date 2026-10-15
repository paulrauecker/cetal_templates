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

## Two things to do before real use

1. **Logo.** `logo-principal.svg` from the INFLPR press kit (https://inflpr.ro/kit-de-presa/) is in
   `assets/logos/`. Convert it next to the theme:

   ```
   rsvg-convert -f pdf -o inflpr-logo.pdf ../../assets/logos/logo-principal.svg
   ```

   Until `inflpr-logo.pdf` exists, a dashed placeholder box is drawn.

2. **Brand colours.** `cetalprimary` and `cetalsecondary` in `beamerthemeCETAL.sty` are placeholders.
   Read the real values from the logo and replace them:

   ```
   grep -oE '#[0-9A-Fa-f]{6}' ../../assets/logos/logo-principal.svg | sort | uniq -c | sort -rn
   ```

   Colours may also be given as `rgb(...)` or in a `<style>` block; check the file if grep finds nothing.

## Funding line

The examples use the Core Programme as published by INFLPR: LAPLAS VII, contract 30N/2023.
INFLPR's own pages give two different project codes (PN 23 01 and PN-23 03 01), so the code is
left out until confirmed.
