# Firebase Setup - Step by Step

## 🎯 Your SHA-1 Fingerprint

```
ED:02:3C:0B:BC:12:3D:83:BD:DF:56:0F:E0:AD:16:5C:14:EF:63:2B
```

---

## 📋 Complete Firebase Setup Checklist

### ✅ Step 1: Create Firebase Project (5 minutes)

1. Go to https://console.firebase.google.com/
2. Click "Add project"
3. Enter project name: `sahara-pet-care` (or your choice)
4. Click "Continue"
5. Disable Google Analytics (optional)
6. Click "Create project"
7. Wait for project creation
8. Click "Continue"

**Status:** ⬜ Not Started / ⬜ Complete

---

### ✅ Step 2: Add Android App (10 minutes)

1. In Firebase Console, click "Add app" → Android icon
2. Enter Android package name: `com.example.sahara`
3. Enter app nickname: `Sahara Android` (optional)
4. Click "Register app"

5. **Add SHA-1 Fingerprint:**
   - Paste this SHA-1:
     ```
     ED:02:3C:0B:BC:12:3D:83:BD:DF:56:0F:E0:AD:16:5C:14:EF:63:2B
     ```
   - Click "Register app"

6. **Download google-services.json:**
   - Click "Download google-services.json"
   - Save it to: `Sahara/android/app/google-services.json`
   - ⚠️ Make sure it's in the `app` folder, not `android` folder!

7. Click "Next" → "Next" → "Continue to console"

**Status:** ⬜ Not Started / ⬜ Complete

---

### ✅ Step 3: Enable Authentication (5 minutes)

1. In Firebase Console, go to "Build" → "Authentication"
2. Click "Get started"
3. Click "Sign-in method" tab

4. **Enable Email/Password:**
   - Click "Email/Password"
   - Toggle "Enable"
   - Click "Save"

5. **Enable Google Sign-In:**
   - Click "Google"
   - Toggle "Enable"
   - Enter support email: (your email)
   - Click "Save"

**Status:** ⬜ Not Started / ⬜ Complete

---

### ✅ Step 4: Create Firestore Database (5 minutes)

1. In Firebase Console, go to "Build" → "Firestore Database"
2. Click "Create database"
3. Select "Start in production mode"
4. Click "Next"
5. Choose location: (select closest to your users)
   - Recommended: `us-central1` or `asia-south1` (for India)
6. Click "Enable"
7. Wait for database creation

**Status:** ⬜ Not Started / ⬜ Complete

---

### ✅ Step 5: Add iOS App (Optional - 5 minutes)

1. In Firebase Console, click "Add app" → iOS icon
2. Enter iOS bundle ID: `com.example.sahara`
3. Enter app nickname: `Sahara iOS` (optional)
4. Click "Register app"
5. Download `GoogleService-Info.plist`
6. Place it in: `Sahara/ios/Runner/GoogleService-Info.plist`
7. Click "Next" → "Next" → "Continue to console"

**Status:** ⬜ Not Started / ⬜ Skip / ⬜ Complete

---

### ✅ Step 6: Add Web App (Optional - 5 minutes)

1. In Firebase Console, click "Add app" → Web icon
2. Enter app nickname: `Sahara Web`
3. Check "Also set up Firebase Hosting" (optional)
4. Click "Register app"
5. Copy the Firebase configuration (you'll need this later)
6. Click "Continue to console"

**Status:** ⬜ Not Started / ⬜ Skip / ⬜ Complete

---

### ✅ Step 7: Run FlutterFire Configure (2 minutes)

This will automatically generate `firebase_options.dart`:

```bash
# Install FlutterFire CLI (one time only)
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

**What it does:**
- Detects your Firebase project
- Generates `lib/firebase_options.dart`
- Configures all platforms automatically

**Status:** ⬜ Not Started / ⬜ Complete

---

### ✅ Step 8: Deploy Firestore Security Rules (5 minutes)

1. **Create firestore.rules file** in project root:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    function isSignedIn() {
      return request.auth != null;
    }
    
    function isOwner(userId) {
      return isSignedIn() && request.auth.uid == userId;
    }
    
    match /users/{userId} {
      allow read: if isSignedIn();
      allow create: if isSignedIn() && isOwner(userId);
      allow update: if isOwner(userId);
      allow delete: if isOwner(userId);
      
      match /pets/{petId} {
        allow read: if isSignedIn();
        allow write: if isOwner(userId);
      }
    }
    
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
    
    match /chats/{chatId} {
      allow read: if isSignedIn() && 
        request.auth.uid in resource.data.participants;
      allow create: if isSignedIn();
      allow update: if isSignedIn() && 
        request.auth.uid in resource.data.participants;
      
      match /messages/{messageId} {
        allow read: if isSignedIn() && 
          request.auth.uid in get(/databases/$(database)/documents/chats/$(chatId)).data.participants;
        allow create: if isSignedIn();
      }
    }
    
    match /reviews/{reviewId} {
      allow read: if isSignedIn();
      allow create: if isSignedIn();
      allow update: if isOwner(resource.data.ownerId);
      allow delete: if isOwner(resource.data.ownerId);
    }
    
    match /service_packages/{packageId} {
      allow read: if true;
      allow write: if false;
    }
  }
}
```

2. **Deploy rules:**

```bash
# Install Firebase CLI (one time only)
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase
firebase init firestore

# Deploy rules
firebase deploy --only firestore:rules
```

**Status:** ⬜ Not Started / ⬜ Complete

---

### ✅ Step 9: Test Your Setup (5 minutes)

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

**Test these features:**
- [ ] App launches without errors
- [ ] Can sign up with email/password
- [ ] Can sign in with email/password
- [ ] Google Sign-In works
- [ ] Can view data from Firestore

**Status:** ⬜ Not Started / ⬜ Complete

---

## 📊 Progress Tracker

```
Step 1: Create Project        ⬜
Step 2: Add Android App        ⬜
Step 3: Enable Auth            ⬜
Step 4: Create Firestore       ⬜
Step 5: Add iOS App            ⬜ (Optional)
Step 6: Add Web App            ⬜ (Optional)
Step 7: FlutterFire Configure  ⬜
Step 8: Deploy Rules           ⬜
Step 9: Test                   ⬜

Total Progress: 0/9 (0%)
```

---

## 🎯 Quick Reference

### Your Information

```
SHA-1: ED:02:3C:0B:BC:12:3D:83:BD:DF:56:0F:E0:AD:16:5C:14:EF:63:2B
Package Name: com.example.sahara
Bundle ID: com.example.sahara
```

### Important Files

```
android/app/google-services.json          ← Download from Firebase
ios/Runner/GoogleService-Info.plist       ← Download from Firebase
lib/firebase_options.dart                 ← Auto-generated by flutterfire
firestore.rules                           ← Create manually
```

### Commands

```bash
# Get SHA-1
cd android && ./gradlew signingReport

# Configure Firebase
flutterfire configure

# Deploy rules
firebase deploy --only firestore:rules

# Run app
flutter run
```

---

## 🆘 Common Issues

### "SHA-1 not working"
- Make sure you added it to Firebase Console
- Download new google-services.json
- Clean and rebuild

### "Permission denied in Firestore"
- Deploy security rules: `firebase deploy --only firestore:rules`

### "Google Sign-In not working"
- Check SHA-1 is added
- Check Google Sign-In is enabled in Firebase
- Download new google-services.json

---

## ✅ Completion Checklist

Before moving to next steps:

- [ ] Firebase project created
- [ ] Android app added with SHA-1
- [ ] google-services.json downloaded and placed correctly
- [ ] Email/Password authentication enabled
- [ ] Google Sign-In enabled
- [ ] Firestore database created
- [ ] FlutterFire configured
- [ ] Security rules deployed
- [ ] App runs without errors
- [ ] Authentication works

---

**Estimated Time:** 30-45 minutes
**Difficulty:** Easy to Medium
**Next Steps:** Configure Google Maps API keys (see SETUP_INSTRUCTIONS.md)
