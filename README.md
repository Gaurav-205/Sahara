# Sahara Pet Care

Sahara is a Flutter application for pet-care service booking, caregiver discovery, messaging, and in-app commerce.

This README has been refreshed from actual repository state so setup instructions, file paths, and feature notes match the current codebase.

## Repository Analysis Snapshot

Based on current workspace scan:

- Total files: 330
- Dart files: 101
- Dart files under lib: 100
- Markdown docs: 13
- Current app version: 1.0.0+1

## What The App Includes

- Auth: Firebase email/password and Google sign-in
- Booking flow: caregiver discovery, service/package selection, booking lifecycle
- Messaging: chat and notification support
- Pet management: pet profiles and favorites
- Commerce: product listing, cart, checkout, orders
- Adoption: adoptable pets browsing
- Location: Google Maps + Geolocator + Geocoding

## Tech Stack

- Framework: Flutter (Dart 3, Material 3)
- State management: Provider
- Backend: Firebase Core, Auth, Firestore, Messaging
- Media: Cloudinary
- Notifications: Firebase Messaging + flutter_local_notifications

## Architecture Overview

Important runtime entrypoints:

- App bootstrap: lib/main.dart
- Firebase options: lib/firebase_options.dart
- Runtime config wrapper: lib/config/app_config.dart

Module layout:

- Models: lib/models
- Providers: lib/providers
- Services: lib/services
- Screens: lib/screens
- Shared UI: lib/widgets
- Utilities: lib/utils
- Scripts: lib/scripts

## Current Folder Structure

- lib: application code
- assets: images, icons, sounds, and env asset registration
- android, ios, web, windows, linux, macos: platform runners
- firestore.rules, firestore.indexes.json: Firestore authorization/index config
- firebase.json: Firebase project configuration
- test: widget test(s)
- docs: reserved docs folder (currently empty)

## Prerequisites

- Flutter SDK 3.x
- Dart SDK 3.x
- A Firebase project configured for your target platform(s)
- Android Studio or VS Code with Flutter tooling
- Cloudinary account (for image upload features)
- Google Maps API key(s) if map screens are used

## Setup

1. Install dependencies.

```bash
flutter pub get
```

2. Create your local env file.

Copy .env.example to .env and set real values:

```env
CLOUDINARY_CLOUD_NAME=...
CLOUDINARY_UPLOAD_PRESET=...
APP_NAME=Sahara Pet Care
APP_PRIMARY_COLOR=#1A2332
SUPPORT_EMAIL=...
SUPPORT_PHONE=...
PRIVACY_EMAIL=...
COMPANY_ADDRESS=...
```

3. Add Firebase platform files.

- android/app/google-services.json
- ios/Runner/GoogleService-Info.plist

If Firebase project settings change, regenerate/update lib/firebase_options.dart.

4. Configure Google Maps keys in platform-specific files (Android/iOS).

5. Run the app.

```bash
flutter run
```

## Data Seeding

Supported paths found in source:

- In-app admin seeding UI: lib/screens/admin_seed_screen.dart
- Script-based reseed target: lib/scripts/reseed_database.dart

Use seeding only against non-production projects unless you explicitly intend production writes.

## Useful Commands

Analyze:

```bash
flutter analyze
```

Test:

```bash
flutter test
```

Coverage:

```bash
flutter test --coverage
```

Build:

```bash
flutter build apk --release
flutter build appbundle --release
flutter build ios --release
flutter build web --release
```

## Security Checklist Before Production

- Replace placeholder values in .env and rotate any exposed credentials
- Restrict API keys by package/bundle/signature and enabled APIs
- Review and harden firestore.rules (least privilege)
- Enable Firebase App Check
- Remove or lock down any admin/demo seeding paths

## Documentation Map

Root-level docs currently present:

- QUICK_START_GUIDE.md
- DATA_SEEDING_GUIDE.md
- DEPLOYMENT_CHECKLIST.md

For repo minimization, legacy analysis/progress reports were removed.

## Quality Notes

- Automated tests are currently minimal (single widget smoke test in test/widget_test.dart)
- Consider expanding test coverage for providers, services, and booking/cart flows

## Contributing

1. Create a feature branch
2. Keep changes scoped and test locally
3. Run flutter analyze and flutter test before opening a PR
4. Update relevant docs when behavior or setup changes

## License

No LICENSE file is currently present in the repository root.
