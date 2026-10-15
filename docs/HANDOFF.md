# CETAL style kit — handoff for the aesthetic pass

Status as of 2026-10-15. Everything here is an unofficial draft (v0.1) built from public INFLPR
sources. Paths are relative to the repository root.

## What is where

| Path | What it is |
| --- | --- |
| `CETAL Style Guide (Draft).md` | The guide, exported from the doc |
| `presentation/beamer/` | LaTeX: Beamer theme + example deck, `cetal.mplstyle`, example figure |
| `poster/` | A0 beamerposter (uses the Beamer theme via `latexmkrc`) |
| `presentation/touying/` | Typst: Touying theme as a local package, starter deck, figure script |
| `assets/logos/logo-principal.svg` | INFLPR press-kit logo (https://inflpr.ro/kit-de-presa/); one fill colour, `#112C87` |
| `assets/logos/CETAL_Logo.png` | CETAL logo, dark red (about `#640000`); no brand identity attached |

## Current design tokens

Defined once in `assets/tokens.toml`. `python3 tools/sync_tokens.py` writes them into
`beamerthemeCETAL.sty`, `lib.typ` and `cetal.mplstyle`, and copies the mplstyle and logos into the
Typst package; `--check` fails if anything is out of date.

| Token | Value | Status |
| --- | --- | --- |
| Primary | `#112C87` (INFLPR logo blue) | Applied |
| Tint (was secondary) | `#E7EAF3` (10 % primary) | Applied: title slide, section slides, poster title band |
| Text | `#1A1A1A` | Chosen |
| Muted text (footer, institution, captions) | `#6B6B6B` | Chosen; 5.3:1 on white |
| Rules / dividers | `#D0D0D0` | Chosen |
| Alert | `#D55E00` (Okabe–Ito vermillion) | Chosen |
| Data palette | Okabe–Ito, 8 colours, fixed order | Chosen, in the guide |
| Sequential / diverging maps | viridis or cividis / RdBu or vik | Chosen |
| Type | Source Sans 3 (semibold headings), fallback TeX Gyre Heros | Chosen; INFLPR web font unknown |
| Math | Source Sans 3 in figures (mathtext); Computer Modern Sans (Beamer), New Computer Modern Math (Typst) on slides | Figures done; slides default |

## Layout as built

| Element | Beamer (160 × 90 mm, 11 pt) | Touying (297 × 167 mm, 20 pt) |
| --- | --- | --- |
| Side margins | 1.1 cm | 2 cm |
| Title slide | Top colour bar 0.18 cm, title `\huge`, lockup bottom left 0.9 cm | Bar 0.33 cm, title 1.9em, lockup 1.65 cm |
| Content title | `\Large` semibold, primary, rule 1.2 cm × 1.2 pt; content top-aligned | 1.3em semibold, primary, rule 2.2 cm × 2.2 pt |
| Footer | 8.5 pt grey: short title · speaker · event, number right | 0.8em grey, same content |
| Section slide | "01" grey, title + rule, slightly above centre, not counted | Same |
| Closing slide | Title-slide panel and lockup; acknowledgements, funding, contact | Same |
| Boxes | `block`/`alertblock`/`exampleblock` on the tint | `#panel(title:, kind:)` |
| Tables | booktabs, rules in primary (`\arrayrulecolor`) | Same look; `table.hline()` after the header |

Positions on matching slides agree to within about 1 % of the page height (checked by rendering
both sample decks).
| Bullets | Small primary triangle | Same |
| Lockup | INFLPR logo, thin grey rule, "CETAL" semibold primary | Same |

## Known rough edges

- **Maths on slides differs.** Beamer sets maths in Computer Modern Sans, Typst in serif New
  Computer Modern Math. Neither is chosen deliberately.
- **Code blocks.** Typst code blocks sit on the tint; Beamer has no styled code block (use a
  `block` around `verbatim` in a `[fragile]` frame).
- **CETAL logo is a PNG only** (1022 × 621 px); fine for slides and the poster lockup, soft
  above about 5 cm tall. A vector original is still wanted.
- **No Typst poster.** The A0 poster exists only as beamerposter.
- **The style guide has no visuals.** Palette swatches, a slide anatomy diagram and a do/don't
  logo panel would help readers.
- **LuaLaTeX untested.** Comments in the Beamer files say LuaLaTeX works; only XeLaTeX was
  tested. The guide doc is already corrected.
- **No PowerPoint/Impress template**; not yet decided whether one is needed.

## Build and check

```
# LaTeX (XeLaTeX tested)
cd presentation/beamer
python make_example_figure.py
latexmk -xelatex cetal-slides-example.tex
cd ../../poster && latexmk -xelatex cetal-poster.tex

# Typst (Touying 0.7.4, Typst >= 0.14; 0.8.0 would need Typst 0.15, see presentation/touying/lib.typ)
mkdir -p ~/.local/share/typst/packages/local/cetal-touying
ln -s "$PWD/presentation/touying" ~/.local/share/typst/packages/local/cetal-touying/0.1.0
typst init @local/cetal-touying:0.1.0 talk && cd talk && typst watch main.typ

# Colours: edit assets/tokens.toml, then
python3 tools/sync_tokens.py          # --check only reports

# Look at the result
pdftoppm -r 60 -png talk/main.pdf preview
```

The Typst theme was checked with long two-line titles, `title: none` slides, and a real SVG logo
(it scales to the lockup height). Touying spans the footer across the full page width, so the
theme pads it back by `margin-x`; keep that if the footer is redesigned.

## Fixed content (don't change in an aesthetic pass)

- Names: Center for Advanced Laser Technologies (CETAL); labs CETAL-PW, CETAL-LaMP, CETAL-PhIL;
  laser "CETAL 1 PW".
- Funding line: Ministry of Research, Innovation and Digitalization, INFLPR Core Programme LAPLAS VII,
  contract 30N/2023 (project code unconfirmed: PN 23 01 vs PN-23 03 01).
- Content rules from the guide: sentence titles, no logo on content slides, ISO dates, Okabe–Ito
  for data, figures made at final size.

## Still open (outside the aesthetic work)

- Core Programme project code
- Internal affiliation policy (SMI, intranet only)
- Reply from press@inflpr.ro (email drafted, not yet sent)
- Leadership sign-off
