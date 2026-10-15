"""Half-width figure for a Touying 16:9 slide (297 x 167 mm, 20 pt body). Synthetic data."""
import sys
from pathlib import Path
import matplotlib.pyplot as plt
import numpy as np

HERE = Path(__file__).resolve().parent
style = Path(sys.argv[1]) if len(sys.argv) > 1 else HERE / "cetal.mplstyle"
out = Path(sys.argv[2]) if len(sys.argv) > 2 else Path("example-figure.pdf")
plt.style.use(style)
rng = np.random.default_rng(1)
energy = np.linspace(2, 20, 10)
series = {"Probe A": 4.1 * energy + rng.normal(0, 3, energy.size),
          "Probe B": 3.2 * energy + rng.normal(0, 3, energy.size),
          "Probe C": 2.4 * energy + rng.normal(0, 3, energy.size)}
with plt.rc_context({"figure.figsize": (5.6, 3.7), "font.size": 17, "axes.labelsize": 17,
                     "xtick.labelsize": 15, "ytick.labelsize": 15, "legend.fontsize": 15,
                     "lines.markersize": 6, "lines.linewidth": 1.8, "axes.linewidth": 1.0,
                     "xtick.major.width": 1.0, "ytick.major.width": 1.0, "errorbar.capsize": 2.5}):
    fig, ax = plt.subplots()
    for (name, y), m in zip(series.items(), ["o", "s", "^"]):
        ax.errorbar(energy, y, yerr=3, marker=m, linestyle="-", label=name)
    ax.set_xlabel("Laser energy on target / J")
    ax.set_ylabel(r"$E_\mathrm{peak}$ / (kV m$^{-1}$)")
    ax.legend(loc="upper left")
    fig.savefig(out)
print("wrote", out)
