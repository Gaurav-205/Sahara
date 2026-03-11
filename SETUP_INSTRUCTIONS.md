# Complete Setup Instructions - Sahara Pet Care

## 🚀 Quick Start Guide

Follow these steps to properly configure all API keys and credentials for the Sahara Pet Care application.

---

## Prerequisites

Before you begin, make sure you have:
- [ ] Flutter SDK installed (3.0+)
- [ ] Firebase account (free tier is fine)
- [ ] Google Cloud Console account
- [ ] Cloudinary account (free tier is fine)
- [ ] Text editor (VS Code recommended)

---

## Step 1: Environment Variables (.env file)

### 1.1 Configure Cloudinary

**Get your credentials:**
1. Go to https://console.cloudinary.com/
2. Sign up or log in
3. On the dashboard, you'll see:
   - **Cloud Name** (e.g., "dxyz123abc")
   - **API Key** (you don't need this for client-side)
   - **API Secret** (you don't need this for client-side)

4. Create an Upload Preset:
   - Go to Settings → Upload
   - Scroll to "Upload presets"
   - Click "Add upload preset"
   - Set Signing Mode to "Unsigned"
   - Name it (e.g., "sahara_uploads")
   - Save

**Update your .env file:**
```env
CLOUDINARY_CLOUD_NAME=your_actual_cloud_name
CLOUDINARY_UPLOAD_PRESET=your_actual_preset_name
```

### 1.2 Configure Contact Information

**Update your .env file:**
```env
SUPPORT_EMAIL=your_support@email.com
SUPPORT_PHONE=+1234567890
PRIVACY_EMAIL=your_privacy@email.com
COMPANY_ADDRESS=Your Company Address, City, State, Country
```

**Example:**
```env
SUPPORT_EMAIL=support@mypetcare.com
SUPPORT_PHONE=+1-555-123-4567
PRIVACY_EMAIL=privacy@mypetcare.com
COMPANY_ADDRESS=123 Main St, San Francisco, CA 94102, USA
```

---

## Step 2: Firebase Configuration

### 2.1 Create Firebase Project

1. **Go to Firebase Console:**
   - Visit https://console.firebase.google.com/
   - Click "Add project"
   - Enter project name (e.g., "sahara-pet-care-prod")
   - Disable Google Analytics (optional)
   - Click "Create project"

2. **Enable Authentication:**
   - Go to Build → Authentication
   - Click "Get started"
   - Enable "Email/Password"
   - Enable "Google" sign-in
   - Save

3. **Create Firestore Database:**
   - Go to Build → Firestore Database
   - Click "Create database"
   - Choose "Start in production mode"
   - Select location (choose closest to your users)
   - Click "Enable"

### 2.2 Add Your Apps to Firebase

#### For Android:

1. Click "Add app" → Android icon
2. Enter package name: `com.example.sahara` (or your custom package)
3. Download `google-services.json`
4. Place it in: `android/app/google-services.json`
5. Get SHA-1 fingerprint:
   ```bash
   # For debug
   cd android
   ./gradlew signingReport
   
   # Look for SHA1 under "Variant: debug"
   # Copy the SHA1 value
   ```
6. Add SHA-1 to Firebase Console
7. Click "Next" and "Continue to console"

#### For iOS:

1. Click "Add app" → iOS icon
2. Enter bundle ID: `com.example.sahara` (or your custom bundle)
3. Download `GoogleService-Info.plist`
4. Place it in: `ios/Runner/GoogleService-Info.plist`
5. Click "Next" and "Continue to console"

#### For Web:

1. Click "Add app" → Web icon
2. Enter app nickname: "Sahara Web"
3. Check "Also set up Firebase Hosting"
4. Click "Register app"
5. Copy the Firebase config (you'll need this later)

### 2.3 Regenerate Firebase Options

**Option A: Using FlutterFire CLI (Recommended)**

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

This will:
- Detect your Firebase project
- Generate `lib/firebase_options.dart` with new keys
- Configure all platforms automatically

**Option B: Manual Configuration**

If you prefer manual setup, update `lib/firebase_options.dart` with values from Firebase Console.

---

## Step 3: Google Maps API Configuration

### 3.1 Enable Google Maps APIs

1. **Go to Google Cloud Console:**
   - Visit https://console.cloud.google.com/
   - Select your Firebase project (it's automatically created)

2. **Enable Required APIs:**
   - Go to "APIs & Services" → "Library"
   - Search and enable each:
     - ✅ Maps SDK for Android
     - ✅ Maps SDK for iOS
     - ✅ Maps JavaScript API
     - ✅ Geocoding API
     - ✅ Places API

### 3.2 Create API Keys

1. **Go to Credentials:**
   - Navigate to "APIs & Services" → "Credentials"
   - Click "Create Credentials" → "API Key"

2. **Create 3 Separate Keys:**
   - Android Key
   - iOS Key
   - Web Key

### 3.3 Restrict API Keys (IMPORTANT!)

#### Android Key:

1. Click on the Android key
2. Under "Application restrictions":
   - Select "Android apps"
   - Click "Add an item"
   - Package name: `com.example.sahara`
   - SHA-1: (paste from Step 2.2)
3. Under "API restrictions":
   - Select "Restrict key"
   - Check: Maps SDK for Android, Geocoding API, Places API
4. Save

#### iOS Key:

1. Click on the iOS key
2. Under "Application restrictions":
   - Select "iOS apps"
   - Click "Add an item"
   - Bundle ID: `com.example.sahara`
3. Under "API restrictions":
   - Select "Restrict key"
   - Check: Maps SDK for iOS, Geocoding API, Places API
4. Save

#### Web Key:

1. Click on the Web key
2. Under "Application restrictions":
   - Select "HTTP referrers (web sites)"
   - Click "Add an item"
   - Add: `localhost:*` (for development)
   - Add: `yourdomain.com/*` (for production)
3. Under "API restrictions":
   - Select "Restrict key"
   - Check: Maps JavaScript API, Geocoding API, Places API
4. Save

### 3.4 Update Configuration Files

#### Android (`android/app/src/main/AndroidManifest.xml`):

Find this line:
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="AIzaSyDvezV3O3RiQ_L76KYMlWyeRUpafqb8JoY" />
```

Replace with:
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_ANDROID_API_KEY_HERE" />
```

#### iOS (`ios/Runner/AppDelegate.swift`):

Find this line:
```swift
GMSServices.provideAPIKey("AIzaSyDvezV3O3RiQ_L76KYMlWyeRUpafqb8JoY")
```

Replace with:
```swift
GMSServices.provideAPIKey("YOUR_IOS_API_KEY_HERE")
```

#### iOS (`ios/Runner/Info.plist`):

Find this section:
```xml
<key>com.google.ios.maps.API_KEY</key>
<string>AIzaSyDvezV3O3RiQ_L76KYMlWyeRUpafqb8JoY</string>
```

Replace with:
```xml
<key>com.google.ios.maps.API_KEY</key>
<string>YOUR_IOS_API_KEY_HERE</string>
```

#### Web (`web/index.html`):

Find this line:
```html
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDvezV3O3RiQ_L76KYMlWyeRUpafqb8JoY"></script>
```

Replace with:
```html
<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_WEB_API_KEY_HERE"></script>
```

---

## Step 4: Firebase Web Configuration

### 4.1 Update Firebase Messaging Service Worker

**File:** `web/firebase-messaging-sw.js`

Replace the entire config with your Web app config from Firebase Console:

```javascript
importScripts('https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js');

// Your web app's Firebase configuration
firebase.initializeApp({
  apiKey: "YOUR_WEB_API_KEY",
  authDomain: "your-project.firebaseapp.com",
  projectId: "your-project-id",
  storageBucket: "your-project.firebasestorage.app",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abcdef123456"
});

const messaging = firebase.messaging();
```

---

## Step 5: Deploy Firestore Security Rules

### 5.1 Create firestore.rules File

Create a file named `firestore.rules` in your project root:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Helper functions
    function isSignedIn() {
      return request.auth != null;
    }
    
    function isOwner(userId) {
      return isSignedIn() && request.auth.uid == userId;
    }
    
    // Users collection
    match /users/{userId} {
      allow read: if isSignedIn();
      allow create: if isSignedIn() && isOwner(userId);
      allow update: if isOwner(userId);
      allow delete: if isOwner(userId);
      
      // User's pets subcollection
      match /pets/{petId} {
        allow read: if isSignedIn();
        allow write: if isOwner(userId);
      }
    }
    
    // Bookings collection
    match /bookings/{bookingId} {
      allow read: if isSignedIn() && (
        resource.data.ownerId == request.auth.uid ||
        resource.data.caregiverId == request.auth.uid
      );
      allow create: if isSignedIn();
      allow update: if isSignedIn() && (
        resource.data.ownerId == request.auth.uid ||
        resource.data.caregiverId == request.auth.uid
      );
    }
    
    // Chats collection
    match /chats/{chatId} {
      allow read: if isSignedIn() && 
        request.auth.uid in resource.data.participants;
      allow create: if isSignedIn();
      allow update: if isSignedIn() && 
        request.auth.uid in resource.data.participants;
      
      // Messages subcollection
      match /messages/{messageId} {
        allow read: if isSignedIn() && 
          request.auth.uid in get(/databases/$(database)/documents/chats/$(chatId)).data.participants;
        allow create: if isSignedIn();
      }
    }
    
    // Reviews collection
    match /reviews/{reviewId} {
      allow read: if isSignedIn();
      allow create: if isSignedIn();
      allow update: if isOwner(resource.data.ownerId);
      allow delete: if isOwner(resource.data.ownerId);
    }
    
    // Service packages collection (read-only for users)
    match /service_packages/{packageId} {
      allow read: if true;
      allow write: if false; // Admin only via Firebase Console
    }
  }
}
```

### 5.2 Deploy Rules

```bash
# Install Firebase CLI if not already installed
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase in your project
firebase init firestore

# Deploy rules
firebase deploy --only firestore:rules
```

---

## Step 6: Seed Test Data (Development Only)

### 6.1 Run the Seeder

In your app, navigate to Profile → Admin Seed Screen, or run:

```dart
import 'package:sahara/utils/firebase_seeder_2026_india.dart';

final seeder = FirebaseSeeder2026India();
await seeder.seedAll();
```

This will populate your Firestore with:
- 15 sample caregivers
- 30 service packages
- Sample reviews

---

## Step 7: Test Your Configuration

### 7.1 Run the App

```bash
# Get dependencies
flutter pub get

# Run on your device
flutter run
```

### 7.2 Test Each Feature

- [ ] Sign up with email/password
- [ ] Sign in with Google
- [ ] Upload a pet photo (tests Cloudinary)
- [ ] View caregivers on map (tests Google Maps)
- [ ] Create a booking
- [ ] Send a message
- [ ] Make a phone call (tests dynamic phone fetching)

---

## Step 8: Enable Firebase App Check (Production)

### 8.1 Enable in Firebase Console

1. Go to Build → App Check
2. Click "Get started"
3. Register each app:
   - **Android:** Use Play Integrity
   - **iOS:** Use App Attest
   - **Web:** Use reCAPTCHA v3

### 8.2 Add to Your App

**Android** (`android/app/build.gradle`):
```gradle
dependencies {
    implementation 'com.google.firebase:firebase-appcheck-playintegrity:17.0.1'
}
```

**iOS** (`ios/Podfile`):
```ruby
pod 'FirebaseAppCheck'
```

**Dart** (`lib/main.dart`):
```dart
import 'package:firebase_app_check/firebase_app_check.dart';

await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

// Activate App Check
await FirebaseAppCheck.instance.activate(
  androidProvider: AndroidProvider.playIntegrity,
  appleProvider: AppleProvider.appAttest,
);
```

---

## Troubleshooting

### Issue: "API key not valid"
**Solution:** Make sure you've enabled the required APIs in Google Cloud Console and restricted the keys properly.

### Issue: "Permission denied" in Firestore
**Solution:** Deploy your Firestore security rules using `firebase deploy --only firestore:rules`

### Issue: Cloudinary upload fails
**Solution:** 
1. Check your Cloud Name and Upload Preset in .env
2. Make sure Upload Preset is set to "Unsigned"
3. Check Cloudinary dashboard for error logs

### Issue: Google Sign-In not working
**Solution:**
1. Make sure you've added SHA-1 fingerprint to Firebase
2. Enable Google sign-in in Firebase Console
3. Check that google-services.json is in the correct location

### Issue: Maps not showing
**Solution:**
1. Enable Maps SDK in Google Cloud Console
2. Check that API key is correctly placed in manifest/plist/html
3. Make sure API key restrictions allow your app

---

## Security Checklist

Before deploying to production:

- [ ] All API keys rotated from demo keys
- [ ] API keys restricted to specific apps/domains
- [ ] .env file not in version control
- [ ] Firestore security rules deployed
- [ ] Firebase App Check enabled
- [ ] Google Sign-In configured for production domain
- [ ] SSL/TLS certificates configured
- [ ] Error logging set up (Firebase Crashlytics)
- [ ] Analytics configured (optional)
- [ ] Privacy policy and terms of service updated

---

## Quick Reference

### File Locations

```
Sahara/
├── .env                                    # Environment variables
├── firestore.rules                         # Firestore security rules
├── lib/
│   ├── firebase_options.dart              # Firebase config (auto-generated)
│   └── config/app_config.dart             # App configuration
├── android/
│   └── app/
│       ├── google-services.json           # Firebase Android config
│       └── src/main/AndroidManifest.xml   # Google Maps Android key
├── ios/
│   └── Runner/
│       ├── GoogleService-Info.plist       # Firebase iOS config
│       ├── Info.plist                     # Google Maps iOS key
│       └── AppDelegate.swift              # Google Maps iOS initialization
└── web/
    ├── index.html                         # Google Maps Web key
    └── firebase-messaging-sw.js           # Firebase Web config
```

### Command Reference

```bash
# Flutter commands
flutter pub get                    # Install dependencies
flutter run                        # Run app
flutter build apk                  # Build Android APK
flutter build ios                  # Build iOS app
flutter analyze                    # Check for issues

# Firebase commands
firebase login                     # Login to Firebase
firebase init                      # Initialize Firebase
firebase deploy --only firestore   # Deploy Firestore rules
flutterfire configure             # Configure Firebase for Flutter

# Android commands
cd android && ./gradlew signingReport  # Get SHA-1 fingerprint
```

---

## Support

If you encounter issues:

1. **Check the logs:**
   ```bash
   flutter run --verbose
   ```

2. **Check Firebase Console:**
   - Authentication logs
   - Firestore usage
   - Crashlytics (if enabled)

3. **Check Google Cloud Console:**
   - API usage
   - Quota limits
   - Error logs

4. **Documentation:**
   - Firebase: https://firebase.google.com/docs
   - Google Maps: https://developers.google.com/maps/documentation
   - Flutter: https://flutter.dev/docs

---

## Estimated Setup Time

- **Basic Setup (Steps 1-3):** 30-45 minutes
- **Complete Setup (All steps):** 1-2 hours
- **With testing:** 2-3 hours

---

**Last Updated:** March 12, 2026
**Version:** 1.0.0
**Status:** ✅ Ready for Configuration
