# 🚀 Sahara Setup Guide

## Quick Start

```bash
cd sahara
flutter pub get
flutter run
```

## Firebase Setup

### 1. Firebase Console Setup (5 minutes)
1. Go to [Firebase Console](https://console.firebase.google.com/project/sahara-a72)
2. Enable Authentication:
   - Email/Password
   - Google Sign-In
3. Create Firestore Database (Start in production mode)
4. Add SHA-1 fingerprint for Google Sign-In (Android)

### 2. Configuration Files
Ensure these files exist:
- `android/app/google-services.json` ✅
- `lib/firebase_options.dart` ✅

### 3. Google Sign-In Setup (Android)
```bash
# Get SHA-1 fingerprint
cd android
./gradlew signingReport

# Add the SHA-1 to Firebase Console:
# Project Settings > Your apps > Android app > Add fingerprint
```

### 4. Enable Production Mode
Edit `lib/services/firestore_service.dart`:
```dart
const bool useMockFirestore = false;  // Set to false for production
```

## Build & Run

### Debug
```bash
flutter run
```

### Release APK
```bash
flutter build apk --release
```

### Release App Bundle
```bash
flutter build appbundle --release
```

## Troubleshooting

### Firebase not initialized
```bash
flutter clean
flutter pub get
flutter run
```

### Google Sign-In fails
- Verify SHA-1 fingerprint added to Firebase
- Download updated google-services.json
- Restart app

### Build errors
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

## Documentation

- **README.md** - Project overview
- **SETUP.md** - This file (setup instructions)
- **FIREBASE_SETUP_GUIDE.md** - Detailed Firebase guide
- **GOOGLE_SIGNIN_SETUP.md** - Google Sign-In configuration
- **UI_UX_DESIGN_SYSTEM.md** - Design system reference

## Support

- Flutter docs: https://docs.flutter.dev
- Firebase docs: https://firebase.google.com/docs
- Project: https://console.firebase.google.com/project/sahara-a72
