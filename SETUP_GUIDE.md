# Sahara Pet Care App - Complete Setup Guide

This guide will walk you through setting up the Sahara Pet Care app from scratch to make it fully functional.

---

## Prerequisites

Before you begin, ensure you have:

- Flutter SDK installed (3.0 or higher)
- Android Studio or VS Code with Flutter extensions
- A Google account for Firebase
- Git installed
- A physical Android device or emulator

---

## Step 1: Firebase Project Setup

### 1.1 Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name: `sahara-pet-care` (or your choice)
4. Disable Google Analytics (optional)
5. Click "Create project"

### 1.2 Add Android App to Firebase

1. In Firebase Console, click the Android icon
2. Enter package name: `com.example.sahara` (must match your app)
3. Enter app nickname: `Sahara Pet Care`
4. Click "Register app"
5. Download `google-services.json`
6. Place it in: `sahara/android/app/google-services.json` (already done if file exists)

### 1.3 Enable Authentication Methods

1. In Firebase Console, go to **Authentication** → **Sign-in method**
2. Enable **Email/Password**:
   - Click on "Email/Password"
   - Toggle "Enable"
   - Click "Save"
3. Enable **Google Sign-In**:
   - Click on "Google"
   - Toggle "Enable"
   - Select support email
   - Click "Save"

### 1.4 Create Firestore Database

1. In Firebase Console, go to **Firestore Database**
2. Click "Create database"
3. Choose **Start in test mode** (we'll secure it later)
4. Select a location (choose closest to your users)
5. Click "Enable"

### 1.5 Set Up Firestore Security Rules

1. In Firestore Database, go to **Rules** tab
2. Replace the rules with:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Users collection
    match /users/{userId} {
      allow read: if true; // Anyone can read user profiles
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Pets collection
    match /pets/{petId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null && request.resource.data.ownerId == request.auth.uid;
      allow update, delete: if request.auth != null && resource.data.ownerId == request.auth.uid;
    }
    
    // Bookings collection
    match /bookings/{bookingId} {
      allow read: if request.auth != null && 
        (resource.data.userId == request.auth.uid || 
         resource.data.caregiverId == request.auth.uid);
      allow create: if request.auth != null && request.resource.data.userId == request.auth.uid;
      allow update: if request.auth != null && 
        (resource.data.userId == request.auth.uid || 
         resource.data.caregiverId == request.auth.uid);
    }
    
    // Service packages collection
    match /service_packages/{packageId} {
      allow read: if true; // Anyone can read packages
      allow write: if request.auth != null; // Only authenticated users can write
    }
    
    // Chats collection
    match /chats/{chatId} {
      allow read, write: if request.auth != null && 
        request.auth.uid in resource.data.participantIds;
      allow create: if request.auth != null && 
        request.auth.uid in request.resource.data.participantIds;
    }
    
    // Messages subcollection
    match /chats/{chatId}/messages/{messageId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
    }
    
    // Reviews collection
    match /reviews/{reviewId} {
      allow read: if true;
      allow create: if request.auth != null && request.resource.data.ownerId == request.auth.uid;
      allow update, delete: if request.auth != null && resource.data.ownerId == request.auth.uid;
    }
  }
}
```

3. Click "Publish"

### 1.6 Set Up Cloudinary (Image Storage)

**Note:** This app uses Cloudinary instead of Firebase Storage for better free tier (25 GB vs 5 GB).

1. Go to https://cloudinary.com/users/register_free
2. Sign up with your email
3. Verify your email and log in
4. On the dashboard, note your **Cloud Name**
5. Go to **Settings** → **Upload** → **Upload presets**
6. Click **Add upload preset**
7. Set:
   - Preset name: `sahara_uploads`
   - Signing Mode: **Unsigned**
   - Access Mode: **Public**
8. Click **Save**
9. Open `sahara/lib/services/cloudinary_service.dart`
10. Update these lines with your credentials:
```dart
static const String _cloudName = 'your_cloud_name';
static const String _uploadPreset = 'sahara_uploads';
```

**See CLOUDINARY_SETUP.md for detailed instructions.**

---

## Step 2: Install Dependencies

1. Open terminal in the `sahara` directory
2. Run:

```bash
flutter    pub get
```

This will install all required packages including:
- Firebase packages (auth, firestore, storage, messaging)
- Google Sign-In
- Image picker
- Provider for state management
- And more...

---

## Step 3: Configure Android Build

### 3.1 Verify google-services.json

Ensure `sahara/android/app/google-services.json` exists and contains your Firebase configuration.

### 3.2 Check Build Configuration

The following should already be configured, but verify:

**File: `sahara/android/build.gradle`**
```gradle
dependencies {
    classpath 'com.google.gms:google-services:4.4.0'
}
```

**File: `sahara/android/app/build.gradle.kts`**
```kotlin
plugins {
    id("com.google.gms.google-services")
}
```

### 3.3 Get SHA-1 Certificate for Google Sign-In

1. Open terminal in `sahara/android` directory
2. Run:

**Windows:**
```bash
./gradlew signingReport
```

**Mac/Linux:**
```bash
./gradlew signingReport
```

3. Copy the SHA-1 fingerprint from the output (look for "debug" variant)
4. In Firebase Console, go to **Project Settings** → **Your apps** → Android app
5. Click "Add fingerprint"
6. Paste the SHA-1 and click "Save"

---

## Step 4: Seed Initial Data

The app needs initial data to function properly. Follow these steps:

### 4.1 Build and Run the App

```bash
flutter run
```

### 4.2 Create Your First Account

1. On the app, click "Sign Up"
2. Enter your details:
   - Name
   - Email
   - Password
   - Phone number
3. Select user type: **Pet Owner** (for testing)
4. Complete signup

### 4.3 Seed Database with Sample Data

1. After logging in, go to **Profile** screen (bottom navigation)
2. Scroll down and tap **"🔧 Seed Database"** button
3. Wait for the seeding process to complete (takes 10-20 seconds)
4. You'll see a success message

This will create:
- 8 professional caregiver profiles
- 12 service packages (4 services × 3 tiers each)

### 4.4 Verify Data

1. Go back to **Home** screen
2. You should now see caregiver profiles
3. Try searching for caregivers
4. Browse service packages

---

## Step 5: Test Core Features

### 5.1 Test Profile Management

1. Go to **Profile** → **Edit Profile**
2. Tap the profile picture to upload a photo
3. Update your details
4. Click "Save Changes"

### 5.2 Test Pet Management

1. Go to **Profile** → **My Pets**
2. Tap the **+** icon to add a pet
3. Fill in pet details and add a photo
4. Save the pet
5. Try editing and viewing your pets

### 5.3 Test Booking Flow

1. Go to **Home** screen
2. Tap a service card (e.g., "Dog Walking")
3. Select a package tier
4. Choose a caregiver
5. Select date and time
6. Add notes (optional)
7. Confirm booking
8. Check **Bookings** tab to see your booking

### 5.4 Test Chat Feature

1. Go to a caregiver's profile
2. Tap **"Message"** button
3. Send a text message
4. Try sending an image
5. Check **Profile** → **Messages** to see all chats

### 5.5 Test Search

1. Go to **Home** screen
2. Tap the search bar
3. Search for caregiver names or services
4. View search results

---

## Step 6: Optional - Push Notifications Setup

### 6.1 Enable Cloud Messaging

1. In Firebase Console, go to **Cloud Messaging**
2. Note: No additional setup needed for basic functionality
3. The app is already configured to receive notifications

### 6.2 Test Notifications (Optional)

1. In Firebase Console, go to **Cloud Messaging** → **Send your first message**
2. Enter notification title and text
3. Click "Send test message"
4. Enter your device's FCM token (check app logs)
5. Send the notification

---

## Step 7: Create Additional Test Accounts

To test the full experience:

### 7.1 Create a Caregiver Account

1. Log out from the app
2. Sign up with a new email
3. Select user type: **Caregiver**
4. Complete profile with:
   - Services offered
   - Hourly rate
   - Years of experience
   - Bio

### 7.2 Test Caregiver Features

1. Log in as caregiver
2. Check **Bookings** to see incoming requests
3. Respond to messages from pet owners
4. Update your profile and services

---

## Troubleshooting

### Issue: "Permission Denied" Error

**Solution:** Check Firestore Security Rules (Step 1.5)

### Issue: Google Sign-In Not Working

**Solution:** 
1. Verify SHA-1 certificate is added to Firebase (Step 3.3)
2. Check `google-services.json` is in the correct location
3. Rebuild the app: `flutter clean && flutter pub get && flutter run`

### Issue: Images Not Uploading

**Solution:** 
1. Check Cloudinary credentials in `cloudinary_service.dart`
2. Verify upload preset is set to "Unsigned"
3. Check internet connection
4. See CLOUDINARY_SETUP.md for troubleshooting

### Issue: No Caregivers Showing

**Solution:** 
1. Make sure you seeded the database (Step 4.3)
2. Check Firestore console to verify data exists
3. Check internet connection

### Issue: Build Errors

**Solution:**
```bash
cd sahara/android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Issue: "App Not Installed" on Android

**Solution:**
1. Uninstall any existing version of the app
2. Rebuild: `flutter run`

---

## Production Deployment Checklist

Before deploying to production:

- [ ] Update Firestore rules to production mode (more restrictive)
- [ ] Update Storage rules to production mode
- [ ] Add proper error tracking (Firebase Crashlytics)
- [ ] Set up proper backup strategy for Firestore
- [ ] Configure app signing for release builds
- [ ] Update app icons and splash screens
- [ ] Test on multiple devices and Android versions
- [ ] Set up CI/CD pipeline
- [ ] Add privacy policy and terms of service
- [ ] Configure Firebase App Check for security
- [ ] Set up Firebase Analytics (optional)
- [ ] Add rate limiting for API calls
- [ ] Test payment integration (if adding payments later)

---

## Important Files Reference

- **Firebase Config:** `sahara/android/app/google-services.json`
- **Cloudinary Config:** `sahara/lib/services/cloudinary_service.dart`
- **Dependencies:** `sahara/pubspec.yaml`
- **Android Config:** `sahara/android/app/build.gradle.kts`
- **Seeder Utility:** `sahara/lib/utils/firebase_seeder.dart`
- **Services:** `sahara/lib/services/`
- **Models:** `sahara/lib/models/`

---

## Support

If you encounter issues:

1. Check the troubleshooting section above
2. Review Firebase Console for errors
3. Check Flutter logs: `flutter logs`
4. Verify all setup steps were completed

---

## Next Steps

Once everything is working:

1. Customize the app with your branding
2. Add more service types and packages
3. Implement payment gateway (Razorpay is already integrated)
4. Add more features like reviews, ratings, favorites
5. Optimize performance and user experience
6. Deploy to Google Play Store

---

**Setup Complete! 🎉**

Your Sahara Pet Care app should now be fully functional with all features working.
