# cetal-touying (draft v0.1, 2026-10-15)

A [Touying](https://github.com/touying-typ/touying) slide theme for CETAL talks that follows the
draft CETAL Style Guide. It is the Typst counterpart of the Beamer theme in `../beamer/`.
Unofficial until signed off.

Tested with Typst 0.15.1 and Touying 0.8.0.

## Install once, as a local package

Copy (or symlink) this folder to the local package directory:

| OS | Path |
| --- | --- |
| Linux | `~/.local/share/typst/packages/local/cetal-touying/0.1.0/` |
| macOS | `~/Library/Application Support/typst/packages/local/cetal-touying/0.1.0/` |
| Windows | `%APPDATA%\typst\packages\local\cetal-touying\0.1.0\` |

```
mkdir -p ~/.local/share/typst/packages/local/cetal-touying
ln -s "$PWD" ~/.local/share/typst/packages/local/cetal-touying/0.1.0
```

## Start a talk

```
typst init @local/cetal-touying:0.1.0 my-talk
cd my-talk
typst watch main.typ
```

`main.typ` is a working example deck: title slide, section divider, a figure slide, summary and
acknowledgements.

## What the theme gives you

| Piece | Use |
| --- | --- |
| `cetal-theme.with(event:, short-author:, funding:, config-info(..))` | Sets fonts, colours, margins, footer and ISO dates |
| `#title-slide()` | Title, subtitle, authors, institution, event · date, INFLPR \| CETAL lockup |
| `= Section` | Section divider (not counted, no footer) |
| `== Sentence that states the message` | Content slide with the title and accent rule |
| `#slide(title: none)[...]` | Content slide without a title block |
| `#source-note[...]` | Small grey source line at the bottom of a slide |
| `#closing-slide[funder logos]` | Acknowledgements with the `funding` text, contact, lockup |
| `okabe-ito` | The data palette as an array, for CeTZ or Lilaq plots |
| `#alert[...]` | Highlight in vermillion |

## Before real use

1. **Logo.** Copy `logo-principal.svg` (INFLPR press kit, https://inflpr.ro/kit-de-presa/) from
   `assets/logos/` in this repository next to `main.typ`, and uncomment
   `logo: image("logo-principal.svg")`. Typst reads SVG directly, so no conversion is needed.
   Without it, a dashed placeholder is drawn.
2. **Brand colours.** `cetal-primary` and `cetal-secondary` at the top of `lib.typ` are
   placeholders. Read the real values from the logo:

   ```
   grep -oE '#[0-9A-Fa-f]{6}' logo-principal.svg | sort | uniq -c | sort -rn
   ```

3. **Font.** Install Source Sans 3 (SIL OFL, https://github.com/adobe-fonts/source-sans/releases),
   or compile with `typst compile --font-path fonts/ main.typ` and a `fonts/` folder.
   Without it the theme falls back to TeX Gyre Heros.

## Figures

The Touying 16:9 page is 297 × 167 mm with 20 pt body text, about twice the size of a Beamer
page. Make a half-width figure about 13–14 cm wide with 15–17 pt text, so it reads like the
slide text. `tools/make_example_figure.py` shows the matplotlib settings
(`figsize=(5.6, 3.7)` in, labels 17 pt) on top of `tools/cetal.mplstyle`. Typst embeds PDF and
SVG figures directly.

## Funding line

The example uses the Core Programme as published by INFLPR: LAPLAS VII, contract 30N/2023. INFLPR's
pages give two different project codes (PN 23 01 and PN-23 03 01), so the code is left out until
confirmed.
