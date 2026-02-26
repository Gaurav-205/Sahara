# Google Sign-In Setup Guide for Sahara

## Current Status
❌ **Google Sign-In is NOT fully configured**

The code implementation is complete, but the Firebase OAuth credentials are missing.

## What's Already Done ✅
1. ✅ `google_sign_in` package installed (v6.2.1)
2. ✅ Google Sign-In code implemented in `auth_service.dart`
3. ✅ Auth provider configured with `signInWithGoogle()` method
4. ✅ UI button connected in login screen
5. ✅ Firebase project created (sahara-a72)
6. ✅ `google-services.json` file present

## What's Missing ❌
The `google-services.json` file shows an empty `oauth_client` array, which means:
- OAuth 2.0 Client IDs are not configured in Firebase Console
- Google Sign-In will fail when users try to use it

## Setup Instructions

### Step 1: Enable Google Sign-In in Firebase Console
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: **sahara-a72**
3. Navigate to **Authentication** → **Sign-in method**
4. Click on **Google** provider
5. Click **Enable**
6. Enter your **Project support email** (your email)
7. Click **Save**

### Step 2: Configure OAuth Consent Screen (if needed)
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select project: **sahara-a72**
3. Navigate to **APIs & Services** → **OAuth consent screen**
4. If not configured:
   - Choose **External** user type
   - Fill in required fields:
     - App name: **Sahara**
     - User support email: (your email)
     - Developer contact: (your email)
   - Click **Save and Continue**
   - Skip scopes (default is fine)
   - Add test users if needed
   - Click **Save and Continue**

### Step 3: Download Updated google-services.json
1. Go back to [Firebase Console](https://console.firebase.google.com/)
2. Select **sahara-a72** project
3. Click the gear icon ⚙️ → **Project settings**
4. Scroll down to **Your apps** section
5. Find your Android app (com.example.sahara)
6. Click **google-services.json** download button
7. Replace the existing file at: `android/app/google-services.json`

### Step 4: Add SHA-1 Certificate (Required for Android)
Google Sign-In on Android requires SHA-1 fingerprint:

#### Get Debug SHA-1:
```bash
# Windows (PowerShell)
cd android
./gradlew signingReport

# Look for "SHA1:" under "Variant: debug"
```

#### Add SHA-1 to Firebase:
1. Copy the SHA-1 fingerprint
2. Go to Firebase Console → Project Settings
3. Scroll to **Your apps** → Select Android app
4. Click **Add fingerprint**
5. Paste SHA-1 and click **Save**
6. Download the updated `google-services.json` again
7. Replace in `android/app/google-services.json`

### Step 5: iOS Configuration (if building for iOS)
1. Download `GoogleService-Info.plist` from Firebase Console
2. Place it in `ios/Runner/` directory
3. Add to Xcode project
4. Add URL scheme to `ios/Runner/Info.plist`:
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>com.googleusercontent.apps.YOUR-CLIENT-ID</string>
        </array>
    </dict>
</array>
```

### Step 6: Test Google Sign-In
1. Run `flutter clean`
2. Run `flutter pub get`
3. Rebuild the app: `flutter run`
4. Try signing in with Google

## Verification Checklist
After setup, verify:
- [ ] Google provider is enabled in Firebase Authentication
- [ ] OAuth consent screen is configured
- [ ] SHA-1 fingerprint is added to Firebase
- [ ] Updated `google-services.json` has `oauth_client` entries
- [ ] App builds without errors
- [ ] Google Sign-In button works and shows Google account picker
- [ ] User can successfully sign in with Google account
- [ ] User data is created in Firestore after first sign-in

## Troubleshooting

### Error: "PlatformException(sign_in_failed)"
- **Cause**: SHA-1 fingerprint not added or incorrect
- **Solution**: Follow Step 4 to add SHA-1 fingerprint

### Error: "ApiException: 10"
- **Cause**: OAuth client not configured properly
- **Solution**: Re-download `google-services.json` after enabling Google Sign-In

### Error: "Developer Error"
- **Cause**: Package name mismatch
- **Solution**: Ensure Firebase app package name matches `android/app/build.gradle.kts` (com.example.sahara)

### Google Sign-In shows but fails silently
- **Cause**: OAuth consent screen not configured
- **Solution**: Complete Step 2

## Current Configuration
- **Package Name**: com.example.sahara
- **Firebase Project**: sahara-a72
- **Project Number**: 953036067023
- **API Key**: AIzaSyBALyqIvpmb0UM42RbKPIwmjcKON7RJBE4

## Production Considerations
Before releasing to production:
1. Generate release SHA-1 fingerprint and add to Firebase
2. Configure OAuth consent screen for production
3. Update to production OAuth credentials
4. Test thoroughly on physical devices
5. Consider adding Apple Sign-In for iOS users

## Support
If you encounter issues:
1. Check Firebase Console logs
2. Check Android Logcat for detailed errors
3. Verify all steps were completed
4. Ensure internet connection is available during sign-in

---
**Note**: Google Sign-In requires a valid Google account and internet connection to work.
