import 'package:flutter/material.dart';

/// Modern Pet Care Color Palette - Bold & Vibrant
/// Inspired by modern, energetic design with strong contrast
/// 
/// Primary: Deep Navy - Professional, trustworthy, bold
/// Secondary: Vibrant Orange - Energetic, friendly, warm
/// Accent: Sky Blue - Fresh, calming, approachable
/// 
/// This palette follows Material Design 3 principles with proper contrast ratios
/// for accessibility (WCAG AA compliance)

class AppColors {
  // ============================================================================
  // PRIMARY COLORS - Deep Navy (Professional & Bold)
  // ============================================================================
  
  /// Main brand color - Deep Navy
  static const Color primary = Color(0xFF16056B);
  static const Color primaryLight = Color(0xFF2D1B8F);
  static const Color primaryDark = Color(0xFF0D0347);
  static const Color primaryContainer = Color(0xFFE8E5F5);
  
  // ============================================================================
  // SECONDARY COLORS - Vibrant Orange (Energetic & Warm)
  // ============================================================================
  
  /// Secondary brand color - Vibrant Orange
  static const Color secondary = Color(0xFFFD9519);
  static const Color secondaryLight = Color(0xFFFDB04D);
  static const Color secondaryDark = Color(0xFFE67E00);
  static const Color secondaryContainer = Color(0xFFFFEDD5);
  
  // ============================================================================
  // ACCENT COLORS - Sky Blue (Fresh & Calming)
  // ============================================================================
  
  /// Accent color - Sky Blue
  static const Color accent = Color(0xFF5696FA);
  static const Color accentLight = Color(0xFF8BB5FB);
  static const Color accentDark = Color(0xFF2B7BF7);
  static const Color accentContainer = Color(0xFFE3EFFF);
  
  // ============================================================================
  // TERTIARY COLOR - Light Blue
  // ============================================================================
  
  /// Tertiary color - Light Blue
  static const Color tertiary = Color(0xFFB4D7FE);
  static const Color tertiaryLight = Color(0xFFD4E8FF);
  static const Color tertiaryDark = Color(0xFF8FC3FD);
  
  // ============================================================================
  // NEUTRAL COLORS - Cool Grays
  // ============================================================================
  
  /// Background colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);
  
  /// Text colors with proper contrast
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textDisabled = Color(0xFFCBD5E1);
  
  /// Border colors
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);
  static const Color divider = Color(0xFFE2E8F0);
  
  // ============================================================================
  // SEMANTIC COLORS
  // ============================================================================
  
  /// Success - Emerald Green
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF6EE7B7);
  static const Color successContainer = Color(0xFFD1FAE5);
  
  /// Warning - Amber
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningContainer = Color(0xFFFEF3C7);
  
  /// Error - Rose Red
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorContainer = Color(0xFFFEE2E2);
  
  /// Info - Sky Blue
  static const Color info = Color(0xFF0EA5E9);
  static const Color infoLight = Color(0xFF38BDF8);
  static const Color infoContainer = Color(0xFFE0F2FE);
  
  // ============================================================================
  // GRADIENT COLORS
  // ============================================================================
  
  /// Primary gradient - Navy to Purple
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF16056B), Color(0xFF2D1B8F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Secondary gradient - Orange to Light Orange
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFFFD9519), Color(0xFFFDB04D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Accent gradient - Sky Blue to Light Blue
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF5696FA), Color(0xFFB4D7FE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Vibrant gradient - Navy to Orange to Blue
  static const LinearGradient vibrantGradient = LinearGradient(
    colors: [Color(0xFF16056B), Color(0xFFFD9519), Color(0xFF5696FA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Neutral gradient - Cool whites
  static const LinearGradient neutralGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // ============================================================================
  // SHADOW COLORS
  // ============================================================================
  
  /// Soft shadows for elevation
  static Color shadow = const Color(0xFF16056B).withValues(alpha: 0.12);
  static Color shadowLight = const Color(0xFF16056B).withValues(alpha: 0.06);
  static Color shadowDark = const Color(0xFF16056B).withValues(alpha: 0.18);
  
  // ============================================================================
  // OVERLAY COLORS
  // ============================================================================
  
  /// Overlay for modals and dialogs
  static Color overlay = const Color(0xFF000000).withValues(alpha: 0.5);
  static Color overlayLight = const Color(0xFF000000).withValues(alpha: 0.3);
  
  // ============================================================================
  // SPECIAL COLORS
  // ============================================================================
  
  /// Shimmer effect colors
  static const Color shimmerBase = Color(0xFFE2E8F0);
  static const Color shimmerHighlight = Color(0xFFF1F5F9);
  
  /// Rating star color
  static const Color star = Color(0xFFFD9519);
  
  /// Online status indicator
  static const Color online = Color(0xFF10B981);
  static const Color offline = Color(0xFF94A3B8);
  
  // ============================================================================
  // HELPER METHODS
  // ============================================================================
  
  /// Get color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }
  
  /// Get lighter shade of color
  static Color lighten(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }
  
  /// Get darker shade of color
  static Color darken(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }
}
