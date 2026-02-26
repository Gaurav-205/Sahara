# 🚀 Sahara Pet Care - Quick Start Guide

## ⚡ Fast Track to Running the App

### 1️⃣ Prerequisites (One-Time Setup)
```bash
# Verify Flutter is installed
flutter doctor

# If not installed, visit: https://flutter.dev/docs/get-started/install
```

### 2️⃣ Install Dependencies
```bash
cd sahara
flutter pub get
```

### 3️⃣ Run the App
```bash
# On connected device or emulator
flutter run

# Or build APK
flutter build apk --debug
```

### 4️⃣ First Launch Setup

1. **Sign Up** in the app
   - Use any email/password
   - Select "Pet Owner" as user type

2. **Seed Database** (Important!)
   - Go to Profile screen (bottom navigation)
   - Scroll down
   - Tap "🔧 Seed Database" button
   - Wait 10-20 seconds

3. **Start Using**
   - Browse caregivers on Home screen
   - Add your pets
   - Book services
   - Chat with caregivers

---

## 🔥 Common Commands

```bash
# Clean build (if issues occur)
flutter clean && flutter pub get && flutter run

# Check for issues
flutter analyze

# Run on specific device
flutter devices
flutter run -d <device-id>

# Build release APK
flutter build apk --release

# View logs
flutter logs
```

---

## ⚠️ Troubleshooting

### "No devices found"
```bash
# Start Android emulator
# Or connect physical device with USB debugging enabled
```

### "Build failed"
```bash
flutter clean
cd android
./gradlew clean
cd ..
flutter pub get
flutter run
```

### "Firebase error"
- Check internet connection
- Verify google-services.json exists in android/app/
- See SETUP_GUIDE.md for detailed Firebase setup

### "No caregivers showing"
- Make sure you seeded the database (Step 4.2 above)
- Check internet connection
- Restart the app

---

## 📱 Test Accounts

After seeding, you can test with:
- **Your account:** Pet Owner (created during signup)
- **Caregivers:** 10 pre-seeded caregiver profiles
- **Services:** 12 service packages across 4 categories

---

## 🎯 Key Features to Test

- ✅ User authentication (Email + Google Sign-In)
- ✅ Profile management with photo upload
- ✅ Pet management (Add, Edit, Delete)
- ✅ Browse caregivers by service
- ✅ View caregiver profiles and reviews
- ✅ Select service packages
- ✅ Create bookings
- ✅ Real-time chat with caregivers
- ✅ View booking history
- ✅ Search functionality

---

## 📚 More Information

- **Complete Setup:** See [SETUP_GUIDE.md](SETUP_GUIDE.md)
- **Bug Fixes:** See [BUG_FIXES_APPLIED.md](BUG_FIXES_APPLIED.md)
- **Project Info:** See [README.md](README.md)

---

## 🆘 Need Help?

1. Check [BUG_FIXES_APPLIED.md](BUG_FIXES_APPLIED.md) for known issues
2. Review [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed instructions
3. Run `flutter doctor -v` to check your setup
4. Check Firebase Console for backend issues

---

**Ready to go! 🎉**

The app is fully functional and ready for testing. All critical bugs have been fixed.
