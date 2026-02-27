/// Application Configuration
/// 
/// This file contains all configuration constants for the app.
/// For production, these should be loaded from environment variables.
class AppConfig {
  // Cloudinary Configuration
  // TODO: Replace with your actual credentials or load from environment
  // Get these from: https://console.cloudinary.com/
  static const String cloudinaryCloudName = 'dmbxyvrcc';
  static const String cloudinaryUploadPreset = 'sahara_uploads';
  
  // App Configuration
  static const String appName = 'Sahara Pet Care';
  static const String appPrimaryColor = '#1A2332';
  
  // Validation
  static bool get isCloudinaryConfigured => 
      cloudinaryCloudName.isNotEmpty && 
      cloudinaryUploadPreset.isNotEmpty;
}
