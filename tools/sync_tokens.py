"""Write the colours from assets/tokens.toml into every template, and copy shared files.

    python3 tools/sync_tokens.py           # update the files
    python3 tools/sync_tokens.py --check   # exit 1 if anything is out of date (for CI or a hook)

Generated regions sit between "<tokens>" and "</tokens>" marker comments; edit tokens.toml, not
the regions. The Typst code-highlighting theme (cetal-code.tmTheme) is generated whole. The style guide is only checked: every hex in tokens.toml must appear in it.
"""
import re
import shutil
import sys
import tomllib
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TOKENS = tomllib.loads((ROOT / "assets/tokens.toml").read_text())
BRAND, DATA = TOKENS["brand"], TOKENS["data"]

STY = ROOT / "presentation/beamer/beamerthemeCETAL.sty"
TYP = ROOT / "presentation/touying/lib.typ"
MPL = ROOT / "presentation/beamer/cetal.mplstyle"
CODE_THEME = ROOT / "presentation/touying/assets/cetal-code.tmTheme"
GUIDE = ROOT / "CETAL Style Guide (Draft).md"
# Copies kept so the Typst package is self-contained (typst init copies only the package).
COPIES = {
    MPL: ROOT / "presentation/touying/tools/cetal.mplstyle",
    ROOT / "assets/logos/logo-principal.svg": ROOT / "presentation/touying/assets/logo-principal.svg",
    ROOT / "assets/logos/CETAL_Logo_blue.png": ROOT / "presentation/touying/assets/CETAL_Logo_blue.png",
    ROOT / "assets/logos/CETAL_Logo_blue_footer.png": ROOT / "presentation/touying/assets/CETAL_Logo_blue_footer.png",
}
NOTE = "generated from assets/tokens.toml by tools/sync_tokens.py; edit there"

STY_NAMES = {"primary": "cetalprimary", "tint": "cetaltint", "text": "cetaltext",
             "muted": "cetalgrey", "rule": "cetalrule", "alert": "cetalalert"}


def sty_block():
    lines = [rf"\definecolor{{{STY_NAMES[k]}}}{{HTML}}{{{v}}}" for k, v in BRAND.items()]
    lines += [rf"\definecolor{{oi{k}}}{{HTML}}{{{v}}}" for k, v in DATA.items()]
    return lines


def typ_block():
    lines = [f'#let cetal-{k} = rgb("#{v}")' for k, v in BRAND.items()]
    lines += ["/// Okabe–Ito data palette, in cycle order. Yellow (index 6) is for fills and thick lines only.",
              "#let okabe-ito = ("]
    lines += [f'  rgb("#{v}"), // {k}' for k, v in DATA.items()]
    return lines + [")"]


def mpl_block():
    t = BRAND["text"]
    cycle = ", ".join(f"'{v}'" for v in DATA.values())
    return [f"text.color         : {t}", f"axes.edgecolor     : {t}", f"axes.labelcolor    : {t}",
            f"xtick.color        : {t}", f"ytick.color        : {t}", f"legend.labelcolor  : {t}",
            f"grid.color         : {BRAND['rule']}",
            f"axes.prop_cycle    : cycler('color', [{cycle}])"]


def code_theme():
    """Syntax colours for Typst code blocks; the Beamer theme's \\lstset uses the same three."""
    rules = [("Comments", "comment", BRAND["muted"]),
             ("Keywords", "keyword.control, keyword.other, keyword.operator.word, keyword.operator.logical, storage, constant.language", BRAND["primary"])]
    items = "".join(f"""
    <dict><key>name</key><string>{n}</string><key>scope</key><string>{sc}</string>
      <key>settings</key><dict><key>foreground</key><string>#{c}</string></dict></dict>""" for n, sc, c in rules)
    return f"""<?xml version="1.0" encoding="UTF-8"?>
<!-- {NOTE} -->
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
  <key>name</key><string>CETAL</string>
  <key>settings</key><array>
    <dict><key>settings</key><dict><key>foreground</key><string>#{BRAND['text']}</string></dict></dict>{items}
  </array>
</dict></plist>
"""


def fill(path, comment, lines):
    text = path.read_text()
    pat = re.compile(rf"(^{re.escape(comment)} <tokens>[^\n]*\n).*?(^{re.escape(comment)} </tokens>)",
                     re.S | re.M)
    if not pat.search(text):
        sys.exit(f"{path.relative_to(ROOT)}: no '{comment} <tokens>' ... '{comment} </tokens>' region")
    head = f"{comment} <tokens> {NOTE}\n"
    return pat.sub(lambda m: head + "\n".join(lines) + "\n" + m.group(2), text, count=1)


def main():
    check = "--check" in sys.argv[1:]
    stale = []
    for path, comment, lines in [(STY, "%", sty_block()), (TYP, "//", typ_block()), (MPL, "#", mpl_block())]:
        new = fill(path, comment, lines)
        if new != path.read_text():
            stale.append(path)
            if not check:
                path.write_text(new)
    if not CODE_THEME.exists() or CODE_THEME.read_text() != code_theme():
        stale.append(CODE_THEME)
        if not check:
            CODE_THEME.write_text(code_theme())
    for src, dst in COPIES.items():
        if not dst.exists() or dst.read_bytes() != src.read_bytes():
            stale.append(dst)
            if not check:
                shutil.copyfile(src, dst)

    guide = GUIDE.read_text().upper()
    missing = sorted({v for v in [*BRAND.values(), *DATA.values()] if f"#{v}" not in guide})
    for v in missing:
        print(f"style guide: #{v} from tokens.toml is not mentioned; update the Colour section")

    for p in stale:
        print(("out of date: " if check else "updated: ") + str(p.relative_to(ROOT)))
    if check and (stale or missing):
        sys.exit(1)
    if not stale and not missing:
        print("all in sync")


if __name__ == "__main__":
    main()
