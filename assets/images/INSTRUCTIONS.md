# Logo Instructions

## How to Add Your Logo

1. **Prepare your logo image:**
   - Recommended size: 512x512 pixels or larger (square format)
   - Supported formats: PNG (with transparency), JPG, or WEBP
   - File name: `logo.png`

2. **Add the logo:**
   - Place your logo file in this folder: `assets/images/`
   - Name it exactly: `logo.png`

3. **Run the app:**
   - The splash screen will automatically display your logo
   - If no logo is found, it will show a default paw icon

## Logo Guidelines

- **Square format** works best (1:1 aspect ratio)
- **Transparent background** (PNG) recommended for best results
- **High resolution** for crisp display on all devices
- **Simple design** that works well at small sizes

## Example File Structure

```
assets/
  images/
    logo.png          <- Your logo here
    INSTRUCTIONS.md   <- This file
  icons/
```

## Testing

After adding your logo:
1. Run `flutter pub get` to ensure assets are recognized
2. Run the app to see your logo on the splash screen
3. The logo will appear in a white rounded square container

## Fallback

If the logo file is not found or fails to load, the app will automatically show a default paw icon instead.
