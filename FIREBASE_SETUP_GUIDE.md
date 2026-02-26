# Firebase Production Setup Guide for Sahara

## ✅ Current Status

Your Firebase project is already configured:
- **Project ID**: sahara-a72
- **Package Name**: com.example.sahara
- **Firebase Config**: ✅ Complete (Android, iOS, Web, Windows, macOS)
- **google-services.json**: ✅ Present

## 🔧 Required Setup Steps

### Step 1: Enable Firebase Authentication

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: **sahara-a72**
3. Click **Authentication** in the left menu
4. Click **Get Started** (if not already enabled)
5. Go to **Sign-in method** tab
6. Enable the following providers:

#### A. Email/Password Authentication
- Click on **Email/Password**
- Toggle **Enable** to ON
- Click **Save**

#### B. Google Sign-In (Optional but Recommended)
- Click on **Google**
- Toggle **Enable** to ON
- Enter support email (your email)
- Click **Save**

### Step 2: Enable Cloud Firestore

1. In Firebase Console, click **Firestore Database**
2. Click **Create database**
3. Choose **Start in test mode** (for development)
4. Select a location (choose closest to your users)
5. Click **Enable**

**Security Rules for Development:**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow authenticated users to read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Allow authenticated users to read all caregivers
    match /users/{userId} {
      allow read: if request.auth != null;
    }
    
    // Bookings
    match /bookings/{bookingId} {
      allow read, write: if request.auth != null;
    }
    
    // Services
    match /services/{serviceId} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

### Step 3: Configure Google Sign-In for Android

#### A. Get SHA-1 Fingerprint

**For Debug Build:**
```bash
cd android
./gradlew signingReport
```

Or on Windows:
```bash
cd android
gradlew signingReport
```

Look for **SHA-1** under `Variant: debug` and copy it.

**Alternative Method (using keytool):**
```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

#### B. Add SHA-1 to Firebase

1. Go to Firebase Console → Project Settings
2. Scroll down to **Your apps** section
3. Click on your Android app
4. Click **Add fingerprint**
5. Paste your SHA-1 fingerprint
6. Click **Save**

#### C. Download Updated google-services.json

1. After adding SHA-1, download the new `google-services.json`
2. Replace the file at: `android/app/google-services.json`

### Step 4: Test the Setup

Run the app:
```bash
flutter clean
flutter pub get
flutter run
```

#### Test Authentication:

**1. Email/Password Sign Up:**
- Open the app
- Go to Sign Up
- Enter: test@example.com / password123
- Should create account successfully

**2. Email/Password Sign In:**
- Use the credentials you just created
- Should sign in successfully

**3. Google Sign-In:**
- Click "Google" button
- Select your Google account
- Should sign in successfully

**4. Password Reset:**
- Go to "Forgot Password"
- Enter your email
- Check your email for reset link

### Step 5: Verify in Firebase Console

After testing, verify in Firebase Console:

1. **Authentication → Users**: Should see your test users
2. **Firestore Database → Data**: Should see user documents

## 🔒 Production Security Rules

Before going to production, update Firestore rules:

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
      allow update, delete: if isOwner(userId);
    }
    
    // Bookings collection
    match /bookings/{bookingId} {
      allow read: if isSignedIn() && (
        resource.data.userId == request.auth.uid ||
        resource.data.caregiverId == request.auth.uid
      );
      allow create: if isSignedIn();
      allow update: if isSignedIn() && (
        resource.data.userId == request.auth.uid ||
        resource.data.caregiverId == request.auth.uid
      );
      allow delete: if isSignedIn() && resource.data.userId == request.auth.uid;
    }
    
    // Services collection
    match /services/{serviceId} {
      allow read: if true;
      allow write: if isSignedIn();
    }
    
    // Service packages
    match /service_packages/{packageId} {
      allow read: if true;
      allow write: if isSignedIn();
    }
  }
}
```

## 📱 Platform-Specific Setup

### Android (Already Configured)
- ✅ google-services.json present
- ✅ Firebase SDK configured
- ⚠️ Need to add SHA-1 for Google Sign-In

### iOS (If needed)
1. Download `GoogleService-Info.plist` from Firebase Console
2. Add to `ios/Runner/` directory
3. Open `ios/Runner.xcworkspace` in Xcode
4. Add `GoogleService-Info.plist` to project

### Web (Already Configured)
- ✅ Firebase config in firebase_options.dart
- Works out of the box

## 🐛 Troubleshooting

### Issue: "Firebase not initialized"
**Solution:** Already handled in main.dart with try-catch

### Issue: "Google Sign-In fails"
**Solution:** 
1. Verify SHA-1 is added to Firebase
2. Download new google-services.json
3. Run `flutter clean && flutter pub get`

### Issue: "Permission denied" in Firestore
**Solution:** Update Firestore security rules (see Step 2)

### Issue: "Email already in use"
**Solution:** This is expected - use different email or sign in

## 🎯 Quick Start Commands

```bash
# Clean and rebuild
flutter clean
flutter pub get

# Run on Android
flutter run

# Run on specific device
flutter devices
flutter run -d <device-id>

# Build release APK
flutter build apk --release

# Build release App Bundle
flutter build appbundle --release
```

## 📊 Firebase Console Links

- **Console**: https://console.firebase.google.com/project/sahara-a72
- **Authentication**: https://console.firebase.google.com/project/sahara-a72/authentication
- **Firestore**: https://console.firebase.google.com/project/sahara-a72/firestore
- **Project Settings**: https://console.firebase.google.com/project/sahara-a72/settings/general

## ✅ Checklist

- [ ] Enable Email/Password authentication in Firebase Console
- [ ] Enable Google Sign-In in Firebase Console
- [ ] Create Firestore database
- [ ] Add Firestore security rules
- [ ] Get SHA-1 fingerprint
- [ ] Add SHA-1 to Firebase Console
- [ ] Download updated google-services.json (if needed)
- [ ] Test email/password sign up
- [ ] Test email/password sign in
- [ ] Test Google Sign-In
- [ ] Test password reset
- [ ] Verify users in Firebase Console
- [ ] Verify data in Firestore

## 🚀 You're Ready!

Once you complete the checklist above, your app will be fully functional with Firebase backend!

**Current Mode**: Production (useMockAuth = false)
**Firebase Project**: sahara-a72
**Status**: Ready for setup ✅
