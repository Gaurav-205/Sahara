# Sahara Pet Care - Dog Owner App

A Flutter-based dog care booking platform for dog owners to find and book professional dog care services.

## ✨ Features

- **Dog Management**: Add, edit, and manage your dogs with photos
- **Service Booking**: Book services (Dog Walking, Dog Sitting, Dog Grooming, Dog Training, Vet Visits)
- **Specialized Caregivers**: Browse 12 dog care specialists with breed expertise
- **Real-time Messaging**: Chat with caregivers
- **Booking Tracking**: View and manage your bookings
- **Profile Management**: Update your profile and preferences
- **Push Notifications**: Stay updated with booking status
- **Simple Booking Flow**: No payment required - book instantly!

## 🐕 Dog-Specific Services

### Dog Walking
- Quick Potty Break (15 min)
- Basic Walk (30 min)
- Standard Adventure (1 hour)
- Premium Trail Experience (2 hours)

### Dog Sitting
- Basic Home Care (4 hours)
- Full Day Care (8 hours)
- Overnight Care (24 hours)
- Extended Stay (multi-day)

### Dog Grooming
- Bath & Brush
- Full Grooming
- Luxury Spa Package
- De-Shedding Treatment

### Dog Training
- Basic Obedience
- Puppy Foundation
- Advanced Training
- Behavior Modification
- 5-Session Package

### Vet Visit Companion
- Transportation
- Full Companion
- Complete Care
- Emergency Support

## 🚀 Tech Stack

- **Framework**: Flutter 3.x
- **Backend**: Firebase (Auth, Firestore, Messaging)
- **Image Storage**: Cloudinary
- **State Management**: Provider
- **Authentication**: Email/Password + Google Sign-In
- **Maps**: Google Maps

## 📁 Project Structure

```
lib/
├── config/          # App configuration
├── models/          # Data models (8 files)
├── providers/       # State management (4 files)
├── screens/         # UI screens (23 files)
├── services/        # Business logic (10 files)
├── theme/           # App theme & colors
├── utils/           # Utilities & helpers
└── widgets/         # Reusable components (10 files)
```

## ⚡ Quick Start

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Configure Credentials
Edit `lib/config/app_config.dart` with your credentials:
- Cloudinary (from https://console.cloudinary.com/)

### 3. Setup Firebase
- Add `google-services.json` to `android/app/`
- Deploy Firestore rules from `FIRESTORE_RULES_FINAL.txt`

### 4. Run the App
```bash
flutter run
```

### 5. Seed Database (First Time Only)
- Login → Profile → Seed Database

## 📚 Documentation

- **[SETUP_GUIDE.md](SETUP_GUIDE.md)** - Complete setup instructions
- **[PROJECT_STATUS.md](PROJECT_STATUS.md)** - Current project status
- **[OPTIMIZATION_SUMMARY.md](OPTIMIZATION_SUMMARY.md)** - Recent optimizations
- **[QUICK_START_CHECKLIST.md](QUICK_START_CHECKLIST.md)** - Setup checklist
- **[docs/](docs/)** - Additional documentation

## 🎨 Design System

- **Primary**: Navy (#1A2332)
- **Secondary**: Orange (#FF6B35)
- **Accent**: Sky Blue (#4ECDC4)
- **Font**: Montserrat

## 🔧 Key Services

- **AuthService** - User authentication
- **FirestoreService** - Database operations
- **CloudinaryService** - Image uploads
- **PaymentService** - Razorpay integration
- **ChatService** - Real-time messaging
- **NotificationService** - Push notifications

## ⚠️ Important Notes

- This is a dog owner-only app (caregivers are seeded data)
- 12 specialized dog caregivers with breed expertise
- 24 comprehensive dog service packages
- Requires Firebase and Cloudinary configuration
- No payment integration - bookings complete instantly
- See `docs/DOG_SEED_DATA_GUIDE.md` for seed data details
- See `PAYMENT_REMOVAL_AND_FIXES.md` for recent changes

## 📄 License

Proprietary - All rights reserved
