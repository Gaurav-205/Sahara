# Google Sign-In Fix Guide

## Problem Identified

Your `google-services.json` file only contains a **Web OAuth client** (client_type: 3), but Google Sign-In on Android requires an **Android OAuth client** (client_type: 1) with your app's SHA-1 fingerprint.

## Your SHA-1 Fingerprint

```
SHA1: ED:02:3C:0B:BC:12:3D:83:BD:DF:56:0F:E0:AD:16:5C:14:EF:63:2B
SHA-256: B3:40:F2:42:D8:19:20:49:2D:4B:31:70:FC:26:09:F3:9D:C9:D9:C1:AF:DC:94:87:A2:02:37:0B:F0:2D:ED:B3
```

## Step-by-Step Fix

### Step 1: Add SHA-1 to Firebase Console

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: **sahara-a72**
3. Click the gear icon ⚙️ → **Project settings**
4. Scroll down to **Your apps** section
5. Find your Android app: **com.example.sahara**
6. Click **Add fingerprint** button
7. Paste your SHA-1 fingerprint:
   ```
   ED:02:3C:0B:BC:12:3D:83:BD:DF:56:0F:E0:AD:16:5C:14:EF:63:2B
   ```
8. Click **Save**

### Step 2: Enable Google Sign-In

1. In Firebase Console, go to **Authentication** (left sidebar)
2. Click **Sign-in method** tab
3. Find **Google** in the providers list
4. Click **Google** to expand
5. Toggle **Enable** switch to ON
6. Set **Project support email** (required)
7. Click **Save**

### Step 3: Download Updated google-services.json

1. Go back to **Project settings** → **Your apps**
2. Find your Android app
3. Click **google-services.json** download button
4. Replace the file at: `sahara/android/app/google-services.json`

The new file should contain an Android OAuth client like this:
```json
{
  "client_id": "YOUR_PROJECT_ID-XXXXX.apps.googleusercontent.com",
  "client_type": 1,
  "android_info": {
    "package_name": "com.example.sahara",
    "certificate_hash": "ed023c0bbc123d83bddf560fe0ad165c14ef632b"
  }
}
```

### Step 4: Clean and Rebuild

```bash
# Clean the project
flutter clean

# Get dependencies
flutter pub get

# Rebuild
flutter run
```

### Step 5: Test on Real Device

**IMPORTANT**: Google Sign-In often fails on emulators. Test on a real Android device:

1. Enable USB debugging on your phone
2. Connect via USB
3. Run: `flutter run`
4. Test Google Sign-In

## Verification Checklist

- [ ] SHA-1 fingerprint added to Firebase Console
- [ ] Google Sign-In enabled in Firebase Authentication
- [ ] Project support email set
- [ ] New google-services.json downloaded and replaced
- [ ] Flutter clean + pub get executed
- [ ] Tested on real Android device

## Common Issues

### Issue: "PlatformException(sign_in_failed)"
- **Cause**: SHA-1 not added or incorrect
- **Fix**: Verify SHA-1 in Firebase Console matches your debug keystore

### Issue: "Error 10: Developer Error"
- **Cause**: Package name mismatch
- **Fix**: Ensure package name is `com.example.sahara` everywhere

### Issue: "Sign-in canceled by user" (immediately)
- **Cause**: Missing Android OAuth client
- **Fix**: Follow Step 3 to get updated google-services.json

### Issue: Works on one device but not another
- **Cause**: Different signing keys (debug vs release)
- **Fix**: Add both debug and release SHA-1 fingerprints

## Additional SHA-1 Fingerprints (If Needed)

If you plan to release the app, you'll need to add your release keystore SHA-1:

```bash
# For release keystore
keytool -list -v -keystore path/to/release.keystore -alias your_alias
```

## Current Configuration

- **Package Name**: com.example.sahara
- **Project ID**: sahara-a72
- **Debug Keystore**: C:\Users\gaura\.android\debug.keystore
- **google_sign_in version**: 6.2.2

## Next Steps After Fix

Once Google Sign-In is working:
1. Test sign-in flow
2. Test sign-out
3. Test user data persistence
4. Continue with Phase 2 screen enhancements

## Need Help?

If Google Sign-In still doesn't work after following these steps:
1. Check Firebase Console logs
2. Enable debug logging in auth_service.dart
3. Check Android Logcat for detailed error messages
