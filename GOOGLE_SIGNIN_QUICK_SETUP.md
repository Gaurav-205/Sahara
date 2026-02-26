# 🚀 Google Sign-In Quick Setup Guide

## ✅ Your SHA-1 Fingerprint (Already Generated!)

```
SHA-1: ED:02:3C:0B:BC:12:3D:83:BD:DF:56:0F:E0:AD:16:5C:14:EF:63:2B
```

---

## 📝 Step-by-Step Instructions

### Step 1: Open Firebase Console
1. Go to: https://console.firebase.google.com/
2. Click on project: **sahara-a72**

### Step 2: Enable Google Sign-In Provider
1. In left sidebar, click **Authentication**
2. Click **Sign-in method** tab
3. Find **Google** in the providers list
4. Click on **Google**
5. Toggle the **Enable** switch to ON
6. Enter your email in **Project support email**
7. Click **Save**

### Step 3: Add SHA-1 Fingerprint
1. Click the **gear icon ⚙️** (top left) → **Project settings**
2. Scroll down to **Your apps** section
3. Find your Android app: **com.example.sahara**
4. Click **Add fingerprint** button
5. Paste this SHA-1:
   ```
   ED:02:3C:0B:BC:12:3D:83:BD:DF:56:0F:E0:AD:16:5C:14:EF:63:2B
   ```
6. Click **Save**

### Step 4: Download Updated Configuration
1. Still in **Project settings** → **Your apps**
2. Find the Android app section
3. Click the **google-services.json** download button
4. Save the file to your computer

### Step 5: Replace Configuration File
1. Locate the downloaded `google-services.json` file
2. Copy it
3. Navigate to: `sahara/android/app/`
4. Replace the existing `google-services.json` file
5. Confirm replacement

### Step 6: Clean and Rebuild
Open terminal in the `sahara` folder and run:

```bash
flutter clean
flutter pub get
flutter run
```

---

## 🎯 What to Expect

After completing these steps:

✅ **Google Sign-In button will work**
- Tap "Google" button on login screen
- Google account picker appears
- Select your Google account
- Sign in successfully

✅ **User data is created**
- New user profile created in Firestore
- User can access the app immediately

---

## 🔍 How to Verify It's Working

### Check Firebase Console:
1. Go to **Authentication** → **Users** tab
2. After signing in with Google, you should see the user listed
3. User will have a Google icon next to their email

### Check Firestore:
1. Go to **Firestore Database**
2. Open **users** collection
3. You should see a document with the user's data

---

## ⚠️ Common Issues & Solutions

### Issue: "PlatformException(sign_in_failed)"
**Solution**: SHA-1 fingerprint not added correctly
- Double-check you copied the correct SHA-1
- Make sure you clicked "Save" in Firebase
- Download the updated google-services.json

### Issue: "ApiException: 10"
**Solution**: OAuth client not configured
- Verify Google Sign-In is enabled in Firebase
- Download the updated google-services.json
- Replace the file in android/app/

### Issue: Google Sign-In shows but fails silently
**Solution**: OAuth consent screen issue
- Go to Google Cloud Console
- Configure OAuth consent screen
- Add your email as a test user

### Issue: "Developer Error"
**Solution**: Package name mismatch
- Verify Firebase app package: com.example.sahara
- Check android/app/build.gradle.kts matches

---

## 📱 Testing Checklist

Before considering it complete:

- [ ] SHA-1 added to Firebase
- [ ] Google provider enabled in Firebase Authentication
- [ ] Downloaded updated google-services.json
- [ ] Replaced file in android/app/google-services.json
- [ ] Ran flutter clean
- [ ] Ran flutter pub get
- [ ] App builds without errors
- [ ] Google Sign-In button appears on login screen
- [ ] Clicking button shows Google account picker
- [ ] Can successfully sign in with Google account
- [ ] User appears in Firebase Authentication
- [ ] User data created in Firestore

---

## 🎉 Success!

Once all steps are complete, Google Sign-In will be fully functional!

Users can now:
- Sign in with their Google account
- Skip manual email/password entry
- Access the app immediately after Google authentication

---

## 📞 Need Help?

If you encounter issues:
1. Check the detailed guide: `GOOGLE_SIGNIN_SETUP.md`
2. Verify all steps were completed
3. Check Firebase Console logs
4. Review Android Logcat for errors

---

**Project**: Sahara Pet Care App
**Firebase Project**: sahara-a72
**Package Name**: com.example.sahara
