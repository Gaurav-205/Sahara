# Sound Files Setup

## Required Sound Files

Place the following MP3 files in the `assets/sounds/` directory:

### 1. success.mp3
- **Usage**: Login success, signup success, password reset sent
- **Type**: Pleasant chime or ding
- **Duration**: 0.5-1 second
- **Suggested**: Positive notification sound

### 2. error.mp3
- **Usage**: Login failed, validation errors, network errors
- **Type**: Subtle error tone
- **Duration**: 0.3-0.5 seconds
- **Suggested**: Gentle error beep (not harsh)

### 3. click.mp3
- **Usage**: Button presses (Sign In, Sign Up, Send Reset Link)
- **Type**: Soft click or tap
- **Duration**: 0.1-0.2 seconds
- **Suggested**: UI button click sound

### 4. tap.mp3
- **Usage**: Light interactions (user type selection, navigation)
- **Type**: Very light tap
- **Duration**: 0.05-0.1 seconds
- **Suggested**: Subtle tap sound

### 5. notification.mp3
- **Usage**: Important messages, alerts
- **Type**: Gentle notification
- **Duration**: 0.5-1 second
- **Suggested**: Soft notification chime

### 6. swipe.mp3
- **Usage**: Page transitions, onboarding swipes
- **Type**: Whoosh or swipe
- **Duration**: 0.2-0.3 seconds
- **Suggested**: Smooth transition sound

## Where to Get Free Sound Effects

### Recommended Sources:
1. **Pixabay** (https://pixabay.com/sound-effects/)
   - Free for commercial use
   - No attribution required
   - Search: "button click", "success", "error", "notification"

2. **Freesound** (https://freesound.org/)
   - Free sounds with Creative Commons licenses
   - Check license requirements
   - High quality sounds

3. **Zapsplat** (https://www.zapsplat.com/)
   - Free sound effects
   - Requires attribution for free tier
   - Professional quality

4. **Mixkit** (https://mixkit.co/free-sound-effects/)
   - Free for commercial use
   - No attribution required
   - UI sound effects available

### Search Terms:
- "UI button click"
- "success notification"
- "error beep"
- "tap sound"
- "notification chime"
- "swipe whoosh"

## File Requirements

- **Format**: MP3 (recommended for compatibility)
- **Sample Rate**: 44.1 kHz or 48 kHz
- **Bit Rate**: 128 kbps or higher
- **Channels**: Mono or Stereo
- **File Size**: Keep under 50KB per file for optimal performance

## Alternative: Use System Sounds

If you don't want to add custom sounds, the app will work without them. The SoundService has try-catch blocks that silently fail if sound files are not found.

## Testing Sounds

After adding sound files:
1. Run `flutter pub get`
2. Run the app
3. Test each interaction:
   - Login button → click.mp3
   - Success login → success.mp3
   - Error message → error.mp3
   - User type selection → tap.mp3
   - Page swipe → swipe.mp3

## Volume Control

Sounds are set to 50% volume by default. Users can toggle sounds on/off in settings (to be implemented).

## Current Implementation

Sounds are integrated into:
- ✅ Login screen (click, success, error)
- ✅ Signup screen (click, tap, success, error)
- ✅ Forgot password screen (click, success, error)
- ✅ Onboarding screen (swipe, tap)

## Disable Sounds

To disable sounds globally, set in `lib/services/sound_service.dart`:
```dart
bool _soundEnabled = false; // Change to false
```

Or users can toggle in app settings (feature to be added).
