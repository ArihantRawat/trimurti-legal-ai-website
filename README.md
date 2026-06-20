# Trimurti Marketing Website

A static Flutter web marketing site for Trimurti and Juridical Loop OS.

The site is written as a front-end only experience. It has no backend, authentication, database, API integration, or runtime network calls. The public copy keeps the product high level because Juridical Loop OS is still being built.

## What Is Included

- Premium responsive Flutter web interface
- Stealth startup positioning for a legal AI company
- First-visit intro animation
- Sticky navigation with section scrolling
- Contact links that open a prefilled email to `arihantrawat@gmail.com`
- Modular feature, product vision, security, FAQ, CTA, and footer sections
- Widget tests for homepage rendering, mobile layout, and contact email setup
- GitHub Actions workflow for GitHub Pages deployment

## Project Structure

```text
lib/
  main.dart
  src/
    app.dart
    core/                 Shared services, theme, motion, responsive helpers
    features/home/        Home page state, anchors, sections, and widgets
    shared/               Reusable models, data, and UI widgets
test/
  widget_test.dart
web/
  index.html, manifest, and icons
.github/workflows/
  deploy-pages.yml
```

## Requirements

- Flutter stable
- Dart SDK compatible with the version in `pubspec.yaml`

Check your Flutter install:

```powershell
flutter --version
```

## Run Locally

```powershell
flutter pub get
flutter run -d chrome
```

If you are using the local Flutter SDK path on this machine:

```powershell
C:\Users\ariha\flutter\bin\flutter.bat pub get
C:\Users\ariha\flutter\bin\flutter.bat run -d chrome
```

## Verify

```powershell
flutter analyze
flutter test
```

## Build

For a normal local web build:

```powershell
flutter build web --release
```

For GitHub Pages under this repository path:

```powershell
flutter build web --release --base-href "/trimurti-legal-ai-website/"
```

## Deploy

Deployment is handled by GitHub Actions in `.github/workflows/deploy-pages.yml`.

The workflow runs on every push to `main` and can also be started manually from the Actions tab. It installs Flutter, runs analysis and tests, builds the web app with the GitHub Pages base path, uploads `build/web`, and deploys it through GitHub Pages.

The site includes `web/.nojekyll` so GitHub Pages serves Flutter web assets as plain static files.

For private repositories, GitHub Pages must be supported by the account or organization plan. If Pages is not available for private repositories on the current plan, keep the workflow as-is and either upgrade the plan or make the repository public before enabling Pages.

To enable Pages:

1. Open the repository on GitHub.
2. Go to `Settings` > `Pages`.
3. Set `Build and deployment` to `GitHub Actions`.
4. Run `Deploy Flutter web to GitHub Pages` from the Actions tab, or push to `main`.

Expected Pages URL:

```text
https://arihantrawat.github.io/trimurti-legal-ai-website/
```

## Content Notes

Most public-facing text lives in:

```text
lib/src/shared/data/site_content.dart
```

The short version of the site is controlled by:

```text
lib/src/features/home/home_config.dart
```

Set `HomeConfig.showDetailedSections` to `true` if you want to restore the longer page flow.
