# Your Android SHA-1 Fingerprint

## 🔑 Debug SHA-1 Fingerprint

```
SHA1: ED:02:3C:0B:BC:12:3D:83:BD:DF:56:0F:E0:AD:16:5C:14:EF:63:2B
```

## 📋 Additional Information

**SHA-256:**
```
B3:40:F2:42:D8:19:20:49:2D:4B:31:70:FC:26:09:F3:9D:C9:D9:C1:AF:DC:94:87:A2:02:37:0B:F0:2D:ED:B3
```

**MD5:**
```
27:39:63:AE:6A:88:4A:8E:1A:33:F8:15:AE:5D:0D:92
```

**Keystore Location:**
```
C:\Users\gaura\.android\debug.keystore
```

**Valid Until:**
```
Thursday, 10 February, 2056
```

---

## 🚀 How to Use This SHA-1

### Step 1: Add to Firebase Console

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Click the gear icon ⚙️ → Project Settings
4. Scroll down to "Your apps"
5. Click on your Android app
6. Scroll to "SHA certificate fingerprints"
7. Click "Add fingerprint"
8. Paste this SHA-1:
   ```
   ED:02:3C:0B:BC:12:3D:83:BD:DF:56:0F:E0:AD:16:5C:14:EF:63:2B
   ```
9. Click "Save"

### Step 2: Download New google-services.json

1. After adding SHA-1, download the updated `google-services.json`
2. Replace the file in: `android/app/google-services.json`

### Step 3: Rebuild Your App

```bash
flutter clean
flutter pub get
flutter run
```

---

## 🔒 For Production Release

**IMPORTANT:** This is your DEBUG keystore SHA-1. For production release, you'll need:

1. **Create a release keystore:**
   ```bash
   keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

2. **Get release SHA-1:**
   ```bash
   keytool -list -v -keystore ~/upload-keystore.jks -alias upload
   ```

3. **Add release SHA-1 to Firebase** (same process as above)

---

## ✅ Verification

After adding SHA-1 to Firebase, test:

1. **Google Sign-In** should work
2. **Firebase Authentication** should work
3. **Google Maps** should work (if API key is also configured)

---

## 📝 Notes

- This SHA-1 is for **development/debug** builds only
- It's tied to your debug keystore on this machine
- Other developers will have different debug SHA-1s
- For production, use a release keystore SHA-1
- Keep your release keystore secure and backed up!

---

## 🆘 Troubleshooting

### Google Sign-In Still Not Working?

1. Make sure you added the SHA-1 to Firebase
2. Download new `google-services.json`
3. Clean and rebuild:
   ```bash
   flutter clean
   cd android
   ./gradlew clean
   cd ..
   flutter pub get
   flutter run
   ```

### Need to Get SHA-1 Again?

```bash
cd android
./gradlew signingReport
```

Look for the line that says `SHA1:` under `Variant: debug`

---

**Generated:** March 12, 2026
**Machine:** Windows (gaura)
**Keystore:** debug.keystore
