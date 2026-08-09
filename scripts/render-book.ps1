param(
  [switch]$Stage
)

$ErrorActionPreference = "Stop"

function Resolve-Quarto {
  if ($env:QUARTO_BIN) {
    if (Test-Path -LiteralPath $env:QUARTO_BIN) {
      return $env:QUARTO_BIN
    }
    throw "QUARTO_BIN is set but does not exist: $env:QUARTO_BIN"
  }

  $candidates = @(
    "C:\Program Files\RStudio\resources\app\bin\quarto\bin\quarto.exe",
    "C:\Program Files\Quarto\bin\quarto.exe",
    "$env:LOCALAPPDATA\Programs\Quarto\bin\quarto.exe",
    "C:\Program Files\RStudio\resources\app\bin\quarto\bin\quarto.cmd",
    "C:\Program Files\Quarto\bin\quarto.cmd",
    "$env:LOCALAPPDATA\Programs\Quarto\bin\quarto.cmd"
  )

  foreach ($candidate in $candidates) {
    if (Test-Path -LiteralPath $candidate) {
      return $candidate
    }
  }

  $fromPath = Get-Command quarto -ErrorAction SilentlyContinue
  if ($fromPath) {
    return $fromPath.Source
  }

  throw "Could not find Quarto. Install Quarto, add it to PATH, or set QUARTO_BIN."
}

$quarto = Resolve-Quarto
Write-Host "Rendering with $quarto"
& $quarto render
if ($LASTEXITCODE -ne 0) {
  throw "Quarto render failed with exit code $LASTEXITCODE."
}

if (-not (Test-Path -LiteralPath "docs")) {
  New-Item -ItemType Directory -Path "docs" | Out-Null
}
New-Item -ItemType File -Path "docs\.nojekyll" -Force | Out-Null

if ($Stage) {
  git add docs .nojekyll
  if (Test-Path -LiteralPath "_freeze") {
    git add _freeze
  }
}

Write-Host "Rendered book to docs/."
