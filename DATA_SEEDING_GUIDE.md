# 🌱 Firebase Data Seeding Guide

## Overview

All mock data has been removed from the Sahara app. The app now uses real Firebase Firestore data. This guide explains how to seed your Firebase database with initial data.

## ✅ What Was Removed

### Mock Data Removed:
- ❌ `useMockFirestore` flag and all mock caregivers in `firestore_service.dart`
- ❌ `useMockAuth` flag and mock authentication in `auth_service.dart`
- ❌ `useMockPets` flag and mock pets in `pet_service.dart`
- ❌ All mock data delays and fake responses

### What Remains:
- ✅ Service packages in `package_service.dart` (static data, not in Firebase)
- ✅ All Firebase integration code (now active)
- ✅ Clean, production-ready services

## 🚀 Quick Start

### Option 1: Using the Admin Screen (Recommended)

1. **Add navigation to Admin Screen** (temporary, for seeding):

```dart
// In your app (e.g., profile screen or debug menu)
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => const AdminSeedScreen()),
);
```

2. **Seed the data**:
   - Open the Admin Seed Screen
   - Tap "Seed All Data"
   - Wait for completion (takes ~5-10 seconds)
   - Done! ✅

### Option 2: Programmatic Seeding

```dart
import 'package:sahara/utils/firebase_seeder.dart';

// In your app initialization or debug menu
final seeder = FirebaseSeeder();
await seeder.seedAll();
```

### Option 3: Manual Firebase Console

1. Go to [Firebase Console](https://console.firebase.google.com/project/sahara-a72)
2. Navigate to Firestore Database
3. Manually create collections and documents (see data structure below)

## 📊 Data Structure

### Caregivers Collection (`users`)

```
users/
├── caregiver_priya_sharma/
│   ├── uid: "caregiver_priya_sharma"
│   ├── email: "priya.sharma@sahara.app"
│   ├── name: "Priya Sharma"
│   ├── userType: "caregiver"
│   ├── rating: 4.9
│   ├── completedBookings: 120
│   ├── bio: "Passionate pet lover..."
│   ├── services: ["Dog Walking", "Pet Sitting", "Grooming", "Training"]
│   ├── hourlyRate: 450.0
│   ├── location: "Koramangala, Bengaluru"
│   ├── yearsOfExperience: 5
│   ├── isVerified: true
│   ├── isAvailable: true
│   ├── phoneNumber: "+91 98765 43210"
│   └── createdAt: Timestamp
└── ... (8 caregivers total)
```

### Service Packages Collection (`service_packages`)

```
service_packages/
├── dw_basic/
│   ├── id: "dw_basic"
│   ├── serviceType: "Dog Walking"
│   ├── packageName: "Basic Walk"
│   ├── description: "Perfect for a quick outdoor break"
│   ├── price: 200.0
│   ├── duration: "30 minutes"
│   ├── features: ["Neighborhood walk", "Basic exercise", ...]
│   └── isPopular: false
└── ... (12 packages total)
```

## 🎯 Seeded Data

### Caregivers (8 profiles):
1. **Priya Sharma** - 5 years exp, 4.9★, Bengaluru
2. **Rahul Verma** - 4 years exp, 4.8★, Mumbai
3. **Anjali Patel** - 3 years exp, 4.7★, Bengaluru
4. **Vikram Singh** - 4 years exp, 4.6★, Bengaluru
5. **Meera Reddy** - 6 years exp, 4.9★, Hyderabad
6. **Arjun Kumar** - 2 years exp, 4.5★, Mumbai
7. **Sneha Desai** - 3 years exp, 4.8★, Mumbai
8. **Karthik Nair** - 4 years exp, 4.7★, Bengaluru

### Service Packages (12 packages):
- **Dog Walking**: Basic, Standard, Premium (₹200-500)
- **Pet Sitting**: Basic, Full Day, Overnight (₹400-1200)
- **Grooming**: Basic, Full, Spa (₹500-1500)
- **Vet Visit**: Transportation, Companion, Complete (₹300-800)

## 🔒 Industry Standards Followed

### Data Quality:
- ✅ Realistic names and locations (Indian cities)
- ✅ Professional bios and descriptions
- ✅ Appropriate pricing (₹200-1500 range)
- ✅ Verified status and availability flags
- ✅ Complete contact information
- ✅ Proper timestamps and IDs

### Security:
- ✅ No sensitive data in seed files
- ✅ Proper Firestore security rules required
- ✅ Email addresses use @sahara.app domain
- ✅ Phone numbers are formatted properly

### Performance:
- ✅ Batch writes for efficiency
- ✅ Indexed fields (rating, userType, isAvailable)
- ✅ Optimized queries
- ✅ Proper data normalization

## 🔧 Firestore Security Rules

Add these rules to Firebase Console:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Users collection
    match /users/{userId} {
      allow read: if true; // Public read for caregivers
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Service packages (read-only)
    match /service_packages/{packageId} {
      allow read: if true;
      allow write: if false; // Only admin can write
    }
    
    // Bookings
    match /bookings/{bookingId} {
      allow read: if request.auth != null && 
        (resource.data.ownerId == request.auth.uid || 
         resource.data.caregiverId == request.auth.uid);
      allow create: if request.auth != null;
      allow update: if request.auth != null && 
        (resource.data.ownerId == request.auth.uid || 
         resource.data.caregiverId == request.auth.uid);
    }
    
    // Pets
    match /pets/{petId} {
      allow read, write: if request.auth != null && 
        resource.data.ownerId == request.auth.uid;
    }
    
    // Reviews
    match /reviews/{reviewId} {
      allow read: if true;
      allow create: if request.auth != null;
      allow update, delete: if request.auth != null && 
        resource.data.userId == request.auth.uid;
    }
  }
}
```

## 🔍 Firestore Indexes

Create these composite indexes in Firebase Console:

1. **Caregivers by rating**:
   - Collection: `users`
   - Fields: `userType` (Ascending), `rating` (Descending)

2. **Available caregivers**:
   - Collection: `users`
   - Fields: `userType` (Ascending), `isAvailable` (Ascending)

3. **User bookings**:
   - Collection: `bookings`
   - Fields: `ownerId` (Ascending), `scheduledDate` (Descending)

4. **Caregiver bookings**:
   - Collection: `bookings`
   - Fields: `caregiverId` (Ascending), `scheduledDate` (Descending)

## 🧪 Testing

After seeding, test these features:

1. **Home Screen**:
   - [ ] Top caregivers display
   - [ ] Ratings and info show correctly
   - [ ] Search works

2. **Service Selection**:
   - [ ] All 4 services available
   - [ ] Packages load correctly
   - [ ] Pricing displays properly

3. **Caregiver Selection**:
   - [ ] Caregivers filtered by service
   - [ ] Location search works
   - [ ] Availability status correct

4. **Booking Flow**:
   - [ ] Can create bookings
   - [ ] Bookings save to Firestore
   - [ ] Booking history displays

## 🗑️ Clearing Data

To remove all seeded data:

```dart
final seeder = FirebaseSeeder();
await seeder.clearAllData();
```

Or use the "Clear All Data" button in Admin Seed Screen.

## ⚠️ Important Notes

1. **Run seeding only once** - Running multiple times will create duplicates
2. **Remove Admin Screen** - After seeding, remove navigation to AdminSeedScreen in production
3. **Backup data** - Before clearing, export data from Firebase Console if needed
4. **Security rules** - Set up proper Firestore security rules before production
5. **Indexes** - Create required indexes to avoid query errors

## 📱 Production Checklist

Before deploying to production:

- [ ] Data seeded successfully
- [ ] Firestore security rules configured
- [ ] Composite indexes created
- [ ] Admin Seed Screen removed/hidden
- [ ] All mock data removed (verified)
- [ ] App tested with real data
- [ ] Firebase billing enabled (if needed)
- [ ] Backup strategy in place

## 🆘 Troubleshooting

### "Permission denied" errors:
- Check Firestore security rules
- Ensure user is authenticated
- Verify collection names match

### "Index required" errors:
- Create composite indexes in Firebase Console
- Wait 5-10 minutes for indexes to build

### Seeding fails:
- Check Firebase connection
- Verify google-services.json is present
- Check console for detailed errors

### Data not showing:
- Verify collection names: `users`, `service_packages`
- Check document IDs match expected format
- Ensure queries are correct

## 📚 Additional Resources

- [Firestore Documentation](https://firebase.google.com/docs/firestore)
- [Security Rules Guide](https://firebase.google.com/docs/firestore/security/get-started)
- [Indexing Best Practices](https://firebase.google.com/docs/firestore/query-data/indexing)

---

**Status:** ✅ Mock data removed, Firebase seeding ready
**Last Updated:** February 26, 2026
