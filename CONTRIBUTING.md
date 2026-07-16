# Contributing to Code Meter

Thanks for considering a contribution — this is a small, community-driven project, and improvements of any size are welcome.

## Ways to contribute

- **Bug reports** — open an issue with clear reproduction steps
- **Feature requests** — open an issue describing the use case before writing code, so we can align on approach
- **Code contributions** — bug fixes, new features, refactors
- **Design feedback** — the app follows Material 3 and a black-and-white, minimal aesthetic; UI suggestions that keep this direction are welcome
- **Documentation** — README fixes, clearer setup instructions, code comments

## Before you start

For anything beyond a small fix (typo, minor bug), **open an issue first** to discuss the change. This avoids duplicate work and makes sure the feature or fix fits the project's direction before you invest time in it.

## Development setup

1. Fork the repository and clone your fork:
   ```bash
   git clone https://github.com/<your-username>/code_meter.git
   cd code_meter
   ```
2. Run `flutter pub get`, then open the project in Android Studio or VS Code with the Flutter/Dart
   extensions installed.
3. Create a branch for your change:
   ```bash
   git checkout -b fix/short-description
   ```
4. To test WakaTime integration locally, use your own personal API key from your [WakaTime settings](https://wakatime.com/settings/api-key) — entered at runtime through the app's onboarding screen. Never commit an API key to the repo.

## Code style

- **Dart** — follow the [Effective Dart](https://dart.dev/effective-dart) style guide
- **Flutter widgets** — prefer small, reusable, stateless widgets; hoist state up rather than
  holding it inside widget classes
- **Native Kotlin** (usage tracking / enforcement code) — follow the
  [official Kotlin coding conventions](https://kotlinlang.org/docs/coding-conventions.html)
- **Formatting** — run `dart format .` for Dart code before committing
- Keep pull requests focused — one logical change per PR is easier to review than a bundle of
  unrelated fixes
   
## Commit messages

Write clear, present-tense commit messages:

```
Add reward percentage slider to settings screen
Fix crash when WakaTime API key is empty
Update README with setup instructions
```

## Submitting a pull request

1. Push your branch to your fork.
2. Open a pull request against `main`, with:
   - A clear description of what the change does and why
   - Screenshots or a screen recording for any UI change
   - A reference to the related issue, if one exists (e.g. `Closes #12`)
3. Be responsive to review feedback — small follow-up commits are fine, no need to force-push unless asked.

## Reporting bugs

When filing a bug report, please include:

- Android version and device (or emulator) used
- Steps to reproduce
- Expected vs. actual behavior
- Screenshots or logs if relevant

## Code of Conduct

This project follows the [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you're expected to uphold it.

## Questions

If anything here is unclear, open an issue with the `question` label — happy to clarify.
