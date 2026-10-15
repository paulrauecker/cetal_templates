"""Make the light CETAL logo for slide footers from assets/logos/CETAL_Logo_blue.png.

    python3 tools/make_footer_logo.py [opacity]      # default 0.5

Lowers the alpha channel (the gradient stays, the mark just reads lighter on white) and scales it
down to footer size. Baked into the PNG rather than set in the themes: Typst 0.14 has no image
opacity, and a plain RGBA PNG looks the same in every viewer and printer.
Then run tools/sync_tokens.py to copy it into the Typst package.
"""
import sys
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "assets/logos/CETAL_Logo_blue.png"
DST = ROOT / "assets/logos/CETAL_Logo_blue_footer.png"
HEIGHT = 200  # px; enough for 0.75 cm at about 680 dpi

opacity = float(sys.argv[1]) if len(sys.argv) > 1 else 0.5
im = Image.open(SRC).convert("RGBA")
im = im.resize((round(im.width * HEIGHT / im.height), HEIGHT), Image.LANCZOS)
im.putalpha(im.getchannel("A").point(lambda a: round(a * opacity)))
im.save(DST, optimize=True)
print(f"wrote {DST.relative_to(ROOT)} at {opacity:.0%} opacity")
