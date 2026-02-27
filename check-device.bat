@echo off
echo ========================================
echo Checking Device Connection Status
echo ========================================
echo.

echo [1] Checking ADB devices...
"%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe" devices
echo.

echo [2] Checking Flutter devices...
flutter devices
echo.

echo ========================================
echo If your phone is not listed above:
echo 1. Enable USB debugging on your phone
echo 2. Connect phone via USB cable
echo 3. Allow USB debugging popup on phone
echo 4. Run this script again
echo ========================================
echo.
pause
