# Security Configuration Guide - Sahara Pet Care

## ⚠️ CRITICAL: Remove All Hardcoded Credentials Before Production

This guide explains how to properly configure all API keys, credentials, and sensitive data for the Sahara Pet Care application.

---

## 🔐 What Has Been Removed

All hardcoded sensitive data has been removed from the codebase:

### ✅ Removed from Code
1. **Google OAuth Client IDs** - Removed from `auth_service.dart`
2. **Hardcoded Phone Numbers** - Removed from `chat_screen.dart`, `tracking_screen.dart`, `bookings_screen.dart`
3. **Dummy User Data** - Replaced with dynamic Firestore queries
4. **Cloudinary Credentials** - Moved to `.env` file (template only)
5. **Contact Information** - Moved to `.env` file (template only)

### ⚠️ Still Present (Requires Action)
These files contain API keys that MUST be rotated before production:

1. **Firebase Configuration** - `lib/firebase_options.dart`
2. **Google Maps API Keys** - Multiple platform files
3. **Firebase Web Config** - `web/firebase-messaging-sw.js`

---

## 📋 Step-by-Step Configuration

### 1. Environment Variables (.env file)

**Location:** `Sahara/.env`

```bash
# Cloudinary Configuration
CLOUDINARY_CLOUD_NAME=your_actual_cloud_name
CLOUDINARY_UPLOAD_PRESET=your_actual_preset

# Contact Information
SUPPORT_EMAIL=your_support@email.com
SUPPORT_PHONE=+1234567890
PRIVACY_EMAIL=your_privacy@email.com
COMPANY_ADDRESS=Your Actual Address
```

**How to get Cloudinary credentials:**
1. Go to https://console.cloudinary.com/
2. Sign up or log in
3. Copy your Cloud Name from the dashboard
4. Create an Upload Preset in Settings → Upload
5. Update `.env` file with your credentials

---

### 2. Firebase Configuration

**⚠️ CRITICAL: Rotate All Firebase API Keys**

#### Current Files with Firebase Keys:
- `lib/firebase_options.dart`
- `web/firebase-messaging-sw.js`
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

#### How to Rotate Firebase Keys:

1. **Go to Firebase Console**
   - Visit https://console.firebase.google.com/
   - Select your project

2. **Regenerate API Keys**
   - Go to Project Settings → General
   - Under "Your apps", click on each platform
   - Click "Regenerate API Key" or create new app

3. **Update Configuration Files**
   ```bash
   # Run FlutterFire CLI to regenerate config
   flutterfire configure
   ```

4. **Restrict API Keys**
   - Go to Google Cloud Console
   - Navigate to APIs & Services → Credentials
   - For each API key, click Edit
   - Add restrictions:
     - **Android**: Restrict to your app's package name and SHA-1
     - **iOS**: Restrict to your app's bundle ID
     - **Web**: Restrict to your domain

---

### 3. Google Maps API Keys

**⚠️ CRITICAL: Rotate All Google Maps API Keys**

#### Current Files with Maps Keys:
- `android/app/src/main/AndroidManifest.xml`
- `ios/Runner/AppDelegate.swift`
- `ios/Runner/Info.plist`
- `web/index.html`

#### How to Rotate Google Maps Keys:

1. **Create New API Keys**
   - Go to https://console.cloud.google.com/
   - Navigate to APIs & Services → Credentials
   - Click "Create Credentials" → "API Key"
   - Create separate keys for Android, iOS, and Web

2. **Enable Required APIs**
   - Maps SDK for Android
   - Maps SDK for iOS
   - Maps JavaScript API
   - Geocoding API
   - Places API

3. **Restrict Each API Key**

   **Android Key:**
   ```
   Application restrictions: Android apps
   Package name: com.example.sahara
   SHA-1 fingerprint: [Your app's SHA-1]
   ```

   **iOS Key:**
   ```
   Application restrictions: iOS apps
   Bundle ID: com.example.sahara
   ```

   **Web Key:**
   ```
   Application restrictions: HTTP referrers
   Website restrictions: yourdomain.com/*
   ```

4. **Update Configuration Files**

   **Android** (`android/app/src/main/AndroidManifest.xml`):
   ```xml
   <meta-data
       android:name="com.google.android.geo.API_KEY"
       android:value="YOUR_NEW_ANDROID_KEY" />
   ```

   **iOS** (`ios/Runner/AppDelegate.swift`):
   ```swift
   GMSServices.provideAPIKey("YOUR_NEW_IOS_KEY")
   ```

   **iOS** (`ios/Runner/Info.plist`):
   ```xml
   <key>com.google.ios.maps.API_KEY</key>
   <string>YOUR_NEW_IOS_KEY</string>
   ```

   **Web** (`web/index.html`):
   ```html
   <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_NEW_WEB_KEY"></script>
   ```

---

### 4. Google Sign-In Configuration

**Current Status:** Hardcoded OAuth client ID has been removed from code.

#### How to Configure:

1. **Android Configuration**
   - OAuth client ID is automatically loaded from `google-services.json`
   - No code changes needed

2. **iOS Configuration**
   - OAuth client ID is automatically loaded from `GoogleService-Info.plist`
   - No code changes needed

3. **Web Configuration**
   - Update `web/index.html` with your Web OAuth client ID
   - Get it from Firebase Console → Authentication → Sign-in method → Google

---

### 5. Firestore Security Rules

**⚠️ CRITICAL: Deploy Proper Security Rules**

Create `firestore.rules` file:

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
    
    // Service packages collection
    match /service_packages/{packageId} {
      allow read: if true; // Public read
      allow write: if false; // Admin only (use Firebase Console)
    }
  }
}
```

Deploy rules:
```bash
firebase deploy --only firestore:rules
```

---

### 6. Firebase App Check

**⚠️ CRITICAL: Enable App Check for Production**

1. **Enable App Check in Firebase Console**
   - Go to Firebase Console → App Check
   - Register your apps

2. **Android: SafetyNet/Play Integrity**
   ```bash
   # Add to android/app/build.gradle
   dependencies {
       implementation 'com.google.firebase:firebase-appcheck-playintegrity:17.0.1'
   }
   ```

3. **iOS: DeviceCheck/App Attest**
   ```bash
   # Add to ios/Podfile
   pod 'FirebaseAppCheck'
   ```

4. **Web: reCAPTCHA**
   - Register your domain in Firebase Console
   - Add reCAPTCHA site key to web app

---

## 🔒 Additional Security Measures

### 1. Remove .env from Version Control

Add to `.gitignore`:
```
# Environment variables
.env
.env.local
.env.production

# Firebase config (if regenerated)
google-services.json
GoogleService-Info.plist
firebase-messaging-sw.js
```

### 2. Use Environment-Specific Configurations

Create separate configurations for development and production:
- `.env.development`
- `.env.production`

### 3. Implement Backend Server

For production, implement a backend server for:
- Payment processing
- Sensitive operations
- Admin functions
- Image deletion from Cloudinary

### 4. Enable Firebase Authentication Security

1. **Email Enumeration Protection**
   - Go to Firebase Console → Authentication → Settings
   - Enable "Email enumeration protection"

2. **Password Policy**
   - Set minimum password length
   - Require uppercase, lowercase, numbers, special characters

3. **Rate Limiting**
   - Enable to prevent brute force attacks

---

## ✅ Pre-Production Checklist

Before deploying to production, ensure:

- [ ] All API keys rotated (Firebase, Google Maps, Cloudinary)
- [ ] API keys restricted to specific apps/domains
- [ ] `.env` file not in version control
- [ ] Firestore security rules deployed
- [ ] Firebase App Check enabled
- [ ] Google Sign-In configured for production
- [ ] All hardcoded data removed from code
- [ ] Backend server implemented for sensitive operations
- [ ] SSL/TLS certificates configured
- [ ] Error logging and monitoring set up
- [ ] Privacy policy and terms of service updated
- [ ] GDPR/data protection compliance verified

---

## 📞 Support

If you need help with security configuration:
1. Check Firebase documentation: https://firebase.google.com/docs
2. Check Google Cloud documentation: https://cloud.google.com/docs
3. Review Flutter security best practices: https://flutter.dev/security

---

## ⚠️ IMPORTANT NOTES

1. **Never commit API keys to version control**
2. **Rotate all keys before production deployment**
3. **Use separate Firebase projects for dev/staging/production**
4. **Monitor API usage and set up billing alerts**
5. **Regularly audit security rules and permissions**
6. **Keep all dependencies up to date**
7. **Implement proper error handling to avoid leaking sensitive info**

---

**Last Updated:** March 12, 2026
**Status:** ⚠️ Requires Configuration Before Production
