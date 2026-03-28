<div align="center">
  <img src="assets/images/logo.png" alt="Sahara Pet Care Logo" width="100" />

  # Sahara Pet Care

  Full-stack Flutter app for pet care booking, adoption, commerce, and caregiver coordination

  [![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=flat-square&logo=dart&logoColor=white)](https://dart.dev)
  [![Firebase](https://img.shields.io/badge/Firebase-Enabled-FFCA28?style=flat-square&logo=firebase&logoColor=black)](https://firebase.google.com)
  [![Platform](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-5C6BC0?style=flat-square)](#)
  [![Version](https://img.shields.io/badge/Version-1.0.0%2B1-success?style=flat-square)](pubspec.yaml)
</div>

---

## Overview

Sahara Pet Care is a production-oriented Flutter application built to streamline modern pet care workflows. It combines caregiver discovery, service booking, product shopping, adoption flows, live tracking, and chat in a single cross-platform experience.

The project is backed by Firebase services for authentication, data, and messaging, with Provider-based state management and modular code organization for maintainability.

---

## Features

| Module | Description |
|--------|-------------|
| Authentication | Email/password and Google Sign-In flows with Firebase Auth |
| Caregiver Discovery | Browse, filter, and view caregiver profiles by service and location |
| Booking System | End-to-end booking flow with status lifecycle and booking history |
| Pet Profiles | Manage pets, favorites, and profile-linked pet context |
| Messaging | Chat and message models for caregiver communication workflows |
| Shopping | Product listing, cart, order placement, and order tracking |
| Adoption | Browse adoptable pets and manage adoption enquiries |
| Location and Maps | Geolocator, geocoding, and Google Maps powered flows |
| Notifications | Firebase Cloud Messaging and local notifications support |
| Admin Utilities | In-app admin seeding screen and script-based reseed support |

---

## Tech Stack

| Layer | Technologies |
|-------|-------------|
| Frontend | Flutter, Dart, Material 3, Provider |
| Backend Services | Firebase Core, Firebase Auth, Cloud Firestore, Firebase Messaging |
| Media and Assets | Cloudinary, Cached Network Image, Image Picker |
| Mapping and Geo | Google Maps Flutter, Geolocator, Geocoding |
| Utilities | Shared Preferences, Intl, URL Launcher, UUID |
| Platforms | Android, iOS, Web, Windows, macOS, Linux |

---

## Screenshots

> Add your latest app screenshots under assets/images and update paths below.

| Home | Caregiver Discovery | Booking |
|:---:|:---:|:---:|
| <img src="assets/images/screenshot-home.png" alt="Home" width="260" /> | <img src="assets/images/screenshot-caregivers.png" alt="Caregivers" width="260" /> | <img src="assets/images/screenshot-booking.png" alt="Booking" width="260" /> |

| Shopping | Tracking | Chat |
|:---:|:---:|:---:|
| <img src="assets/images/screenshot-shop.png" alt="Shopping" width="260" /> | <img src="assets/images/screenshot-tracking.png" alt="Tracking" width="260" /> | <img src="assets/images/screenshot-chat.png" alt="Chat" width="260" /> |

---

## Local Setup

### Prerequisites

- Flutter SDK 3.x
- Dart SDK 3.x
- Firebase project configured for target platforms
- Android Studio or VS Code with Flutter tooling
- Optional: Cloudinary account for media upload features

### 1. Clone and install dependencies

```bash
git clone <your-repository-url>
cd Sahara
flutter pub get
```

### 2. Configure environment variables

Create a .env file in the project root with values used by runtime config:

```env
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_UPLOAD_PRESET=your_upload_preset
APP_NAME=Sahara Pet Care
APP_PRIMARY_COLOR=#1A2332
SUPPORT_EMAIL=support@example.com
SUPPORT_PHONE=+91XXXXXXXXXX
PRIVACY_EMAIL=privacy@example.com
COMPANY_ADDRESS=Your company address
```

### 3. Add Firebase platform files

- android/app/google-services.json
- ios/Runner/GoogleService-Info.plist

If your Firebase project values changed, regenerate firebase options and update lib/firebase_options.dart.

### 4. Run locally

```bash
flutter run
```

---

## Project Structure

```text
Sahara/
├── lib/
│   ├── main.dart
│   ├── firebase_options.dart
│   ├── config/
│   ├── models/
│   ├── providers/
│   ├── screens/
│   ├── services/
│   ├── theme/
│   ├── utils/
│   └── widgets/
├── assets/
│   ├── icons/
│   ├── images/
│   └── sounds/
├── test/
├── android/
├── ios/
├── web/
├── windows/
├── linux/
├── macos/
├── firebase.json
├── firestore.rules
├── firestore.indexes.json
├── QUICK_START_GUIDE.md
├── DATA_SEEDING_GUIDE.md
├── DEPLOYMENT_CHECKLIST.md
└── pubspec.yaml
```

---

## Core App Modules

| Path | Responsibility |
|------|----------------|
| lib/main.dart | App bootstrap, provider wiring, and route entry |
| lib/config/app_config.dart | Runtime configuration and environment parsing |
| lib/models | Domain entities for booking, products, chat, pets, orders, users |
| lib/providers | State and business flow orchestration |
| lib/screens | User-facing feature screens |
| lib/services | Data access and integration services |
| lib/widgets | Reusable UI components |
| lib/scripts/reseed_database.dart | Script-based data reseeding |
| lib/screens/admin_seed_screen.dart | In-app admin data seeding controls |

---

## Data and Firebase Notes

| Area | Details |
|------|---------|
| Firestore Rules | Controlled by firestore.rules |
| Firestore Indexes | Defined in firestore.indexes.json |
| Firebase Config | Centralized in firebase.json and lib/firebase_options.dart |
| Messaging | Firebase Messaging is included in dependencies |
| Security | Harden rules and key restrictions before production deployment |

---

## Running Checks

```bash
flutter analyze
flutter test
flutter test --coverage
```

Release builds:

```bash
flutter build apk --release
flutter build appbundle --release
flutter build ios --release
flutter build web --release
```

---

## Deployment Checklist

Before release:

- Verify production Firebase project configuration
- Confirm .env values are production-safe
- Restrict API keys for package name, bundle id, and allowed APIs
- Review firestore.rules for least privilege
- Disable or guard any admin-only seed workflows
- Test critical flows: auth, booking, checkout, chat, and notifications

See DEPLOYMENT_CHECKLIST.md for full details.

---

## Documentation

| Document | Purpose |
|----------|---------|
| QUICK_START_GUIDE.md | Fast onboarding for development setup |
| DATA_SEEDING_GUIDE.md | Seeding strategy and safety notes |
| DEPLOYMENT_CHECKLIST.md | Production release readiness checklist |

---

## Contributing

1. Create a feature branch from main.
2. Keep changes focused and test locally.
3. Run analyze and test checks before opening a PR.
4. Update docs when setup or behavior changes.

---

## License

No LICENSE file is currently present in this repository. Add one if you plan public distribution.

---

<div align="center">
  Built with Flutter and Firebase for modern pet care workflows
</div>
