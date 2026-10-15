# CETAL Style Guide (Draft)

Oct 14, 2026 · @Paul

## Status and scope

This is an unofficial working draft. It sets shared conventions for CETAL's papers, figures, slides and posters until INFLPR publishes a formal visual identity manual.

- **Why it exists:** INFLPR's public [press kit](https://inflpr.ro/kit-de-presa/) offers logo files but no written rules. Its branding text is still placeholder copy.
- **What it covers:** names and affiliation, logo use, colour, type, figures, slides, posters, writing conventions, acknowledgements and file naming.
- **What it does not cover:** official letterhead, contracts and procurement forms. Those follow INFLPR's quality-management (SMI) templates.
- **Precedence:** INFLPR rules win wherever they exist, and journal or conference author guidelines win for their own outputs.
- **Approval:** items marked *TBC* need confirmation from CETAL leadership or the INFLPR press office (press@inflpr.ro).

## Names and affiliation

Write the full name once at first mention, then the acronym. Never use "CETAL INFLPR" without a separator.

| Form | English | Romanian |
| --- | --- | --- |
| Centre, full | Center for Advanced Laser Technologies (CETAL) | Centrul de Tehnologii Avansate cu Laseri (CETAL) |
| Institute, full | National Institute for Laser, Plasma and Radiation Physics (INFLPR) | Institutul Național pentru Fizica Laserilor, Plasmei și Radiației (INFLPR) |
| Short, combined | CETAL, INFLPR | CETAL, INFLPR |
| Petawatt laboratory | Ultra-intense Lasers Laboratory (CETAL-PW) | Laboratorul PW (CETAL-PW) |
| Processing laboratory | Laser Material Processing Laboratory (CETAL-LaMP) | Laboratorul Procesări cu Laser (CETAL-LaMP) |
| Photonics laboratory | Photonic Investigations Laboratory (CETAL-PhIL) | Laboratorul de Investigații Fotonice (CETAL-PhIL) |
| Main laser | CETAL 1 PW laser system | Sistemul laser CETAL 1 PW |

Use US spelling "Center" in the centre's name, since that is how the name is published. The lab names and acronyms follow [cetal.inflpr.ro](https://cetal.inflpr.ro/laboratories) and the [INFLPR 2024 annual report](https://inflpr.ro/wp-content/uploads/2025/07/raport_anual_inflpr_2024-1.pdf), which also gives "CETAL 1 PW" for the laser. The Romanian centre name uses "Laseri" as in the annual report; the 2025 website heading says "cu Laser", so the institute itself is not yet consistent.

**Affiliation line for papers.** Use this exact form so citation databases merge records correctly:

```
Center for Advanced Laser Technologies (CETAL), National Institute for Laser, Plasma and Radiation Physics (INFLPR), 409 Atomiștilor Street, 077125 Măgurele, Ilfov, Romania
```

Add a second affiliation line for any university you are enrolled at or employed by. Keep the institute address as shown even when the journal shortens it.

*TBC:* INFLPR's [SMI page](https://inflpr.ro/documente-smi/) lists an institutional affiliation policy (Politica de afiliere instituțională). Its link points to a folder that cannot be opened from outside, so check this line against the policy before the guide is final.

**Contact details for public materials:** secretariat@inflpr.ro for general enquiries, press@inflpr.ro for media.

## Logos

Use only the official INFLPR vector files from the press kit, and never redraw, recolour or rasterise them at low resolution.

| Variant | File | Use for |
| --- | --- | --- |
| Primary | [logo-principal.svg](https://inflpr.ro/wp-content/uploads/2025/01/logo-principal.svg) | Default for slides, posters and reports |
| Secondary | [logo-secundar.svg](https://inflpr.ro/wp-content/uploads/2025/01/logo-secundar.svg) | *TBC:* likely the compact or alternate lockup |
| Tertiary | [logo-tertiar.svg](https://inflpr.ro/wp-content/uploads/2025/01/logo-tertiar.svg) | *TBC:* likely the mark alone, for small sizes |

**CETAL lockup.** The CETAL logo (swoosh, "cetal" wordmark and star) is not in the press kit and carries no fixed brand colour; the CETAL website shows it in white. The original file is dark red (#640000). For the templates it is recoloured to the INFLPR blue (#112C87), keeping its gradients, so the two marks read as one family. The lockup is the INFLPR logo, a thin vertical rule, then the CETAL logo at 1.6 times the INFLPR logo height so both carry the same visual weight. Without the CETAL file, the templates write "CETAL" in the heading typeface and primary colour instead. The slide and poster templates draw this lockup with `\cetallockup` (LaTeX) and `cetal-lockup` (Typst). The CETAL logo exists only as a 1022 × 621 px PNG, which is enough up to about 5 cm tall in print; ask for a vector original before using it larger.

**Rules (proposed):**

- Clear space on every side at least equal to the height of the logo's capital letters.
- Minimum width 25 mm in print and 120 px on screen for the full logo.
- On photos or dark backgrounds, use a white or single-colour version, or place the logo on a white panel.
- Do not stretch, rotate, add shadows or outlines, or place it on busy backgrounds.
- Partner and funder logos sit in one row at the same visual height, with INFLPR first or as the host.

## Colour

Use two palettes: brand colours for slide chrome and posters, and a colour-blind-safe palette for data.

**Brand colours.** The scheme is one blue, neutral greys and one warm accent. The blue is the only fill in logo-principal.svg; the tint is 10 % of it on white. No second brand hue is used: the CETAL logo's red would compete with the vermillion alert and the vermillion data series.

| Role | Hex | Contrast on white | Use |
| --- | --- | --- | --- |
| Primary | #112C87 | 12.1:1 | Title bar, headings, accent rules, bullets |
| Tint | #E7EAF3 | — | Panels: title slide, section slides, poster title band |
| Dark text | #1A1A1A | 17.4:1 | Body text |
| Muted text | #6B6B6B | 5.3:1 | Footer, affiliations, captions (4.4:1 on the tint, so keep it short there) |
| Rules | #D0D0D0 | — | Dividers, the rule in the lockup |
| Alert | #D55E00 | 3.9:1 | Highlights, bold or large text only |
| Light background | #FFFFFF | — | Slides, posters |

The templates define these as `cetalprimary` and `cetaltint` in beamerthemeCETAL.sty and `cetal-primary` and `cetal-tint` in the Typst theme.

**Data palette.** Use the Okabe–Ito set for categorical data, in this order. It stays distinguishable for the common forms of colour blindness and in greyscale with marker changes.

| Order | Name | Hex |
| --- | --- | --- |
| 1 | Blue | #0072B2 |
| 2 | Vermillion | #D55E00 |
| 3 | Bluish green | #009E73 |
| 4 | Orange | #E69F00 |
| 5 | Reddish purple | #CC79A7 |
| 6 | Sky blue | #56B4E9 |
| 7 | Yellow | #F0E442 |
| 8 | Near-black (dark text) | #1A1A1A |

Yellow is for fills and thick lines only, never thin lines or text on white. Brand colours never encode data; the first data colour (#0072B2) is a lighter, brighter blue than the primary, so do not swap one for the other. Figures take their non-data colours from the brand neutrals: dark text for axes, ticks and labels, rules grey for grids.

## Typography

Use free, open-licence fonts with full Romanian diacritics (ș, ț with comma below) so files open the same on every machine.

| Context | Typeface | Notes |
| --- | --- | --- |
| Slides and posters | Source Sans 3 | Headings semibold; body regular |
| Reports and long documents | Source Serif 4, or LaTeX defaults | Body 10–11 pt |
| Figures | Same as the target document | Match the journal's text font when known |
| Code and paths | Source Code Pro or JetBrains Mono | — |

*TBC:* whether INFLPR's 2025 website font should be adopted instead. Its CSS loads Google Fonts, so it is likely also open-licence.

In LaTeX, load the fonts through `fontspec` (LuaLaTeX or XeLaTeX), or keep Computer Modern for journal submissions. Do not substitute Arial or Calibri in shared templates, since they are not available on Linux nodes.

## Scientific figures

Make each figure at its final printed size, so text never needs rescaling and stays 7–9 pt in print.

| Target | Width | Text size |
| --- | --- | --- |
| Single column (most journals) | 8.5–9 cm | 8 pt |
| Double column | 17–19 cm | 8–9 pt |
| Beamer 16:9 slide (160 × 90 mm), half width | 7 cm | 9–10 pt |
| Beamer 16:9 slide, full width | 14 cm | 10–11 pt |
| Typst/Touying 16:9 slide (297 × 167 mm), half width | 13–14 cm | 15–17 pt |
| PowerPoint/Impress 16:9 slide (338.7 × 190.5 mm), half width | 14–16 cm | 16–18 pt |
| A0 poster, one column | 25 cm | 24–28 pt |

Check the target journal's guide for exact widths; these ranges fit most physics and materials journals. On slides and posters, figure text should match the surrounding body text once placed, which depends on the page size of the tool you use.

**Rules:**

- Axis labels as quantity / unit, for example *E* / (kV m⁻¹) or Time (ns). Use SI units and prefixes.
- Sequential data use viridis or cividis; signed data use a diverging map centred on zero (RdBu, vik). Never use jet or rainbow.
- Distinguish lines by marker or dash as well as colour.
- Panel labels (a), (b), (c) in bold, top-left, outside the axes.
- Show uncertainty as error bars or bands, and say in the caption what they represent (1σ, 95 % CI, min–max).
- Save as vector PDF or SVG for line art; PNG at 600 dpi only for images such as SEM micrographs or camera frames.
- Keep the generating script and data next to the figure (see File naming).
- No logos, titles or watermarks inside figures meant for papers.

**Matplotlib style file** (`cetal.mplstyle`, used via `plt.style.use("cetal.mplstyle")`):

```
figure.figsize     : 3.4, 2.6      # inches, single column
figure.dpi         : 150
savefig.dpi        : 600
savefig.bbox       : tight
font.size          : 8
axes.labelsize     : 8
xtick.labelsize    : 7
ytick.labelsize    : 7
legend.fontsize    : 7
legend.frameon     : False
axes.linewidth     : 0.6
text.color         : 1A1A1A    # dark text, also axes, ticks, legend
axes.edgecolor     : 1A1A1A
axes.labelcolor    : 1A1A1A
xtick.color        : 1A1A1A
ytick.color        : 1A1A1A
legend.labelcolor  : 1A1A1A
grid.color         : D0D0D0    # rules grey; grids off by default
grid.linewidth     : 0.4
lines.linewidth    : 1.0
lines.markersize   : 3
xtick.direction    : in
ytick.direction    : in
xtick.top          : True
ytick.right        : True
axes.prop_cycle    : cycler('color', ['0072B2', 'D55E00', '009E73', 'E69F00', 'CC79A7', '56B4E9', 'F0E442', '1A1A1A'])
image.cmap         : viridis
pdf.fonttype       : 42
ps.fonttype        : 42
```

`pdf.fonttype : 42` embeds TrueType fonts so text stays editable and passes journal checks.

## Presentations

Use 16:9 slides with a white background and the brand colour only for thin accents.

**Title slide:** talk title, speaker names (presenter underlined), affiliation line in short form, event name and date (ISO, 2026-10-14), INFLPR logo bottom-left and CETAL wordmark beside it.

**Content slides:**

- Footer, 9–10 pt grey: short title · speaker · event · slide number. No logo on every slide.
- One message per slide, written as the slide title in a full sentence ("EMP amplitude scales linearly with laser energy").
- Figures at slide size (see Scientific figures), never pasted screenshots of paper figures with 6 pt text.
- Cite sources on the slide in 10 pt: Author et al., *Journal* **vol**, page (year).

**Closing slide:** funding acknowledgement with funder logos, then contact details. Put a summary slide before it, not after.

**Templates (draft v0.1):**

| Template | Files | Notes |
| --- | --- | --- |
| Typst slides | `cetal-touying` local package (Touying 0.7.4, Typst 0.14) | Start a talk with `typst init @local/cetal-touying:0.1.0`; reads the SVG logo directly |
| LaTeX slides | `beamerthemeCETAL.sty` with an example deck | Tested with XeLaTeX (LuaLaTeX untested); uses the logo converted to PDF (`inflpr-logo.pdf`) |
| A0 poster | `cetal-poster.tex` | beamerposter, three columns, funder band and QR code |
| Figures | `cetal.mplstyle` | Single-column defaults; slide sizes in Scientific figures |

All templates use Source Sans 3 when installed, TeX Gyre Heros otherwise, and use the INFLPR and CETAL logos from the repository's `assets/logos/` (the Typst package ships its own copy); they draw a placeholder if the logo files are missing. Keep them in one shared repository so everyone uses the same version. No PowerPoint/Impress template exists yet.

## Posters

Default to A0 portrait (841 × 1189 mm) unless the conference specifies otherwise.

| Element | Size at A0 | Placement |
| --- | --- | --- |
| Title | 72–90 pt | Top band, left-aligned |
| Authors and affiliation | 36–44 pt | Under the title |
| Section headings | 44–54 pt | Brand colour |
| Body text | 24–28 pt | Readable from 1.5 m |
| Captions and references | 18–20 pt | Under each figure; references at the bottom |

- Logos: INFLPR top-left in the title band; funder logos in one row along the bottom edge.
- Three columns, 25–30 mm margins and gutters, white background.
- Lead with the main result in one sentence near the top, not in a conclusions box at the end.
- Add a QR code to the paper or preprint at bottom-right, at least 30 × 30 mm.
- Export as PDF with fonts embedded and images at 300 dpi at final size.

## Writing conventions

Write in English with US spelling for international outputs, and Romanian for national reports and outreach.

| Topic | Convention | Example |
| --- | --- | --- |
| Units | SI, with a space between number and unit | 25 fs, 10 PW, 1.2 J |
| Percent and degrees Celsius | Space before the symbol | 95 %, 20 °C |
| Angles | No space before the symbol | 45° |
| Decimal mark | Point in English, comma in Romanian | 0.85 / 0,85 |
| Large numbers | Thin space as thousands separator | 12 000 shots |
| Ranges | En dash, unit once | 800–1030 nm |
| Dates | ISO 8601 in tables and file names; spelled out in prose | 2026-10-14; 14 October 2026 |
| Quantities and variables | Italic symbol, upright unit and subscript words | *E*\<sub>max\</sub>, *t*\<sub>rise\</sub> |
| Abbreviations | Define at first use in each paper and each talk | time difference of arrival (TDOA) |

**Romanian diacritics.** Use comma-below ș and ț (U+0219, U+021B), not cedilla ş and ţ (U+015F, U+0163). The cedilla forms render wrongly in many fonts and break text search. Check names such as Măgurele and Atomiștilor before printing.

**Laser parameters.** Report wavelength, pulse duration (FWHM), energy on target, focal spot size and peak intensity, with the definition used for each.

## Funding acknowledgements

Name every funder with the exact programme name and contract code from the grant agreement. Funders check this, and a missing or wrong code can make a publication ineligible for reporting.

**Template:**

```
This work was supported by [funder] through [programme], project [code] ([acronym]). 
```

**Current codes:**

| Source | Programme | Code |
| --- | --- | --- |
| Ministry of Research, Innovation and Digitalization | INFLPR Core Programme 2023–2026, LAPLAS VII ("Research and advanced technology development of a laser – plasma radiation to space") | Contract 30N/2023; project code *TBC* |
| Project-based grants (UEFISCDI, PNRR, EU) | *per project* | *per project* |
| Infrastructure access (e.g. Laserlab-Europe) | *if applicable* | *grant number* |

Source: INFLPR's [Core Programme page](https://inflpr.ro/en/2023/03/27/program-nucleu-2023-2026-2/) and [project page](https://inflpr.ro/en/2023/03/27/proiect-nucleu-inflpr-2023-2026/). The English pages render the acronym as "LAPLAS LIVE", a translation slip for VII. The project code is given as both "PN 23 01" (page title) and "PN-23 03 01" (body text), so confirm it with the project lead's office before printing it.

**Ready-to-use line (until the code is confirmed):**

```
This work was supported by the Romanian Ministry of Research, Innovation and Digitalization through the INFLPR Core Programme LAPLAS VII, contract 30N/2023.
```

- Keep a maintained list of current codes in the shared repository so nobody copies an expired one.
- Thank facilities and technical staff by name in the acknowledgements, not as authors, unless they contributed to the science.
- On slides and posters, include funder logos where the funder requires them, and follow their own logo rules.

## File naming

Name files so they sort by date and say what they are: `YYYY-MM-DD_project_description_vN.ext`, in lowercase with hyphens inside words.

| Kind | Example |
| --- | --- |
| Talk | `2026-10-14_emp-diagnostics_group-meeting_v2.pdf` |
| Poster | `2026-06-22_iclpr-st_tdoa-interferometry_poster.pdf` |
| Figure | `fig03_emp-amplitude-vs-energy.pdf` |
| Figure script | `fig03_emp-amplitude-vs-energy.py` |
| Raw data | `2026-10-14_shot0412_scope2_ch1.h5` |

- No spaces, diacritics or characters outside a–z, 0–9, hyphen, underscore and dot.
- Keep "final" out of file names; use a version number or a dated release instead.
- Store each figure's script and source data beside it so any figure can be regenerated.

## Open items

Six items are resolved; the rest need someone with an INFLPR login, the logo file, or authority to decide.

- [x] Check the public SMI documents for templates: none found; only the affiliation policy and internal procedures are listed
- [x] Decide the CETAL lockup: INFLPR logo, rule, CETAL logo recoloured to the INFLPR blue
- [x] Confirm laboratory names: CETAL-PW, CETAL-LaMP, CETAL-PhIL, and the CETAL 1 PW laser
- [x] Find the Core Programme: LAPLAS VII, contract 30N/2023
- [x] Build the Beamer theme, A0 poster template and matplotlib style
- [x] Extract the brand hex colours from logo-principal.svg: one fill, #112C87
- [ ] Get a vector original of the CETAL logo
- [ ] Confirm the Core Programme project code (PN 23 01 vs PN-23 03 01)
- [ ] Read the institutional affiliation policy (internal) and align the affiliation line
- [ ] Check the intranet and calitate.inflpr.ro for internal templates
- [ ] Ask press@inflpr.ro about a visual identity manual and the secondary and tertiary logos
- [ ] Decide whether a PowerPoint/Impress template is needed
- [ ] Get sign-off from CETAL leadership

## Sources

- [INFLPR press kit (Kit de presă)](https://inflpr.ro/kit-de-presa/)
- [INFLPR home page](https://inflpr.ro/)
- [INFLPR SMI documents](https://inflpr.ro/documente-smi/)
- [INFLPR annual report 2024](https://inflpr.ro/wp-content/uploads/2025/07/raport_anual_inflpr_2024-1.pdf)
- [CETAL page on inflpr.ro](https://inflpr.ro/cercetare/laboratoare/cetal-programul-centrului-pentru-tehnologii-laser-avansate/)
- [CETAL laboratories](https://cetal.inflpr.ro/laboratories)
- [CETAL-PW laboratory](https://cetal.inflpr.ro/newsite/cetal-pw)
- [INFLPR Core Programme 2023–2026](https://inflpr.ro/en/2023/03/27/program-nucleu-2023-2026-2/)
- [INFLPR Core Programme project page](https://inflpr.ro/en/2023/03/27/proiect-nucleu-inflpr-2023-2026/)
- [Okabe & Ito, Color Universal Design](https://jfly.uni-koeln.de/color/)
