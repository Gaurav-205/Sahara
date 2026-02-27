# Quick Guide: Updated Seed Data

## ✅ What Changed

### Profile Pictures Added
All 16 caregivers now have profile photos from Pravatar CDN:
```
https://i.pravatar.cc/300?img={ID}
```

### Enhanced Locations
Full India-based addresses with state names:
- Koramangala, Bengaluru, Karnataka
- Bandra West, Mumbai, Maharashtra
- Hitech City, Hyderabad, Telangana
- Hauz Khas, New Delhi

### 4 New Caregivers Added
- **Sanjay Mehta** - Senior dog care specialist (Delhi)
- **Kavita Rao** - Award-winning groomer (Bengaluru)
- **Aditya Singh** - Active breed specialist (Mumbai)
- **Pooja Nambiar** - Positive reinforcement trainer (Hyderabad)

---

## 🚀 How to Seed

### Option 1: Using Admin Screen
1. Open the app
2. Go to Admin Seed Screen
3. Tap "Seed All Data"
4. Wait for confirmation

### Option 2: Programmatically
```dart
import 'package:sahara/utils/firebase_seeder.dart';

final seeder = FirebaseSeeder();

// Seed everything
await seeder.seedAll();

// Or seed individually
await seeder.seedCaregivers();
await seeder.seedServicePackages();

// Check what's in database
await seeder.checkDatabaseStatus();
```

---

## 📊 What Gets Seeded

### 16 Caregivers
- ✅ Profile pictures
- ✅ India-based locations
- ✅ Phone numbers (+91)
- ✅ Ratings (4.6 - 4.9 stars)
- ✅ Completed bookings
- ✅ Services offered
- ✅ Years of experience
- ✅ Verification status

### 21 Service Packages
- Dog Walking (4 packages)
- Dog Sitting (4 packages)
- Dog Grooming (4 packages)
- Dog Training (5 packages)
- Vet Visit (4 packages)

---

## 🎨 Profile Pictures

### Sample URLs
```
Priya Sharma:  https://i.pravatar.cc/300?img=5
Rahul Verma:   https://i.pravatar.cc/300?img=12
Anjali Patel:  https://i.pravatar.cc/300?img=9
Vikram Singh:  https://i.pravatar.cc/300?img=13
Meera Reddy:   https://i.pravatar.cc/300?img=10
... and 11 more
```

### Why Pravatar?
- Free and reliable
- Fast CDN delivery
- No API key needed
- 300x300 pixel avatars
- Professional looking

---

## 📍 Geographic Coverage

| City | Caregivers | Areas |
|------|-----------|-------|
| Bengaluru | 6 | Koramangala, Whitefield, Indiranagar, Jayanagar, HSR Layout |
| Mumbai | 5 | Bandra, Powai, Andheri, Malad, Juhu |
| Hyderabad | 3 | Hitech City, Jubilee Hills, Banjara Hills |
| Delhi NCR | 2 | Gurgaon, Hauz Khas |

---

## 🧪 Testing

### After Seeding
1. **Browse Caregivers** - Check if all 16 appear
2. **View Profiles** - Verify photos load
3. **Check Locations** - Confirm India addresses
4. **Test Search** - Search by name/location
5. **View Services** - Check service packages

### Clear and Re-seed
```dart
// Clear everything
await seeder.clearAllData();

// Or clear entire database (DANGER!)
await seeder.clearEntireDatabase();

// Then re-seed
await seeder.seedAll();
```

---

## ⚠️ Important Notes

### Profile Pictures
- Using placeholder avatars from Pravatar
- Replace with real photos for production
- Upload to Cloudinary and update `photoUrl`

### Phone Numbers
- All use +91 (India) prefix
- Format: +91 98765 432XX
- Sequential for easy testing

### Locations
- Real neighborhoods in major cities
- Can be used for location-based search
- Add more cities as needed

---

## 🎯 Quick Commands

```dart
// Seed everything
await FirebaseSeeder().seedAll();

// Check status
await FirebaseSeeder().checkDatabaseStatus();

// Clear and start fresh
await FirebaseSeeder().clearAllData();
await FirebaseSeeder().seedAll();

// Nuclear option (clears EVERYTHING)
await FirebaseSeeder().clearEntireDatabase();
```

---

## ✨ Result

After seeding, you'll have:
- ✅ 16 caregivers with photos
- ✅ 21 service packages
- ✅ India-based locations
- ✅ Realistic ratings and bookings
- ✅ Diverse specialties
- ✅ Ready for demo/testing

**Total Documents:** 37 (16 caregivers + 21 packages)

---

**Ready to seed!** 🌱
