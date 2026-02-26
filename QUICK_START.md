# ⚡ Quick Start Guide

## 🚀 Get Your App Running (10 Minutes)

### Step 1: Seed Firebase Data (5 min) - REQUIRED

Your app now uses real Firebase data. Seed it once:

```dart
// Add to your app temporarily (e.g., in main.dart or profile screen)
import 'package:sahara/screens/admin_seed_screen.dart';

// Add a button or navigate directly:
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => const AdminSeedScreen()),
);
```

Then:
1. Open the Admin Seed Screen
2. Tap "Seed All Data"
3. Wait ~10 seconds
4. Done! ✅

**What gets seeded:**
- 8 Caregiver profiles (Priya, Rahul, Anjali, etc.)
- 12 Service packages (Dog Walking, Pet Sitting, Grooming, Vet Visit)

### Step 2: Configure Firestore (3 min) - REQUIRED

**A. Security Rules:**
1. Go to [Firebase Console](https://console.firebase.google.com/project/sahara-a72)
2. Click Firestore Database → Rules
3. Copy rules from `DATA_SEEDING_GUIDE.md` (section: Firestore Security Rules)
4. Publish

**B. Create Indexes:**
1. In Firebase Console → Firestore → Indexes
2. Create these composite indexes:
   - Collection: `users`, Fields: `userType` (Asc), `rating` (Desc)
   - Collection: `users`, Fields: `userType` (Asc), `isAvailable` (Asc)
   - Collection: `bookings`, Fields: `ownerId` (Asc), `scheduledDate` (Desc)
   - Collection: `bookings`, Fields: `caregiverId` (Asc), `scheduledDate` (Desc)

### Step 3: Clean & Run (2 min)

```bash
flutter clean
flutter pub get
flutter run
```

---

## ✅ Verification

After setup, verify:
- [ ] Home screen shows 8 caregivers
- [ ] Ratings and info display correctly
- [ ] Service selection works (4 services)
- [ ] Package selection works (3 tiers each)
- [ ] Caregiver filtering works
- [ ] Can create bookings

---

## 📚 Documentation

- **Quick Start** - This file (you are here)
- **[DATA_SEEDING_GUIDE.md](DATA_SEEDING_GUIDE.md)** - Detailed seeding guide
- **[MOCK_DATA_REMOVAL_SUMMARY.md](MOCK_DATA_REMOVAL_SUMMARY.md)** - What changed
- **[SETUP.md](SETUP.md)** - General setup instructions
- **[README.md](README.md)** - Project overview

---

## 🆘 Troubleshooting

### "No caregivers showing"
→ You need to seed data first (Step 1)

### "Permission denied" errors
→ Configure Firestore security rules (Step 2A)

### "Index required" errors
→ Create composite indexes (Step 2B)

### "Seeding fails"
→ Check Firebase connection and google-services.json

---

## 🎯 What Changed

### ✅ Removed:
- All mock data flags (`useMockFirestore`, `useMockAuth`, `useMockPets`)
- 290 lines of mock code
- Fake caregivers, pets, and authentication

### ✅ Added:
- Professional Firebase seeding solution
- Admin Seed Screen for easy data seeding
- Industry-standard data structure
- Complete documentation

### ⚠️ Breaking Change:
App now requires Firebase data to work. No more mock/fake data.

---

## 📱 Production Checklist

Before deploying:
- [ ] Data seeded successfully
- [ ] Firestore rules configured
- [ ] Indexes created
- [ ] Admin Seed Screen removed/hidden
- [ ] App tested with real data
- [ ] Firebase billing enabled
- [ ] Backup strategy in place

---

**Time to Complete:** 10 minutes  
**Difficulty:** Easy  
**Status:** Ready to go! 🚀
