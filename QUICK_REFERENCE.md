# Sahara Pet Care - Quick Reference

## 🚀 Getting Started

```bash
# Clean and setup
flutter clean && flutter pub get

# Run the app
flutter run

# Build for release
flutter build apk --release  # Android
flutter build ios --release  # iOS
```

## 📝 Configuration Files

| File | Purpose |
|------|---------|
| `lib/config/app_config.dart` | App credentials (Cloudinary, Razorpay) |
| `android/app/google-services.json` | Firebase Android config |
| `ios/Runner/GoogleService-Info.plist` | Firebase iOS config |
| `FIRESTORE_RULES_FINAL.txt` | Firestore security rules |
| `.env.example` | Environment variable template |

## 🔑 Required Credentials

### Cloudinary
```dart
// lib/config/app_config.dart
cloudinaryCloudName = 'your_cloud_name'
cloudinaryUploadPreset = 'your_upload_preset'
```
Get from: https://console.cloudinary.com/

### Razorpay
```dart
// lib/config/app_config.dart
razorpayKeyId = 'your_key_id'
razorpayKeySecret = 'your_key_secret'
```
Get from: https://dashboard.razorpay.com/

## 📂 Project Structure

```
sahara/
├── lib/
│   ├── config/          # Configuration
│   ├── models/          # Data models
│   ├── providers/       # State management
│   ├── screens/         # UI screens
│   ├── services/        # Business logic
│   ├── theme/           # Styling
│   ├── utils/           # Utilities
│   ├── widgets/         # Reusable components
│   └── main.dart        # Entry point
├── android/             # Android platform
├── ios/                 # iOS platform
├── docs/                # Documentation
└── assets/              # Images, sounds, icons
```

## 🎯 Key Features

| Feature | Files |
|---------|-------|
| Authentication | `providers/auth_provider.dart`, `services/auth_service.dart` |
| Pet Management | `providers/pet_provider.dart`, `services/pet_service.dart` |
| Bookings | `providers/booking_provider.dart`, `services/firestore_service.dart` |
| Payments | `services/payment_service.dart` |
| Messaging | `services/chat_service.dart` |
| Notifications | `services/notification_service.dart` |
| Image Upload | `services/cloudinary_service.dart` |

## 🛠️ Common Commands

### Development
```bash
# Hot reload (r in terminal)
# Hot restart (R in terminal)
# Quit (q in terminal)

# Run with specific device
flutter run -d <device_id>

# List devices
flutter devices

# Check for issues
flutter doctor
```

### Debugging
```bash
# View logs
flutter logs

# Clear cache
flutter clean

# Analyze code
flutter analyze

# Format code
dart format lib/
```

### Building
```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 🔍 Troubleshooting

### Build Errors
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

### Android Issues
```bash
cd android
./gradlew clean
cd ..
flutter clean
```

### iOS Issues
```bash
cd ios
pod deinstall
pod install
cd ..
flutter clean
```

### Firebase Issues
- Check `google-services.json` is in `android/app/`
- Check `GoogleService-Info.plist` is in `ios/Runner/`
- Verify Firebase project configuration
- Deploy Firestore rules

### Image Upload Issues
- Verify Cloudinary credentials in `lib/config/app_config.dart`
- Check internet connection
- Verify upload preset exists in Cloudinary

### Payment Issues
- Verify Razorpay credentials in `lib/config/app_config.dart`
- Use test mode for development
- Check Razorpay dashboard for logs

## 📚 Documentation

| Document | Description |
|----------|-------------|
| `README.md` | Project overview |
| `SETUP_GUIDE.md` | Detailed setup instructions |
| `PROJECT_STATUS.md` | Current status and TODOs |
| `OPTIMIZATION_SUMMARY.md` | Recent optimizations |
| `QUICK_START_CHECKLIST.md` | Setup checklist |
| `docs/OPTIMIZATION_CHECKLIST.md` | Post-optimization steps |

## 🎨 Design Tokens

```dart
// Colors
AppColors.primary        // #1A2332 (Navy)
AppColors.secondary      // #FF6B35 (Orange)
AppColors.accent         // #4ECDC4 (Sky Blue)
AppColors.background     // #F8F9FA
AppColors.surface        // #FFFFFF
AppColors.error          // #DC3545

// Typography
fontFamily: 'Montserrat'
```

## 🔐 Security Notes

- Never commit `.env` files
- Never commit `google-services.json` or `GoogleService-Info.plist`
- Keep API keys secure
- Use environment variables in production
- Implement backend for payment processing

## 📱 Testing

### Manual Testing Checklist
- [ ] User registration
- [ ] User login
- [ ] Google Sign-In
- [ ] Pet CRUD operations
- [ ] Service booking flow
- [ ] Caregiver browsing
- [ ] Chat messaging
- [ ] Payment flow (test mode)
- [ ] Notifications

### Test Accounts
Create test accounts for:
- Owner user
- Test payments (Razorpay test mode)

## 🚨 Known Issues

See `PROJECT_STATUS.md` for:
- Current TODOs
- Known limitations
- Planned improvements

## 💡 Tips

1. Use `flutter clean` when switching branches
2. Run `flutter pub get` after pulling changes
3. Check `flutter doctor` for environment issues
4. Use hot reload (r) for quick UI changes
5. Use hot restart (R) for state changes
6. Check Firebase console for backend issues
7. Use Cloudinary console to verify uploads
8. Use Razorpay dashboard for payment logs

## 📞 Support

For issues:
1. Check documentation in `docs/`
2. Review `PROJECT_STATUS.md` for known issues
3. Check Firebase, Cloudinary, and Razorpay consoles
4. Run `flutter doctor` for environment issues

---
Last Updated: February 27, 2026
