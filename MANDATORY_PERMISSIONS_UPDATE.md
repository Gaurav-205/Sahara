# Mandatory Permissions Update

**Date**: February 27, 2026  
**Status**: ✅ Complete

---

## 🎯 Changes Made

### Location and Notification - Now REQUIRED

Updated the permissions system to make Location and Notification permissions **mandatory** for using the app, while keeping Camera and Photos as **optional**.

---

## ✅ What's Changed

### Permissions Screen

**Before**:
- All 4 permissions were optional
- User could skip all permissions
- No indication of which were important

**After**:
- Location and Notifications are **REQUIRED**
- Camera and Photos are **OPTIONAL**
- Clear visual indicators (red badges)
- Cannot skip mandatory permissions
- User must grant Location & Notifications to continue

### Visual Changes

1. **Header Badge**:
   - Red badge: "Location & Notifications are required"
   - Positioned below subtitle

2. **Permission Cards**:
   - Location card: Red "REQUIRED" badge, red border
   - Notifications card: Red "REQUIRED" badge, red border
   - Camera card: No badge, normal border
   - Photos card: No badge, normal border

3. **Card Order** (Priority):
   1. Location (REQUIRED)
   2. Notifications (REQUIRED)
   3. Camera (Optional)
   4. Photos (Optional)

4. **Button**:
   - Changed from "Continue" to "Grant Permissions"
   - Info text: "Camera and Photos can be granted later when needed"
   - Removed "Skip for now" button

### Permission Flow

**Mandatory Permissions (Location & Notifications)**:
1. User taps "Grant Permissions"
2. Location permission requested first
3. Notifications permission requested second
4. If either denied:
   - Error dialog shown
   - Options: "Exit App" or "Try Again"
   - User must grant to continue
5. If both granted:
   - Optional permissions requested (Camera & Photos)
   - User can deny these without blocking app

**Optional Permissions (Camera & Photos)**:
- Requested after mandatory permissions
- Can be denied without blocking app
- Will be requested again when needed (e.g., uploading profile photo)

---

## 🔒 Why These Permissions Are Required

### Location (REQUIRED)
- **Core Feature**: Finding nearby caregivers
- **User Benefit**: See caregivers in your area
- **Without it**: Cannot use main app functionality
- **Privacy**: Only used when searching for caregivers

### Notifications (REQUIRED)
- **Core Feature**: Booking updates and reminders
- **User Benefit**: Stay informed about bookings
- **Without it**: Miss important booking updates
- **Privacy**: Only app-related notifications

### Camera (OPTIONAL)
- **Feature**: Take photos for profile and pets
- **User Benefit**: Quick photo capture
- **Without it**: Can still use gallery
- **Alternative**: Gallery/Photos permission

### Photos (OPTIONAL)
- **Feature**: Select images from gallery
- **User Benefit**: Choose existing photos
- **Without it**: Can still use camera
- **Alternative**: Camera permission

---

## 📱 User Experience

### First Launch Flow

```
Splash Screen (2.8s)
  ↓
Permissions Screen
  ↓
[User taps "Grant Permissions"]
  ↓
Location Permission Dialog
  ↓
  ├─ Granted → Continue
  └─ Denied → Error Dialog
              ├─ Exit App
              └─ Try Again
  ↓
Notifications Permission Dialog
  ↓
  ├─ Granted → Continue
  └─ Denied → Error Dialog
              ├─ Exit App
              └─ Try Again
  ↓
Camera Permission Dialog (Optional)
  ↓
  ├─ Granted → Continue
  └─ Denied → Continue anyway
  ↓
Photos Permission Dialog (Optional)
  ↓
  ├─ Granted → Continue
  └─ Denied → Continue anyway
  ↓
Onboarding Screen
  ↓
Login/Signup
```

### Error Dialog (When Mandatory Permission Denied)

**Title**: "Required Permissions"

**Message**: 
"Location and Notification permissions are required to use Sahara. Location helps you find nearby caregivers, and notifications keep you updated on bookings."

**Actions**:
- **Exit App** (red text) - Closes the app
- **Try Again** (primary button) - Requests permissions again

---

## 🎨 Visual Design

### Permission Cards

**Required Cards** (Location & Notifications):
```
┌─────────────────────────────────────┐
│  [Icon]  Location      [REQUIRED]   │
│          Find nearby caregivers     │
│          and services               │
└─────────────────────────────────────┘
  Red border (2px)
  Red "REQUIRED" badge
```

**Optional Cards** (Camera & Photos):
```
┌─────────────────────────────────────┐
│  [Icon]  Camera                     │
│          Take photos for your       │
│          profile and pets           │
└─────────────────────────────────────┘
  Normal border (1px)
  No badge
```

### Colors
- **Required Badge**: Red (#FF0000)
- **Required Border**: Red with 30% opacity
- **Normal Border**: Light Gray
- **Icons**: Navy, Orange, Sky Blue, Tertiary

---

## 🔧 Technical Implementation

### Permission Request Order

```dart
// 1. Request MANDATORY permissions
final locationGranted = await _permissionService.requestLocationPermission(context);
final notificationGranted = await _permissionService.requestNotificationPermission(context);

// 2. Check if mandatory permissions granted
if (!locationGranted || !notificationGranted) {
  // Show error dialog
  // User must grant or exit app
  return;
}

// 3. Request OPTIONAL permissions
await _permissionService.requestCameraPermission(context);
await _permissionService.requestPhotosPermission(context);

// 4. Continue to app
Navigator.pop(context, true);
```

### Error Handling

```dart
// If mandatory permission denied
showDialog(
  barrierDismissible: false, // Cannot dismiss
  builder: (context) => AlertDialog(
    title: 'Required Permissions',
    content: 'Location and Notification permissions are required...',
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context, false); // Exit app
        },
        child: Text('Exit App'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          _requestPermissions(); // Try again
        },
        child: Text('Try Again'),
      ),
    ],
  ),
);
```

---

## 📊 Permission Matrix

| Permission    | Status     | When Requested | Can Skip | Blocks App |
|---------------|------------|----------------|----------|------------|
| Location      | REQUIRED   | First launch   | No       | Yes        |
| Notifications | REQUIRED   | First launch   | No       | Yes        |
| Camera        | OPTIONAL   | First launch   | Yes      | No         |
| Photos        | OPTIONAL   | First launch   | Yes      | No         |

---

## 🧪 Testing Checklist

### Mandatory Permissions
- [ ] Location permission requested first
- [ ] Notifications permission requested second
- [ ] Error dialog shows if Location denied
- [ ] Error dialog shows if Notifications denied
- [ ] "Exit App" button closes app
- [ ] "Try Again" button re-requests permissions
- [ ] Cannot proceed without both permissions
- [ ] Dialog cannot be dismissed by tapping outside

### Optional Permissions
- [ ] Camera permission requested after mandatory
- [ ] Photos permission requested after mandatory
- [ ] Can deny Camera and still proceed
- [ ] Can deny Photos and still proceed
- [ ] Camera requested again when taking photo
- [ ] Photos requested again when selecting image

### Visual
- [ ] Location card has red border
- [ ] Notifications card has red border
- [ ] Location card has "REQUIRED" badge
- [ ] Notifications card has "REQUIRED" badge
- [ ] Camera card has normal border
- [ ] Photos card has normal border
- [ ] Header shows red badge
- [ ] Button says "Grant Permissions"
- [ ] Info text shows below button

---

## 📝 User Communication

### Why We Need These Permissions

**In-App Messages**:
1. **Permissions Screen**: Clear explanation for each permission
2. **Error Dialog**: Explains why Location & Notifications are required
3. **Info Text**: "Camera and Photos can be granted later when needed"

**User Benefits**:
- **Location**: Find the best caregivers near you
- **Notifications**: Never miss a booking update
- **Camera**: Quick photo capture (optional)
- **Photos**: Choose from your gallery (optional)

---

## 🚀 Deployment Notes

### Before Release
1. ✅ Test on real Android device
2. ✅ Test permission denial scenarios
3. ✅ Test "Exit App" functionality
4. ✅ Test "Try Again" functionality
5. ✅ Verify error messages are clear
6. ✅ Test optional permissions can be skipped

### App Store Description
Include in app description:
- "Location permission required to find nearby caregivers"
- "Notification permission required for booking updates"
- "Camera and photo permissions optional for profile pictures"

---

## ✅ Summary

**Changes**:
- ✅ Location: Now REQUIRED
- ✅ Notifications: Now REQUIRED
- ✅ Camera: Remains OPTIONAL
- ✅ Photos: Remains OPTIONAL
- ✅ Visual indicators added (red badges, borders)
- ✅ Error dialog for denied mandatory permissions
- ✅ Removed skip button
- ✅ Clear user communication

**Result**: Users must grant Location and Notifications to use the app, ensuring core functionality works properly while keeping photo permissions optional for better user experience.

---

**Status**: ✅ Complete and ready for testing!
