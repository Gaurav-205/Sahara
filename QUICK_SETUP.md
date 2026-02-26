# 🚀 Quick Firebase Setup (5 Minutes)

## Step 1: Enable Authentication (2 minutes)

1. Open: https://console.firebase.google.com/project/sahara-a72/authentication
2. Click **"Get Started"** (if you see it)
3. Click **"Sign-in method"** tab
4. Click **"Email/Password"** → Toggle ON → Save
5. Click **"Google"** → Toggle ON → Enter your email → Save

✅ Done!

## Step 2: Enable Firestore (2 minutes)

1. Open: https://console.firebase.google.com/project/sahara-a72/firestore
2. Click **"Create database"**
3. Select **"Start in test mode"**
4. Choose location (any close to you)
5. Click **"Enable"**

✅ Done!

## Step 3: Get SHA-1 for Google Sign-In (1 minute)

Open terminal in your project folder and run:

**Windows:**
```bash
cd android
gradlew signingReport
```

**Mac/Linux:**
```bash
cd android
./gradlew signingReport
```

Copy the **SHA-1** value (looks like: `A1:B2:C3:...`)

## Step 4: Add SHA-1 to Firebase (1 minute)

1. Open: https://console.firebase.google.com/project/sahara-a72/settings/general
2. Scroll to **"Your apps"** → Find Android app
3. Click **"Add fingerprint"**
4. Paste SHA-1 → Click **"Save"**

✅ Done!

## Step 5: Test the App

```bash
flutter clean
flutter pub get
flutter run
```

Try:
1. Sign up with email: test@test.com / password123
2. Sign in with the same credentials
3. Try Google Sign-In
4. Try Forgot Password

## ✅ That's It!

Your app is now running with Firebase backend!

Check users here: https://console.firebase.google.com/project/sahara-a72/authentication/users

---

## 🆘 Need Help?

**Can't find SHA-1?**
Look for this in the terminal output:
```
Variant: debug
Config: debug
Store: ~/.android/debug.keystore
Alias: AndroidDebugKey
SHA1: XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX
```

**Google Sign-In not working?**
1. Make sure SHA-1 is added
2. Run: `flutter clean && flutter pub get`
3. Restart the app

**Still having issues?**
Check the detailed guide: `FIREBASE_SETUP_GUIDE.md`
