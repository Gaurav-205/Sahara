# Quick Setup - Connect Nothing Phone

## Current Status
✅ Flutter installed correctly
✅ Android SDK installed
✅ ADB available at: `C:\Users\gaura\AppData\Local\Android\Sdk\platform-tools\adb.exe`
❌ No phone detected yet

## Quick 5-Step Setup

### Step 1: Enable Developer Mode on Nothing Phone
1. Open **Settings** on your Nothing phone
2. Go to **About phone**
3. Tap **Build number** 7 times rapidly
4. Enter your PIN/password if prompted
5. You'll see "You are now a developer!"

### Step 2: Enable USB Debugging
1. Go to **Settings** → **System** → **Developer options**
2. Toggle **Developer options** to ON
3. Scroll down and enable **USB debugging**
4. Enable **Install via USB** (if available)

### Step 3: Connect Phone
1. Connect your Nothing phone to PC using USB cable
2. Make sure to use a data cable (not charge-only)
3. On your phone, you'll see a popup: **"Allow USB debugging?"**
4. Check **"Always allow from this computer"**
5. Tap **Allow**

### Step 4: Verify Connection
Run this command:
```powershell
flutter devices
```

You should see your Nothing phone listed like:
```
Nothing Phone (mobile) • ABC123 • android-arm64 • Android 13
```

### Step 5: Run the App
```powershell
flutter run
```

## If Phone Not Detected

### Quick Fixes

1. **Change USB Mode on Phone**
   - Pull down notification shade
   - Tap "USB charging this device"
   - Select **"File Transfer"** or **"PTP"**

2. **Restart ADB**
   ```powershell
   & "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" kill-server
   & "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" start-server
   & "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" devices
   ```

3. **Try Different USB Port**
   - Use USB 2.0 port (black) instead of USB 3.0 (blue)
   - Or vice versa

4. **Try Different Cable**
   - Some cables are charge-only
   - Use the original Nothing phone cable

5. **Restart Both Devices**
   - Restart your Nothing phone
   - Restart your PC

## Check Connection Status

Run these commands to diagnose:

```powershell
# Check if ADB sees your phone
& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" devices

# Check Flutter devices
flutter devices

# If you see "unauthorized", disconnect phone and reconnect
# Then allow USB debugging popup on phone
```

## Expected Output When Working

```powershell
PS> flutter devices
Found 4 connected devices:
  Nothing Phone (mobile) • ABC123XYZ • android-arm64 • Android 13 (API 33)
  Windows (desktop)      • windows   • windows-x64   • Microsoft Windows
  Chrome (web)           • chrome    • web-javascript • Google Chrome
  Edge (web)             • edge      • web-javascript • Microsoft Edge
```

## Run Commands

```powershell
# Run in debug mode (with hot reload)
flutter run

# Run in release mode (faster, no debugging)
flutter run --release

# If multiple devices, specify your phone
flutter run -d <device-id>
```

## Troubleshooting

### "unauthorized" in adb devices
1. Disconnect phone
2. Run: `& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" kill-server`
3. Reconnect phone
4. Allow USB debugging popup on phone

### Phone charges but not detected
1. Change USB mode to "File Transfer"
2. Try different USB cable
3. Check if USB debugging is enabled

### Still not working?
See detailed guide: `CONNECT_PHONE_GUIDE.md`

---

**Next**: Follow steps 1-3 above, then run `flutter devices` to verify!
