# Configuration Checklist - Sahara Pet Care

Use this checklist to track your configuration progress.

---

## 📋 Pre-Setup

- [ ] Flutter SDK installed (3.0+)
- [ ] Android Studio / Xcode installed (for mobile development)
- [ ] Firebase account created
- [ ] Google Cloud Console access
- [ ] Cloudinary account created
- [ ] Text editor ready (VS Code recommended)

---

## 🔧 Step 1: Environment Variables

### .env File Configuration

- [ ] Copied `.env.example` to `.env`
- [ ] Updated `CLOUDINARY_CLOUD_NAME` with actual value
- [ ] Updated `CLOUDINARY_UPLOAD_PRESET` with actual value
- [ ] Updated `SUPPORT_EMAIL` with your email
- [ ] Updated `SUPPORT_PHONE` with your phone
- [ ] Updated `PRIVACY_EMAIL` with your email
- [ ] Updated `COMPANY_ADDRESS` with your address
- [ ] Verified `.env` is in `.gitignore`

**Current Status:** `.env` file is ⬜ Not Started / ⬜ In Progress / ⬜ Complete

---

## 🔥 Step 2: Firebase Configuration

### Firebase Project Setup

- [ ] Created Firebase project at https://console.firebase.google.com/
- [ ] Project name: ___________________________
- [ ] Enabled Email/Password authentication
- [ ] Enabled Google authentication
- [ ] Created Firestore database
- [ ] Selected Firestore location: ___________________________

### Android App Configuration

- [ ] Added Android app to Firebase
- [ ] Package name: `com.example.sahara` (or custom: _______________)
- [ ] Downloaded `google-services.json`
- [ ] Placed in `android/app/google-services.json`
- [ ] Got SHA-1 fingerprint: ___________________________
- [ ] Added SHA-1 to Firebase Console

### iOS App Configuration

- [ ] Added iOS app to Firebase
- [ ] Bundle ID: `com.example.sahara` (or custom: _______________)
- [ ] Downloaded `GoogleService-Info.plist`
- [ ] Placed in `ios/Runner/GoogleService-Info.plist`

### Web App Configuration

- [ ] Added Web app to Firebase
- [ ] App nickname: ___________________________
- [ ] Copied Firebase config

### FlutterFire CLI

- [ ] Installed FlutterFire CLI: `dart pub global activate flutterfire_cli`
- [ ] Ran `flutterfire configure`
- [ ] Verified `lib/firebase_options.dart` was generated

**Current Status:** Firebase is ⬜ Not Started / ⬜ In Progress / ⬜ Complete

---

## 🗺️ Step 3: Google Maps Configuration

### Enable APIs in Google Cloud Console

- [ ] Opened https://console.cloud.google.com/
- [ ] Selected Firebase project
- [ ] Enabled Maps SDK for Android
- [ ] Enabled Maps SDK for iOS
- [ ] Enabled Maps JavaScript API
- [ ] Enabled Geocoding API
- [ ] Enabled Places API

### Create API Keys

- [ ] Created Android API key
  - Key: ___________________________
  - Restricted to Android apps
  - Package name added: `com.example.sahara`
  - SHA-1 added: ___________________________
  
- [ ] Created iOS API key
  - Key: ___________________________
  - Restricted to iOS apps
  - Bundle ID added: `com.example.sahara`
  
- [ ] Created Web API key
  - Key: ___________________________
  - Restricted to HTTP referrers
  - Domain added: ___________________________

### Update Configuration Files

- [ ] Updated `android/app/src/main/AndroidManifest.xml` with Android key
- [ ] Updated `ios/Runner/AppDelegate.swift` with iOS key
- [ ] Updated `ios/Runner/Info.plist` with iOS key
- [ ] Updated `web/index.html` with Web key

**Current Status:** Google Maps is ⬜ Not Started / ⬜ In Progress / ⬜ Complete

---

## 🌐 Step 4: Firebase Web Configuration

- [ ] Updated `web/firebase-messaging-sw.js` with Web config
- [ ] Verified all Firebase Web credentials are correct

**Current Status:** Firebase Web is ⬜ Not Started / ⬜ In Progress / ⬜ Complete

---

## 🔒 Step 5: Firestore Security Rules

- [ ] Created `firestore.rules` file in project root
- [ ] Copied security rules from SETUP_INSTRUCTIONS.md
- [ ] Installed Firebase CLI: `npm install -g firebase-tools`
- [ ] Logged in: `firebase login`
- [ ] Initialized: `firebase init firestore`
- [ ] Deployed rules: `firebase deploy --only firestore:rules`

**Current Status:** Security Rules are ⬜ Not Started / ⬜ In Progress / ⬜ Complete

---

## 🌱 Step 6: Seed Test Data (Development Only)

- [ ] Ran `flutter pub get`
- [ ] Ran the app
- [ ] Navigated to Profile → Admin Seed Screen
- [ ] Clicked "Seed All Data"
- [ ] Verified data in Firestore Console

**Current Status:** Test Data is ⬜ Not Started / ⬜ In Progress / ⬜ Complete

---

## ✅ Step 7: Testing

### Basic Tests

- [ ] App builds successfully: `flutter build apk` (or `flutter build ios`)
- [ ] No analyzer warnings: `flutter analyze`
- [ ] App runs on device/emulator

### Feature Tests

- [ ] Sign up with email/password works
- [ ] Sign in with email/password works
- [ ] Google Sign-In works
- [ ] Can view caregivers list
- [ ] Map shows caregiver locations
- [ ] Can upload pet photo (Cloudinary)
- [ ] Can create booking
- [ ] Can send chat message
- [ ] Can make phone call
- [ ] Push notifications work

**Current Status:** Testing is ⬜ Not Started / ⬜ In Progress / ⬜ Complete

---

## 🚀 Step 8: Production Preparation (Optional)

### Security Hardening

- [ ] Created separate Firebase project for production
- [ ] Rotated all API keys
- [ ] Restricted all API keys properly
- [ ] Enabled Firebase App Check
- [ ] Configured SSL/TLS certificates
- [ ] Set up error logging (Crashlytics)
- [ ] Configured analytics

### Deployment

- [ ] Built release APK/IPA
- [ ] Tested on physical devices
- [ ] Submitted to app stores
- [ ] Configured web hosting (if applicable)

**Current Status:** Production is ⬜ Not Started / ⬜ In Progress / ⬜ Complete

---

## 📊 Overall Progress

```
Environment Variables:  ⬜⬜⬜⬜⬜⬜⬜⬜ 0/8
Firebase Setup:         ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ 0/12
Google Maps:            ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ 0/11
Firebase Web:           ⬜⬜ 0/2
Security Rules:         ⬜⬜⬜⬜⬜⬜ 0/6
Test Data:              ⬜⬜⬜⬜⬜ 0/5
Testing:                ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ 0/13
Production:             ⬜⬜⬜⬜⬜⬜⬜⬜ 0/8

Total Progress: 0/65 (0%)
```

---

## 🎯 Minimum Viable Configuration

To run the app in development, you MUST complete:

1. ✅ Environment Variables (Step 1)
2. ✅ Firebase Configuration (Step 2)
3. ✅ Google Maps Configuration (Step 3)
4. ✅ Basic Testing (Step 7 - first 3 tests)

**Minimum items:** 33/65 (51%)

---

## 📝 Notes & Issues

Use this space to track any issues or notes during setup:

```
Date: ___________
Issue: 
Solution: 

Date: ___________
Issue: 
Solution: 

Date: ___________
Issue: 
Solution: 
```

---

## 🆘 Quick Help

| Issue | Solution |
|-------|----------|
| Can't find .env file | It's in the root: `Sahara/.env` |
| FlutterFire not working | Run: `dart pub global activate flutterfire_cli` |
| SHA-1 not working | Use debug SHA-1 for development |
| Maps not showing | Check API key restrictions |
| Firestore permission denied | Deploy security rules |

---

## ✅ Sign-Off

Configuration completed by: ___________________________

Date: ___________________________

Verified by: ___________________________

Date: ___________________________

---

**Print this checklist and check off items as you complete them!**
