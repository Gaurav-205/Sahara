# Quick Start Guide - Sahara Pet Care

## ⚡ 5-Minute Setup (Development)

### 1. Configure Environment Variables

Edit `.env` file:
```env
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_UPLOAD_PRESET=your_preset
SUPPORT_EMAIL=your@email.com
SUPPORT_PHONE=+1234567890
```

### 2. Set Up Firebase

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase (auto-generates firebase_options.dart)
flutterfire configure
```

### 3. Set Up Google Maps

Get API keys from [Google Cloud Console](https://console.cloud.google.com/):

**Android:** Edit `android/app/src/main/AndroidManifest.xml`
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_ANDROID_KEY" />
```

**iOS:** Edit `ios/Runner/AppDelegate.swift`
```swift
GMSServices.provideAPIKey("YOUR_IOS_KEY")
```

**Web:** Edit `web/index.html`
```html
<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_WEB_KEY"></script>
```

### 4. Run the App

```bash
flutter pub get
flutter run
```

---

## 📋 Configuration Checklist

### Essential (Required to Run)
- [ ] `.env` file configured
- [ ] Firebase project created
- [ ] `flutterfire configure` executed
- [ ] Google Maps API keys added

### Recommended (For Full Functionality)
- [ ] Cloudinary account set up
- [ ] Firestore security rules deployed
- [ ] Test data seeded

### Production Only
- [ ] All API keys rotated
- [ ] API keys restricted
- [ ] Firebase App Check enabled
- [ ] SSL certificates configured

---

## 🔑 Where to Get API Keys

| Service | URL | What You Need |
|---------|-----|---------------|
| **Firebase** | https://console.firebase.google.com/ | Create project, add apps |
| **Google Maps** | https://console.cloud.google.com/ | Enable APIs, create keys |
| **Cloudinary** | https://console.cloudinary.com/ | Cloud name, upload preset |

---

## 🚨 Common Issues & Quick Fixes

### "API key not valid"
```bash
# Make sure you enabled the required APIs in Google Cloud Console
# Go to: APIs & Services → Library
# Enable: Maps SDK for Android/iOS, Maps JavaScript API, Geocoding API
```

### "Permission denied" in Firestore
```bash
# Deploy security rules
firebase deploy --only firestore:rules
```

### Cloudinary upload fails
```env
# Check .env file has correct values
CLOUDINARY_CLOUD_NAME=your_actual_cloud_name  # Not "your_cloud_name_here"
CLOUDINARY_UPLOAD_PRESET=your_actual_preset   # Must be "Unsigned" in Cloudinary
```

### Google Sign-In not working
```bash
# Get SHA-1 fingerprint
cd android && ./gradlew signingReport

# Add SHA-1 to Firebase Console:
# Project Settings → Your apps → Android app → Add fingerprint
```

---

## 📱 Test Your Setup

Run these tests to verify everything works:

1. **Authentication:** Sign up with email
2. **Google Sign-In:** Sign in with Google
3. **Cloudinary:** Upload a pet photo
4. **Google Maps:** View caregivers on map
5. **Firestore:** Create a booking
6. **Messaging:** Send a chat message

---

## 🆘 Need Help?

1. **Detailed Instructions:** See `SETUP_INSTRUCTIONS.md`
2. **Security Guide:** See `SECURITY_CONFIGURATION_GUIDE.md`
3. **Bug Fixes:** See `BUG_FIXES_SUMMARY.md`
4. **Hardcoded Data:** See `HARDCODED_DATA_REMOVAL_SUMMARY.md`

---

## 📞 Quick Commands

```bash
# Check for issues
flutter analyze

# Run app
flutter run

# Build for Android
flutter build apk

# Build for iOS
flutter build ios

# Deploy Firestore rules
firebase deploy --only firestore:rules

# Get SHA-1 (Android)
cd android && ./gradlew signingReport
```

---

**Estimated Time:** 5-10 minutes for basic setup
**Full Setup:** See SETUP_INSTRUCTIONS.md (1-2 hours)
