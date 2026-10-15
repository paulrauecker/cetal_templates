"""Generate the example figure used in cetal-slides-example.tex.

Synthetic data only -- this demonstrates the style, not a result.
"""
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

HERE = Path(__file__).resolve().parent
plt.style.use(HERE / "cetal.mplstyle")

rng = np.random.default_rng(1)
energy = np.linspace(2, 20, 10)  # J
series = {
    "Probe A": 4.1 * energy + rng.normal(0, 3, energy.size),
    "Probe B": 3.2 * energy + rng.normal(0, 3, energy.size),
    "Probe C": 2.4 * energy + rng.normal(0, 3, energy.size),
}

# Half-width figure for a Beamer 16:9 slide (page 160 x 90 mm): about 7.2 cm wide,
# text 9-10 pt so it matches the 11 pt slide body (style guide, Scientific figures).
with plt.rc_context({"figure.figsize": (2.85, 2.0), "font.size": 10,
                     "axes.labelsize": 10, "xtick.labelsize": 9,
                     "ytick.labelsize": 9, "legend.fontsize": 9,
                     "lines.markersize": 3.5, "lines.linewidth": 1.2}):
    fig, ax = plt.subplots()
    markers = ["o", "s", "^"]
    for (name, y), m in zip(series.items(), markers):
        ax.errorbar(energy, y, yerr=3, marker=m, linestyle="-", label=name)
    ax.set_xlabel("Laser energy on target / J")
    ax.set_ylabel(r"$E_\mathrm{peak}$ / (kV m$^{-1}$)")
    ax.legend(loc="upper left")
    fig.savefig(HERE / "example-figure.pdf")
print("wrote example-figure.pdf")
