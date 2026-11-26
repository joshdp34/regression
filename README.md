# STA 3386 Regression Analysis

Quarto source notes for the STA 3386 Regression Analysis course book.

Published at <https://joshdp34.github.io/regression/>.

## How publishing works

Each push to `main` runs the GitHub Actions workflow in
`.github/workflows/publish.yml`, which renders the HTML book and deploys it to
GitHub Pages. Nothing rendered needs to be committed.

## Notes on freeze

The project uses `execute: freeze: auto`. Chapters reuse the computed results
saved in `_freeze/`, so GitHub only re-runs R code for a chapter whose source
changed. After editing a chapter, render it locally (`quarto render`) and
commit the updated `_freeze/` along with the `.qmd` so GitHub does not need to
re-run it.
