# Code Meter

Turn your coding time into screen time.

**Code Meter** is an Android app that helps you manage daily device usage by rewarding screen time based
on your coding activity from [WakaTime](https://wakatime.com). Code for 4 hours at a 50% reward
rate, and you earn 2 hours of unlocked device usage. No coding, no screen time.

Built with **Flutter** for the UI and **native Kotlin** for on-device usage tracking and
enforcement, designed to feel calm, minimal, and native — closer to Digital Wellbeing than a
typical productivity app.

<!-- TODO Add screenshots here once available:
<p align="center">
  <img src="docs/screenshots/onboarding.png" width="250" />
  <img src="docs/screenshots/dashboard.png" width="250" />
  <img src="docs/screenshots/settings.png" width="250" />
</p>
-->

## How it works

1. Connect your WakaTime account with a personal API key.
2. Set a reward percentage — how many minutes of device time you earn per minute of coding.
3. Code Meter tracks your coding activity for the day and unlocks device usage as you go.
4. Optionally roll over unused screen time to the next day.

```
4h 32m coded today
      × 50% reward rate
      ────────────────
   2h 16m device time earned
```

## Features

- **WakaTime integration** — syncs your daily coding time via your personal API key
- **Configurable reward rate** — 0–100%, set your own coding-to-screen-time ratio
- **Time rollover** — optionally carry unused screen time into the next day
- **Allowed apps list** — choose which apps stay usable while your allowance holds
- **Dynamic Color** — adopts Material You theming on Android 12+, with a fixed fallback palette
  otherwise
- **Light and dark themes**
- **No accounts, no tracking, no ads** — your WakaTime API key stays on-device

## Screens

- **Welcome / Setup** — connect your WakaTime API key, set your reward percentage, and choose
  whether unused time rolls over
- **Dashboard** — today's coding time, allowed device time, remaining balance, allowed apps, and a
  manual sync button
- **Settings** — manage your API key, reward rate, rollover preference, and app info

## Tech stack

- [Flutter](https://flutter.dev) / [Dart](https://dart.dev) — UI layer
- [Material 3](https://m3.material.io/) — design system, via Flutter's `useMaterial3` theming
- **Native Kotlin** — Android `UsageStatsManager` / `AccessibilityService` integration for usage
  tracking and enforcement, bridged to Flutter via platform channels
- [WakaTime API](https://wakatime.com/developers)

Code Meter currently targets **Android only**. The usage-enforcement mechanic relies on Android-specific
APIs (`UsageStatsManager`, `AccessibilityService`) that don't have an equivalent cross-platform
abstraction, so there's no iOS build planned at this time.

## Getting started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- Android Studio or VS Code with the Flutter/Dart extensions
- A [WakaTime](https://wakatime.com) account and personal API
  key ([find yours here](https://wakatime.com/settings/api-key))
- A physical Android device or emulator running API 26+

### Setup

```bash
git clone https://github.com/hazyio/code_meter.git
cd code_meter
flutter pub get
```

Because Code Meter includes native Kotlin code for usage tracking (via platform channels), running
`flutter run` will trigger a native Android build the first time — this is expected and normal, not
an error. No build-time secrets or `.env` files are required, since the WakaTime API key is entered
by the user at runtime during onboarding, not baked into the build.

```bash
flutter run
```

## Missing an app?

The Allowed Apps list is built from apps that report a launcher entry on your device — a small
number of apps you rely on daily (dialers, messaging apps, some pre-installed system apps) can be
filtered out unintentionally. Essential apps are tracked in
[`site/static/essential_apps.txt`](site/static/essential_apps.txt), one per line, in the format:

```
appid,link
```

For example:

```
com.google.android.apps.maps,https://play.google.com/store/apps/details?id=com.google.android.apps.maps
```

Once deployed, the file is also served directly from the project's own site at
[`codemeter.hazyio.com/essential_apps.txt`](https://codemeter.hazyio.com/essential_apps.txt) — an
additional, GitHub-independent source the app can fall back to.

**Fastest way to add one:** click below to edit the file directly on GitHub — it'll fork the repo
and open a pull request for you automatically, no local clone needed.

👉 [**Edit `essential_apps.txt` and open a PR**](../../edit/main/site/static/essential_apps.txt)

Prefer not to open a PR yourself? [Open a Missing App report](../../issues/new?template=missing_app.yml)
instead with the app's package name and a link to its store or download page, and it'll be added
for you.

## Contributing

Contributions are welcome — see [CONTRIBUTING.md](CONTRIBUTING.md) for setup details, coding
conventions, and how to submit a pull request.

## Privacy

Code Meter only communicates with the WakaTime API using the key you provide. No usage data, coding
stats, or device information is sent anywhere else. Your API key is stored locally on your device.

## License

Code Meter is open source, licensed under the [MIT License](LICENSE) — free to use, modify, and
distribute.

## Acknowledgments

- [WakaTime](https://wakatime.com) for the coding-activity API this app is built around. Code Meter is
  an independent, unofficial client and is not affiliated with or endorsed by WakaTime.
- [Icon Kitchen](https://icon.kitchen/) for the app icon and splash screen assets, without which this app icon would be off and the splash screen would be a blank white screen.
