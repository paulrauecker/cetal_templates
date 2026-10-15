// CETAL talk — starter deck for the cetal-touying theme (draft v0.1)
// Build:  typst compile main.typ        Live preview:  typst watch main.typ
#import "@local/cetal-touying:0.1.0": *

#show: cetal-theme.with(
  event: [Group meeting],
  short-author: [P. Example],
  funding: [This work was supported by the Romanian Ministry of Research, Innovation and
    Digitalization through the INFLPR Core Programme LAPLAS VII, contract 30N/2023.],
  // TBC: add the project code once confirmed (PN 23 01 vs PN-23 03 01).
  config-info(
    title: [EMP amplitude scales with laser energy on target],
    short-title: [Example talk],
    subtitle: [A worked example of the CETAL slide template],
    author: [#underline[Presenter Name], Co-author Name],
    institution: [CETAL, National Institute for Laser, Plasma and Radiation Physics (INFLPR), Măgurele, Romania],
    date: datetime(year: 2026, month: 10, day: 15),
    contact: [presenter\@inflpr.ro #h(0.8em) · #h(0.8em) cetal.inflpr.ro],
    // Drop the press-kit file next to this one and uncomment (Typst reads SVG directly):
    // logo: image("logo-principal.svg"),
  ),
)

#title-slide()

= Results

== Peak field grows linearly with energy on all three probes

#grid(
  columns: (1.15fr, 1fr),
  column-gutter: 1.2cm,
  image("example-figure.pdf"),
  [
    - One message per slide, written as the title
    - Figures made at final size, text close to the slide text
    - Lines differ by marker as well as colour
    - Units as quantity / unit: $E$ / (kV m#super[−1])
  ],
)

#source-note[Synthetic example data. Real sources: Author et al., _Journal_ *12*, 345 (2026).]

== Summary comes before the acknowledgements

+ First conclusion, with its number
+ Second conclusion
+ What happens next

#closing-slide[
  // Funder logos in one row, same height, e.g.:
  // #grid(columns: 3, column-gutter: 1cm, image("funder-a.svg", height: 1cm), ...)
]
