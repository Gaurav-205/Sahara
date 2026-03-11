# Troubleshooting Guide - Sahara Pet Care

Common issues and their solutions.

---

## 🔥 Firebase Issues

### Issue: "Default FirebaseApp is not initialized"

**Symptoms:**
```
[ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: 
[core/no-app] No Firebase App '[DEFAULT]' has been created
```

**Solutions:**
1. Make sure you ran `flutterfire configure`
2. Check that `lib/firebase_options.dart` exists
3. Verify `Firebase.initializeApp()` is called in `main.dart`
4. Check that `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) is in the correct location

**Quick Fix:**
```bash
flutterfire configure
flutter clean
flutter pub get
flutter run
```

---

### Issue: "FirebaseException: Permission denied"

**Symptoms:**
```
[cloud_firestore/permission-denied] The caller does not have permission
```

**Solutions:**
1. Deploy Firestore security rules:
   ```bash
   firebase deploy --only firestore:rules
   ```
2. Make sure user is authenticated before accessing Firestore
3. Check that security rules allow the operation

**Quick Fix:**
```bash
# Create firestore.rules file (see SETUP_INSTRUCTIONS.md)
firebase deploy --only firestore:rules
```

---

### Issue: Google Sign-In not working on Android

**Symptoms:**
- Google Sign-In button does nothing
- Error: "PlatformException(sign_in_failed)"

**Solutions:**
1. Add SHA-1 fingerprint to Firebase Console:
   ```bash
   cd android
   ./gradlew signingReport
   # Copy SHA1 from output
   ```
2. Add SHA-1 in Firebase Console:
   - Project Settings → Your apps → Android app
   - Click "Add fingerprint"
   - Paste SHA-1
3. Download new `google-services.json`
4. Replace old file in `android/app/`
5. Clean and rebuild:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

---

## 🗺️ Google Maps Issues

### Issue: "Google Maps not showing" or blank map

**Symptoms:**
- Map area is blank/gray
- No markers visible
- Console shows API key errors

**Solutions:**

**For Android:**
1. Check API key in `android/app/src/main/AndroidManifest.xml`
2. Enable "Maps SDK for Android" in Google Cloud Console
3. Make sure API key is restricted to your package name and SHA-1
4. Verify package name matches in Firebase and Google Cloud

**For iOS:**
1. Check API key in `ios/Runner/AppDelegate.swift` and `Info.plist`
2. Enable "Maps SDK for iOS" in Google Cloud Console
3. Make sure API key is restricted to your bundle ID
4. Run `pod install` in ios folder

**For Web:**
1. Check API key in `web/index.html`
2. Enable "Maps JavaScript API" in Google Cloud Console
3. Make sure API key is restricted to your domain

**Quick Fix:**
```bash
# Check if APIs are enabled
# Go to: https://console.cloud.google.com/apis/library
# Search and enable:
# - Maps SDK for Android
# - Maps SDK for iOS  
# - Maps JavaScript API
# - Geocoding API
# - Places API
```

---

### Issue: "API key not valid" or "REQUEST_DENIED"

**Symptoms:**
```
Google Maps API error: REQUEST_DENIED
This API key is not authorized to use this service or API
```

**Solutions:**
1. **Enable required APIs** in Google Cloud Console
2. **Check API key restrictions:**
   - Android: Package name + SHA-1
   - iOS: Bundle ID
   - Web: HTTP referrer (domain)
3. **Wait 5-10 minutes** after creating/updating API key
4. **Check billing** is enabled (required for some APIs)

**Quick Fix:**
```bash
# Remove restrictions temporarily for testing
# Go to Google Cloud Console → Credentials
# Edit your API key
# Under "API restrictions", select "Don't restrict key"
# Save and test
# IMPORTANT: Re-enable restrictions after testing!
```

---

## ☁️ Cloudinary Issues

### Issue: "Cloudinary upload failed"

**Symptoms:**
- Image upload fails silently
- Error: "Upload failed with status 400"
- Error: "Invalid upload preset"

**Solutions:**
1. **Check .env file:**
   ```env
   CLOUDINARY_CLOUD_NAME=your_actual_cloud_name  # Not placeholder!
   CLOUDINARY_UPLOAD_PRESET=your_actual_preset   # Not placeholder!
   ```

2. **Verify Upload Preset is "Unsigned":**
   - Go to Cloudinary Console → Settings → Upload
   - Find your preset
   - Make sure "Signing Mode" is "Unsigned"

3. **Check Cloud Name:**
   - Go to Cloudinary Dashboard
   - Copy exact Cloud Name (case-sensitive)

4. **Restart app after changing .env:**
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

**Quick Fix:**
```bash
# Test Cloudinary config
# In your app, try uploading an image
# Check Cloudinary Dashboard → Media Library
# If image appears, config is correct
```

---

## 📱 Build Issues

### Issue: "Gradle build failed" (Android)

**Symptoms:**
```
FAILURE: Build failed with an exception.
```

**Solutions:**
1. **Clean build:**
   ```bash
   cd android
   ./gradlew clean
   cd ..
   flutter clean
   flutter pub get
   flutter run
   ```

2. **Check Java version:**
   ```bash
   java -version
   # Should be Java 11 or higher
   ```

3. **Update Gradle:**
   - Edit `android/gradle/wrapper/gradle-wrapper.properties`
   - Update to latest Gradle version

4. **Check google-services.json:**
   - Make sure it's in `android/app/`
   - Make sure it's valid JSON

---

### Issue: "Pod install failed" (iOS)

**Symptoms:**
```
Error: CocoaPods not installed or not in valid state.
```

**Solutions:**
1. **Install/Update CocoaPods:**
   ```bash
   sudo gem install cocoapods
   ```

2. **Clean and reinstall:**
   ```bash
   cd ios
   rm -rf Pods Podfile.lock
   pod install
   cd ..
   flutter clean
   flutter pub get
   flutter run
   ```

3. **Update Xcode:**
   - Make sure Xcode is up to date
   - Open Xcode and accept license agreements

---

## 🔐 Authentication Issues

### Issue: "User not found" after sign up

**Symptoms:**
- User can sign up but data not in Firestore
- Error: "User document does not exist"

**Solutions:**
1. Check that `auth_service.dart` creates user document
2. Verify Firestore security rules allow user creation
3. Check Firebase Console → Firestore for user document

**Quick Fix:**
```dart
// In auth_service.dart, after creating user:
await _firestore.collection('users').doc(user.uid).set(user.toMap());
```

---

### Issue: "Email already in use"

**Symptoms:**
```
FirebaseAuthException: [firebase_auth/email-already-in-use]
```

**Solutions:**
1. User already exists - use sign in instead
2. Delete user from Firebase Console → Authentication
3. Use password reset if user forgot password

---

## 📞 Phone Call Issues

### Issue: "Phone number not available"

**Symptoms:**
- Clicking call button shows "Phone number not available"
- Phone field is null in caregiver data

**Solutions:**
1. **Check Firestore data:**
   - Go to Firebase Console → Firestore
   - Find caregiver document
   - Verify `phone` field exists and has value

2. **Seed test data:**
   - Run the seeder to populate caregiver data
   - Or manually add phone numbers in Firestore

3. **Check data fetching:**
   - Make sure `getUserById()` returns complete user data
   - Verify phone field is not filtered out

---

## 🔔 Notification Issues

### Issue: "Notifications not working"

**Symptoms:**
- No notifications received
- FCM token is null

**Solutions:**
1. **Check permissions:**
   - Android: Automatically granted
   - iOS: User must grant permission

2. **Verify FCM setup:**
   - Check `google-services.json` (Android)
   - Check `GoogleService-Info.plist` (iOS)
   - Verify Firebase Cloud Messaging is enabled

3. **Test FCM token:**
   ```dart
   final token = await FirebaseMessaging.instance.getToken();
   print('FCM Token: $token');
   ```

---

## 🐛 General Debugging

### Enable Verbose Logging

```bash
flutter run --verbose
```

### Check Flutter Doctor

```bash
flutter doctor -v
```

### Clear Everything and Start Fresh

```bash
flutter clean
cd android && ./gradlew clean && cd ..
cd ios && rm -rf Pods Podfile.lock && pod install && cd ..
flutter pub get
flutter run
```

### Check Logs

**Android:**
```bash
adb logcat | grep flutter
```

**iOS:**
```bash
# In Xcode: Window → Devices and Simulators → View Device Logs
```

---

## 📊 Performance Issues

### Issue: "App is slow" or "Laggy UI"

**Solutions:**
1. **Enable release mode:**
   ```bash
   flutter run --release
   ```

2. **Check for memory leaks:**
   - Look for uncancelled StreamSubscriptions
   - Check for circular references

3. **Optimize images:**
   - Use `cached_network_image` for remote images
   - Compress images before upload

4. **Profile the app:**
   ```bash
   flutter run --profile
   # Then use DevTools to analyze performance
   ```

---

## 🆘 Still Having Issues?

### 1. Check Documentation
- `SETUP_INSTRUCTIONS.md` - Complete setup guide
- `SECURITY_CONFIGURATION_GUIDE.md` - Security setup
- `QUICK_START.md` - Quick reference

### 2. Check Logs
```bash
flutter run --verbose 2>&1 | tee flutter_log.txt
```

### 3. Search Error Messages
- Copy exact error message
- Search in:
  - Flutter GitHub issues
  - Stack Overflow
  - Firebase documentation

### 4. Common Error Patterns

| Error Contains | Likely Issue |
|----------------|--------------|
| `permission-denied` | Firestore security rules |
| `API key not valid` | Google Cloud API not enabled |
| `sign_in_failed` | SHA-1 not added to Firebase |
| `Upload failed` | Cloudinary config wrong |
| `No Firebase App` | Firebase not initialized |

---

## 📝 Reporting Issues

If you need to report an issue, include:

1. **Error message** (full stack trace)
2. **Steps to reproduce**
3. **Flutter version:** `flutter --version`
4. **Platform:** Android/iOS/Web
5. **What you've tried**
6. **Relevant code snippets**

---

**Last Updated:** March 12, 2026
**Version:** 1.0.0
