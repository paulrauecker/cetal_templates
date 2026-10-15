# cetal_templates

Draft templates for CETAL (INFLPR) that implement the draft CETAL Style Guide. Unofficial until
signed off.

| Folder | What it holds |
| --- | --- |
| [`presentation/beamer/`](presentation/beamer/) | Beamer theme (LaTeX), example deck, matplotlib style and example figure |
| [`presentation/touying/`](presentation/touying/) | `cetal-touying`, the Typst/Touying slide theme, as a local Typst package |
| [`poster/`](poster/) | A0 portrait poster (LaTeX), built on the Beamer theme |
| [`assets/logos/`](assets/logos/) | INFLPR press-kit logo (`logo-principal.svg`) and the CETAL logo |
| [`assets/tokens.toml`](assets/tokens.toml) | The colours, defined once for all templates |
| [`tools/sync_tokens.py`](tools/sync_tokens.py) | Writes the tokens into the themes and the matplotlib style; `--check` for CI |
| [`docs/HANDOFF.md`](docs/HANDOFF.md) | State of the design work and known rough edges |

Each folder has a README with build steps and what to change before real use.
