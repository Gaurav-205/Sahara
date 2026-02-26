# Sahara Pet Care - Owner App

A Flutter-based pet care booking platform for pet owners to find and book professional pet care services.

## ✨ Features

- **Pet Management**: Add, edit, and manage your pets with photos
- **Service Booking**: Book services (Dog Walking, Pet Sitting, Grooming, Vet Visits)
- **Caregiver Browsing**: Browse and select from professional caregivers
- **Real-time Messaging**: Chat with caregivers
- **Booking Tracking**: View and manage your bookings
- **Profile Management**: Update your profile and preferences
- **Payment Integration**: Secure payments via Razorpay
- **Push Notifications**: Stay updated with booking status

## 🚀 Tech Stack

- **Framework**: Flutter 3.x
- **Backend**: Firebase (Auth, Firestore, Messaging)
- **Image Storage**: Cloudinary
- **State Management**: Provider
- **Authentication**: Email/Password + Google Sign-In
- **Payments**: Razorpay
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
- Razorpay (from https://dashboard.razorpay.com/)

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

- This is an owner-only app (caregivers are seeded data)
- Requires Firebase, Cloudinary, and Razorpay configuration
- Payment backend integration recommended for production

## 📄 License

Proprietary - All rights reserved
