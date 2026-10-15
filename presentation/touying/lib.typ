// CETAL Touying theme — draft v0.1 (2026-10-15)
// Implements the CETAL Style Guide (draft): white 16:9 slides, sentence-style titles with a
// short accent rule, grey footer (short title · speaker · event, slide number), no logo on
// content slides, INFLPR | CETAL lockup on the title and closing slides.
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
// Brand colours: one blue, from the only fill in the INFLPR logo-principal.svg, and a 10 % tint
// of it for panels. Okabe–Ito vermillion is the only warm accent (alerts).
#let cetal-primary = rgb("#112C87")
#let cetal-tint = rgb("#E7EAF3")

/// Okabe–Ito data palette, in the order the style guide uses (Colour section).
/// Yellow (index 6) is for fills and thick lines only.
#let okabe-ito = (
  rgb("#0072B2"), // blue
  rgb("#D55E00"), // vermillion
  rgb("#009E73"), // bluish green
  rgb("#E69F00"), // orange
  rgb("#CC79A7"), // reddish purple
  rgb("#56B4E9"), // sky blue
  rgb("#F0E442"), // yellow
  rgb("#000000"), // black
)

// ------------------------------------------------------------------ pieces
#let _logo-placeholder(height) = box(
  width: 2.6 * height,
  height: height,
  stroke: (paint: luma(107), thickness: 0.6pt, dash: "dashed"),
  align(center + horizon, text(size: 0.22 * height, fill: luma(107))[INFLPR logo]),
)

/// The INFLPR | CETAL lockup (style guide, Logos). `height` is the INFLPR logo height; the
/// CETAL mark is drawn taller so both read at the same visual weight. `logo: none` draws a
/// labelled placeholder, `cetal-logo: none` the word "CETAL".
#let cetal-lockup(self, height: 1.4cm) = {
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
#let _accent-rule(self) = block(spacing: 0pt, line(length: 2.2cm, stroke: 1.5pt + self.colors.primary))

#let _title-block(self, title) = {
  block(below: 0.5em, { set par(leading: 0.35em); text(size: 1.3em, weight: "semibold", bottom-edge: "descender", fill: self.colors.primary, title) })
  _accent-rule(self)
}

#let _footer(self) = {
  set text(size: 0.5em, fill: self.colors.neutral-dark)
  // Touying spans the footer across the full page width, so pad it back to the text margin.
  show: pad.with(x: self.store.margin-x)
  let title = self.info.short-title
  if title == auto { title = self.info.title }
  let author = self.store.short-author
  if author == auto { author = self.info.author }
  components.left-and-right(
    (title, author, self.store.event).filter(x => x != none).join([ #sym.dot.c ]),
    context utils.slide-counter.display(),
  )
}

/// Source note at the bottom of a slide, 10 pt grey (style guide, Presentations).
/// Example: `#source-note[Author et al., _Journal_ *12*, 345 (2026).]`
#let source-note(body) = place(
  bottom + left,
  text(size: 0.5em, fill: luma(107), body),
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
        row-gutter: 0.8em,
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

/// Title slide: title, subtitle, authors (underline the presenter), institution and
/// event · date on a tint panel, and the INFLPR | CETAL lockup on a white strip below it.
#let title-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      footer: none,
      background: {
        place(top, rect(width: 100%, height: 100% - 4.6cm, fill: self.colors.secondary))
        place(top, rect(width: 100%, height: 0.33cm, fill: self.colors.primary))
      },
    ),
    config,
  )
  let info = self.info + args.named()
  let body = {
    set text(fill: self.colors.neutral-darkest)
    v(0.6cm)
    block(spacing: 0pt, { set par(leading: 0.45em); text(size: 1.9em, weight: "semibold", fill: self.colors.primary, info.title) })
    if info.at("subtitle", default: none) != none {
      block(above: 1.1em, text(size: 1.05em, info.subtitle))
    }
    v(1.4em)
    if info.author != none { block(text(size: 0.9em, info.author)) }
    if info.institution != none {
      block(above: 0.5em, text(size: 0.7em, fill: self.colors.neutral-dark, info.institution))
    }
    let date = if info.date == none { none } else { utils.display-info-date(self) }
    let line-items = (self.store.event, date).filter(x => x != none)
    if line-items.len() > 0 {
      block(above: 1em, text(size: 0.7em, fill: self.colors.neutral-dark, line-items.join([ #sym.dot.c ])))
    }
    place(bottom + left, cetal-lockup(self))
  }
  touying-slide(self: self, body)
})

/// Section divider on the tint: the section title and the accent rule, no footer, not counted.
#let new-section-slide(config: (:), level: 1, numbered: false, body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(footer: none, fill: self.colors.secondary),
  )
  let setting(body) = {
    set std.align(horizon)
    block(below: 0.55em, text(
      size: 1.9em,
      weight: "semibold",
      bottom-edge: "descender",
      fill: self.colors.primary,
      utils.display-current-heading(level: level, numbered: numbered),
    ))
    _accent-rule(self)
    body
  }
  touying-slide(self: self, config: config, setting: setting, body)
})

/// Closing slide: funding acknowledgement, optional funder logos (the body), then contact
/// details and the lockup. Put the summary slide before this one.
#let closing-slide(config: (:), title: [Acknowledgements], ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config-page(footer: none), config)
  let extra = args.pos().at(0, default: none)
  let funding = args.named().at("funding", default: self.store.funding)
  let contact = args.named().at("contact", default: self.info.contact)
  let body = {
    set text(fill: self.colors.neutral-darkest)
    v(1fr)
    block(below: 0.5em, { set par(leading: 0.35em); text(size: 1.3em, weight: "semibold", bottom-edge: "descender", fill: self.colors.primary, title) })
    _accent-rule(self)
    v(0.8em)
    if funding != none { block(text(size: 0.7em, funding)) }
    if extra != none { block(above: 1em, extra) }
    v(1fr)
    if contact != none { block(text(size: 0.7em, fill: self.colors.neutral-dark, contact)) }
    v(0.6em)
    cetal-lockup(self, height: 1.1cm)
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
/// - font (str, array): Body font with fallbacks. Source Sans 3 is open licence (SIL OFL).
/// - align (alignment): Vertical alignment of slide bodies. Default `top`.
#let cetal-theme(
  aspect-ratio: "16-9",
  align: top,
  event: none,
  short-author: auto,
  funding: none,
  cetal-logo: image("assets/CETAL_Logo_blue.png"),
  font: ("Source Sans 3", "TeX Gyre Heros"),
  lang: "en",
  margin-x: 2cm,
  ..args,
  body,
) = {
  set text(size: 20pt, font: font, lang: lang)
  set par(justify: false)
  set list(marker: text(fill: cetal-primary, size: 0.7em, baseline: -0.15em, sym.triangle.filled.r))
  show figure.caption: set text(size: 0.6em, fill: luma(107))

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
    ),
    config-info(logo: image("assets/logo-principal.svg")),
    config-methods(alert: (self: none, it) => text(fill: okabe-ito.at(1), it)),
    config-colors(
      primary: cetal-primary,
      secondary: cetal-tint, // panels: title slide, section slides
      neutral-lightest: white,
      neutral-light: rgb("#D0D0D0"),
      neutral-dark: rgb("#6B6B6B"),
      neutral-darkest: rgb("#1A1A1A"),
    ),
    config-store(
      align: align,
      event: event,
      short-author: short-author,
      funding: funding,
      cetal-logo: cetal-logo,
      margin-x: margin-x,
    ),
    ..args,
  )

  body
}
