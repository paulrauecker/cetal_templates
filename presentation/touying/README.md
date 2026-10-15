# cetal-touying (draft v0.1, 2026-10-15)

A [Touying](https://github.com/touying-typ/touying) slide theme for CETAL talks that follows the
draft CETAL Style Guide. It is the Typst counterpart of the Beamer theme in `../beamer/`.
Unofficial until signed off.

Tested with Typst 0.14.2 and Touying 0.7.4. Touying 0.8.0 needs Typst 0.15, which stable
distributions (e.g. NixOS 26.05) do not ship yet, so the theme stays on 0.7.4 for now.

**Known Touying 0.7.x bug:** a `#pause` after `#uncover`, `#only` or `#alternatives` skips the
subslides they reserve, so the next content appears one step late. Use an absolute jump there
instead: after `#uncover("2")[..]`, write `#jump(2)` rather than `#pause`. Fixed in Touying 0.8.0.

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

`main.typ` is a working example deck: title slide, section dividers, a two-column slide with a
table and boxes, a figure slide, summary and acknowledgements.

## What the theme gives you

| Piece | Use |
| --- | --- |
| `cetal-theme.with(event:, short-author:, funding:, config-info(..))` | Sets fonts, colours, margins, footer and ISO dates |
| `#title-slide()` | Title, subtitle, authors, institution, event · date, INFLPR \| CETAL lockup |
| `= Section` | Section divider with "01", "02" (not counted, no footer; `section-numbers: false` to drop the number) |
| `== Sentence that states the message` | Content slide with the title and accent rule |
| `#slide(title: none)[...]` | Content slide without a title block |
| `#slide(composer: (1fr, 1fr))[left][right]` | Two columns (after a `==` heading it keeps that title) |
| `#panel(title: [..], kind: "alert")[...]` | Tint box, Beamer's block; `kind`: `"block"`, `"alert"`, `"example"` |
| `#table(.., table.header[..], table.hline(), ..)` | Tables get booktabs-style rules in the primary colour; `table.hline()` ends the header |
| `#source-note[...]` | Small grey source line above the footer; works inside columns too |
| `#closing-slide[funder logos]` | Acknowledgements with the `funding` text and contact, on the title slide's panel |
| `okabe-ito` | The data palette as an array, for CeTZ or Lilaq plots |
| `#alert[...]` | Highlight in vermillion. `*bold*` stays dark (semibold), as in Beamer |

## Before real use

1. **Logos.** The INFLPR logo (`logo-principal.svg`) and the blue CETAL logo ship in `assets/`
   and are used by default. Override them with `config-info(logo: image(..))` and
   `cetal-theme.with(cetal-logo: image(..))`; `none` draws a placeholder and the word "CETAL".
2. **Brand colours.** `cetal-primary` (`#112C87`, the INFLPR logo blue), `cetal-tint`
   (`#E7EAF3`, the panels) and the greys are at the top of `lib.typ`, generated from the
   repository's `assets/tokens.toml`. Change them there and run `python3 tools/sync_tokens.py`.
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
