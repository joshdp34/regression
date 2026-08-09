# STA 3386 Regression Analysis

Quarto source notes for the STA 3386 Regression Analysis course book.

## Local render workflow

This repository is configured so the book is rendered locally before commits and then served by GitHub Pages from the committed `docs/` folder.

Manual render:

```powershell
.\scripts\render-book.ps1
```

Render and stage the generated Pages files:

```powershell
.\scripts\render-book.ps1 -Stage
```

Normal commit workflow:

```powershell
git add .
git commit -m "Update notes"
git push
```

The local pre-commit hook runs `quarto render`, writes the HTML book to `docs/`, and stages `docs/` plus `_freeze/` when present.

If you ever need to make an emergency commit without rendering:

```powershell
$env:SKIP_QUARTO_RENDER = "1"
git commit -m "Commit without render"
Remove-Item Env:\SKIP_QUARTO_RENDER
```

## GitHub Pages setup

After pushing this repository to GitHub, open the repository settings:

1. Go to **Settings → Pages**.
2. Under **Build and deployment**, choose **Deploy from a branch**.
3. Select branch **main** and folder **/docs**.
4. Save.

After that, each push to `main` that includes updated `docs/` output will update the published book.

## Notes on freeze

The project uses:

```yaml
execute:
  freeze: auto
```

That lets Quarto re-run executable chunks only when their source changes during full project renders. If `_freeze/` is created, keep it committed; it preserves local computation results for reproducible renders.
