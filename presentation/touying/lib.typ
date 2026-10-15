// CETAL Touying theme — draft v0.1 (2026-10-15)
// Implements the CETAL Style Guide (draft): white 16:9 slides, sentence-style titles with a
// short accent rule, grey footer (short title · speaker · event, light CETAL logo, slide number),
// INFLPR | CETAL lockup on the title and closing slides.
//
//   #import "@local/cetal-touying:0.1.0": *
//   #show: cetal-theme.with(event: [Group meeting], config-info(title: [...]))
//
// The INFLPR and CETAL logos ship in assets/ and are used by default; override them with
// `config-info(logo: ..)` and `cetal-logo:`.

// Pinned to Touying 0.7.4, the last release that runs on Typst 0.14 (0.8.0 needs Typst 0.15).
// When moving to 0.8: register a `notes-fn`, give title/section/closing slides a hidden heading,
// and keep the title-slide background off the notes half (Touying changelog, theme migration).
#import "@preview/touying:0.7.4": *

// ------------------------------------------------------------------ colours
// Brand colours: one blue, from the only fill in the INFLPR logo-principal.svg, a 10 % tint of it
// for panels, neutral greys, and Okabe–Ito vermillion as the only warm accent (alerts).
// <tokens> generated from assets/tokens.toml by tools/sync_tokens.py; edit there
#let cetal-primary = rgb("#112C87")
#let cetal-tint = rgb("#E7EAF3")
#let cetal-text = rgb("#1A1A1A")
#let cetal-muted = rgb("#6B6B6B")
#let cetal-rule = rgb("#D0D0D0")
#let cetal-alert = rgb("#D55E00")
/// Okabe–Ito data palette, in cycle order. Yellow (index 6) is for fills and thick lines only.
#let okabe-ito = (
  rgb("#0072B2"), // blue
  rgb("#D55E00"), // vermillion
  rgb("#009E73"), // green
  rgb("#E69F00"), // orange
  rgb("#CC79A7"), // purple
  rgb("#56B4E9"), // sky
  rgb("#F0E442"), // yellow
  rgb("#1A1A1A"), // black
)
// </tokens>

// ------------------------------------------------------------------ pieces
#let _logo-placeholder(height) = box(
  width: 2.6 * height,
  height: height,
  stroke: (paint: cetal-muted, thickness: 0.6pt, dash: "dashed"),
  align(center + horizon, text(size: 0.22 * height, fill: cetal-muted)[INFLPR logo]),
)

/// The INFLPR | CETAL lockup (style guide, Logos). `height` is the INFLPR logo height; the
/// CETAL mark is drawn taller so both read at the same visual weight. `logo: none` draws a
/// labelled placeholder, `cetal-logo: none` the word "CETAL".
#let cetal-lockup(self, height: 1.65cm) = {
  let logo = self.info.at("logo", default: none)
  let mark = if logo == none { _logo-placeholder(height) } else {
    set image(height: height)
    box(logo)
  }
  let cetal = self.store.cetal-logo
  let cetal-mark = if cetal == none {
    text(size: 0.55 * height, weight: "semibold", fill: self.colors.primary)[CETAL]
  } else {
    set image(height: 1.6 * height)
    box(cetal)
  }
  grid(
    columns: 3,
    column-gutter: 0.45 * height,
    align: horizon,
    mark,
    line(angle: 90deg, length: 1.6 * height, stroke: 0.6pt + self.colors.neutral-light),
    cetal-mark,
  )
}

// Block-level so it always sits below the text it follows, never on its baseline.
#let _accent-rule(self) = block(spacing: 0pt, line(length: 2.2cm, stroke: 2.2pt + self.colors.primary))

#let _title-block(self, title) = {
  block(below: 0.7em, { set par(leading: 0.35em); text(size: 1.3em, weight: "semibold", bottom-edge: "descender", fill: self.colors.primary, title) })
  _accent-rule(self)
}

#let _footer(self) = {
  set text(size: 0.8em, fill: self.colors.neutral-dark)
  // Touying spans the footer across the full page width, so pad it back to the text margin.
  show: pad.with(x: self.store.margin-x)
  let title = self.info.short-title
  if title == auto { title = self.info.title }
  let author = self.store.short-author
  if author == auto { author = self.info.author }
  context {
    let notes = query(<cetal-source-note>).filter(m => m.location().page() == here().page())
    if notes.len() > 0 {
      place(bottom + left, dy: -2.8em, block(width: 80%, text(size: 1.06em, notes.map(m => m.value).join(linebreak()))))
    }
  }
  let logo = self.store.footer-logo
  components.left-and-right(
    (title, author, self.store.event).filter(x => x != none).join([ #sym.dot.c ]),
    {
      if logo != none {
        // The "cetal" wordmark's x-height (centred 0.665 of the logo height below its top) is
        // centred on the footer text's x-height (0.14 cm above the baseline), so the wordmark and
        // the slide number line up. Zero height, so the footer keeps its size.
        let size = 1.3cm
        set image(height: size)
        box(height: 0pt, baseline: 0pt, move(dy: -0.14cm - 0.665 * size, logo))
        h(0.56cm)
      }
      context utils.slide-counter.display()
    },
  )
}

/// Source note at the bottom of a slide, 10 pt grey (style guide, Presentations). It is drawn
/// by the footer, just above it, so it lands in the same place wherever it is written, also
/// inside a column. Example: `#source-note[Author et al., _Journal_ *12*, 345 (2026).]`
#let source-note(body) = [#metadata(body)<cetal-source-note>]

/// Tint panel with an optional title, the counterpart of Beamer's block, alertblock and
/// exampleblock. `kind`: "block" (primary title), "alert" (alert title) or "example" (dark title).
/// Example: `#panel(title: [Key result])[Peak field rises by 4.1 kV/m per joule.]`
#let panel(title: none, kind: "block", body) = block(
  width: 100%,
  fill: cetal-tint,
  inset: (x: 0.55em, y: 0.6em),
  breakable: false,
  {
    if title != none {
      let fill = (block: cetal-primary, alert: cetal-alert, example: cetal-text).at(kind)
      block(below: 0.65em, text(weight: "semibold", fill: fill, title))
    }
    body
  },
)

// ------------------------------------------------------------------ slides
/// Content slide. The title comes from the `== Heading` or `title:`; write it as a full
/// sentence that states the slide's message. `title: none` drops the title block.
#let slide(
  title: auto,
  align: auto,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  if align != auto { self.store.align = align }
  self = utils.merge-dicts(self, config-page(footer: _footer))
  let new-setting = body => {
    set text(fill: self.colors.neutral-darkest)
    show: setting
    let t = if title == auto {
      utils.display-current-heading(depth: self.slide-level)
    } else { title }
    if t == none {
      std.align(self.store.align, body)
    } else {
      grid(
        rows: (auto, 1fr),
        row-gutter: 1.2em,
        _title-block(self, t),
        std.align(self.store.align, body),
      )
    }
  }
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: new-setting,
    composer: composer,
    ..bodies,
  )
})

// Tint panel with the primary bar on top, leaving a white strip for the lockup: the background of
// the title and closing slides, so the talk opens and closes on the same frame.
#let _panel-page(self) = config-page(
  footer: none,
  background: {
    place(top, rect(width: 100%, height: 100% - 4.8cm, fill: self.colors.secondary))
    place(top, rect(width: 100%, height: 0.33cm, fill: self.colors.primary))
  },
)

/// Title slide: title, subtitle, authors (underline the presenter), institution and
/// event · date on a tint panel, and the INFLPR | CETAL lockup on a white strip below it.
#let title-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    _panel-page(self),
    config,
  )
  let info = self.info + args.named()
  let body = {
    set text(fill: self.colors.neutral-darkest)
    v(0.6cm)
    block(spacing: 0pt, { set par(leading: 0.45em); text(size: 1.9em, weight: "semibold", fill: self.colors.primary, info.title) })
    if info.at("subtitle", default: none) != none {
      block(above: 1.1em, text(size: 1.1em, info.subtitle))
    }
    v(1.4em)
    if info.author != none { block(info.author) }
    if info.institution != none {
      block(above: 0.5em, text(size: 0.9em, fill: self.colors.neutral-dark, info.institution))
    }
    let date = if info.date == none { none } else { utils.display-info-date(self) }
    let line-items = (self.store.event, date).filter(x => x != none)
    if line-items.len() > 0 {
      block(above: 1em, text(size: 0.9em, fill: self.colors.neutral-dark, line-items.join([ #sym.dot.c ])))
    }
    place(bottom + left, dy: 0.1cm, cetal-lockup(self))
  }
  touying-slide(self: self, body)
})

/// Section divider on the tint: two-digit section number (unless `section-numbers: false`), the
/// section title and the accent rule. No footer, not counted.
#let new-section-slide(config: (:), level: 1, numbered: false, body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(footer: none, fill: self.colors.secondary),
  )
  let setting(body) = {
    // A little above centre, as in the Beamer theme
    v(1fr)
    if self.store.section-numbers {
      context {
        let h = utils.current-heading(level: level)
        if h != none {
          // Touying keeps headings from stepping counter(heading), so count them instead.
          let n = query(heading.where(level: level).before(h.location())).len()
          block(below: 0.95em, text(size: 1.3em, weight: "semibold", fill: self.colors.neutral-dark,
            (if n < 10 { "0" } else { "" }) + str(n)))
        }
      }
    }
    block(below: 0.55em, text(
      size: 1.9em,
      weight: "semibold",
      bottom-edge: "descender",
      fill: self.colors.primary,
      utils.display-current-heading(level: level, numbered: numbered),
    ))
    _accent-rule(self)
    body
    v(2fr)
  }
  touying-slide(self: self, config: config, setting: setting, body)
})

/// Closing slide on the same panel as the title slide: funding acknowledgement, optional funder
/// logos (the body), then contact details, with the lockup below. Put the summary slide before it.
#let closing-slide(config: (:), title: [Acknowledgements], ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    _panel-page(self),
    config,
  )
  let extra = args.pos().at(0, default: none)
  let funding = args.named().at("funding", default: self.store.funding)
  let contact = args.named().at("contact", default: self.info.contact)
  let body = {
    set text(fill: self.colors.neutral-darkest)
    v(0.6cm)
    _title-block(self, title)
    v(1.25em)
    if funding != none { block(text(size: 0.9em, funding)) }
    if extra != none { block(above: 1em, extra) }
    v(1fr)
    if contact != none { block(text(size: 0.9em, fill: self.colors.neutral-dark, contact)) }
    v(4.1cm)
    place(bottom + left, dy: 0.1cm, cetal-lockup(self))
  }
  touying-slide(self: self, body)
})

// ------------------------------------------------------------------ theme
/// CETAL theme for Touying.
///
/// - event (content, none): Event name for the title slide and footer, e.g. `[Group meeting]`.
/// - short-author (content, auto): Speaker for the footer; `auto` uses `config-info(author: ..)`.
/// - funding (content, none): Default acknowledgement text for `closing-slide`.
/// - cetal-logo (content, none): CETAL mark for the lockup; `none` writes "CETAL" instead.
/// - footer-logo (content, none): Light CETAL logo in the footer of content slides; `none` drops it.
/// - font (str, array): Body font with fallbacks. Source Sans 3 is open licence (SIL OFL).
/// - math-font (str, array): Maths font. Fira Math is a sans maths font (SIL OFL) that matches
///   the body; it is scaled to the body's x-height. Typst warns if it is not installed.
/// - code-font (str, array): Code font, Source Code Pro (SIL OFL), at the body's x-height.
/// - align (alignment): Vertical alignment of slide bodies. Default `top`.
/// - section-numbers (bool): Show "01", "02" above section titles. Default `true`.
#let cetal-theme(
  aspect-ratio: "16-9",
  align: top,
  event: none,
  short-author: auto,
  funding: none,
  cetal-logo: image("assets/CETAL_Logo_blue.png"),
  footer-logo: image("assets/CETAL_Logo_blue_footer.png"),
  font: ("Source Sans 3", "TeX Gyre Heros"),
  math-font: ("Fira Math", "New Computer Modern Math"),
  code-font: ("Source Code Pro", "DejaVu Sans Mono"),
  lang: "en",
  margin-x: 2cm,
  section-numbers: true,
  ..args,
  body,
) = {
  set text(size: 20pt, font: font, lang: lang)
  set par(justify: false)
  // Bold is semibold, as in Beamer, and stays dark: emphasis in colour is `#alert[..]` only.
  set strong(delta: 200)
  set list(marker: (
    // The body font's own small triangle (U+25B8), sized and centred on the lowercase letters by
    // its designer; same as Beamer.
    text(fill: cetal-primary, "\u{25B8}"),
    text(fill: cetal-muted, [–]),
  ))
  set enum(numbering: n => text(fill: cetal-primary)[#n.])
  show link: set text(fill: cetal-primary)
  // Captions grey and unnumbered: slides have no "Figure 3" to refer to.
  set figure(numbering: none)
  show figure.caption: set text(size: 0.85em, fill: cetal-muted)
  // Tables: booktabs-style rules in the primary colour, no vertical rules. Mark the end of the
  // header with `table.hline()`, like \midrule; header row in semibold.
  set table(stroke: none, inset: (x: 0.5em, y: 0.3em), align: left)
  set table.hline(stroke: 0.05em + cetal-primary)
  show table.cell.where(y: 0): set text(weight: "semibold")
  show table: it => box(stroke: (y: 0.08em + cetal-primary), inset: (y: 0.15em), it)
  // Sans maths, so equations match the text and the figures. Fira Math has a larger x-height
  // than Source Sans 3 (0.527 vs 0.486 em); 0.92em lines them up.
  show math.equation: set text(font: math-font, size: 0.92em)
  // Code at 0.9 of the body size, as in Beamer: Source Code Pro shares Source Sans 3's x-height
  // but is much wider. Typst scales raw by a further 0.8, hence 1.125em. Blocks at 0.8.
  show raw: set text(font: code-font, size: 1.125em)
  show raw.where(block: true): set text(size: 1em)
  // Syntax colours from the tokens: keywords primary, comments grey, the rest text colour.
  set raw(theme: "assets/cetal-code.tmTheme")
  show raw.where(block: true): block.with(fill: cetal-tint, inset: 0.55em, width: 100%)

  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      fill: white,
      margin: (top: 1.2cm, bottom: 1.6cm, x: margin-x),
      footer-descent: 0.55cm,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
      datetime-format: "[year]-[month]-[day]",
      show-strong-with-alert: false,
    ),
    config-info(logo: image("assets/logo-principal.svg")),
    config-methods(alert: (self: none, it) => text(fill: cetal-alert, it)),
    config-colors(
      primary: cetal-primary,
      secondary: cetal-tint, // panels: title, section and closing slides
      neutral-lightest: white,
      neutral-light: cetal-rule,
      neutral-dark: cetal-muted,
      neutral-darkest: cetal-text,
    ),
    config-store(
      align: align,
      event: event,
      short-author: short-author,
      funding: funding,
      cetal-logo: cetal-logo,
      footer-logo: footer-logo,
      margin-x: margin-x,
      section-numbers: section-numbers,
    ),
    ..args,
  )

  body
}
