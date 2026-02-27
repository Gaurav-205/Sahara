# Quick Fix: Google Sign-In Not Working

## The Problem
Your app is missing the Android OAuth client configuration in Firebase.

## Quick Fix (5 minutes)

### 1. Add SHA-1 to Firebase
- Go to: https://console.firebase.google.com/project/sahara-a72/settings/general
- Find your Android app: **com.example.sahara**
- Click **Add fingerprint**
- Paste: `ED:02:3C:0B:BC:12:3D:83:BD:DF:56:0F:E0:AD:16:5C:14:EF:63:2B`
- Click **Save**

### 2. Enable Google Sign-In
- Go to: https://console.firebase.google.com/project/sahara-a72/authentication/providers
- Click **Google**
- Toggle **Enable**
- Add your email as support email
- Click **Save**

### 3. Download New Config
- Go back to Project Settings
- Download new **google-services.json**
- Replace: `sahara/android/app/google-services.json`

### 4. Rebuild
```bash
flutter clean
flutter pub get
flutter run
```

### 5. Test on Real Device
Google Sign-In doesn't work well on emulators. Use a real Android phone.

## That's It!

Your Google Sign-In should now work. Check the detailed guide in `GOOGLE_SIGNIN_FIX_GUIDE.md` if you need more help.

## Debug Logging Added
I've added debug logging to `auth_service.dart`. Check your console/logcat for detailed error messages if issues persist.
