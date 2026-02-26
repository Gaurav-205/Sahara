import 'package:flutter/material.dart';

/// ZestDrop Color Palette - Clean & Modern
/// Inspired by the ZestDrop brand with smooth blue gradients
/// 
/// Primary: Deep Navy Blue - Professional, trustworthy, bold
/// Secondary: Medium Blue - Balanced, approachable
/// Accent: Sky Blue - Fresh, calming, friendly
/// Light: Pale Blue - Soft, clean background
/// 
/// This palette follows Material Design 3 principles with proper contrast ratios
/// for accessibility (WCAG AA compliance)

class AppColors {
  // ============================================================================
  // PRIMARY COLORS - Deep Navy Blue (Professional & Bold)
  // ============================================================================
  
  /// Main brand color - Deep Navy Blue
  static const Color primary = Color(0xFF0B3D6B);
  static const Color primaryLight = Color(0xFF1A5A8F);
  static const Color primaryDark = Color(0xFF062847);
  static const Color primaryContainer = Color(0xFFE3EDF7);
  
  // ============================================================================
  // SECONDARY COLORS - Medium Blue (Balanced & Approachable)
  // ============================================================================
  
  /// Secondary brand color - Medium Blue
  static const Color secondary = Color(0xFF4A8FD9);
  static const Color secondaryLight = Color(0xFF6BA8E3);
  static const Color secondaryDark = Color(0xFF3576BD);
  static const Color secondaryContainer = Color(0xFFE8F3FC);
  
  // ============================================================================
  // ACCENT COLORS - Sky Blue (Fresh & Calming)
  // ============================================================================
  
  /// Accent color - Sky Blue
  static const Color accent = Color(0xFF7DB4E8);
  static const Color accentLight = Color(0xFF9DC7EE);
  static const Color accentDark = Color(0xFF5C9FDB);
  static const Color accentContainer = Color(0xFFEFF7FD);
  
  // ============================================================================
  // TERTIARY COLOR - Pale Blue (Soft & Clean)
  // ============================================================================
  
  /// Tertiary color - Pale Blue
  static const Color tertiary = Color(0xFFD4E7F5);
  static const Color tertiaryLight = Color(0xFFE8F3FA);
  static const Color tertiaryDark = Color(0xFFB8D5E8);
  
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
  
  /// Primary gradient - Deep Navy to Medium Blue
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0B3D6B), Color(0xFF1A5A8F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Secondary gradient - Medium Blue to Sky Blue
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF4A8FD9), Color(0xFF6BA8E3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Accent gradient - Sky Blue to Pale Blue
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF7DB4E8), Color(0xFFD4E7F5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Vibrant gradient - Deep Navy through all blues
  static const LinearGradient vibrantGradient = LinearGradient(
    colors: [Color(0xFF0B3D6B), Color(0xFF4A8FD9), Color(0xFF7DB4E8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Neutral gradient - Pale blue to white
  static const LinearGradient neutralGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFEFF7FD)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // ============================================================================
  // SHADOW COLORS
  // ============================================================================
  
  /// Soft shadows for elevation
  static Color shadow = const Color(0xFF0B3D6B).withValues(alpha: 0.12);
  static Color shadowLight = const Color(0xFF0B3D6B).withValues(alpha: 0.06);
  static Color shadowDark = const Color(0xFF0B3D6B).withValues(alpha: 0.18);
  
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
  static const Color star = Color(0xFF4A8FD9);
  
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
