import 'package:flutter/material.dart';

/// Sahara Design System
/// A comprehensive design system for consistent UI across the app
class DesignSystem {
  // ============================================================================
  // COLORS
  // ============================================================================
  
  /// Primary Colors - Black & White
  static const Color primary = Color(0xFF000000);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFFFFFFF);
  
  /// Text Colors
  static const Color textPrimary = Color(0xFF000000);
  static final Color textSecondary = Colors.grey[600]!;
  static final Color textTertiary = Colors.grey[500]!;
  static final Color textDisabled = Colors.grey[400]!;
  
  /// UI Colors
  static final Color border = Colors.grey[200]!;
  static final Color divider = Colors.grey[100]!;
  static final Color inputBackground = Colors.grey[100]!;
  static final Color cardBackground = Colors.white;
  
  /// Accent Colors
  static const Color accent = Color(0xFFFFB74D); // Amber for highlights
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFF9800);
  
  /// Gradients - Grayscale
  static const LinearGradient gradientBlack = LinearGradient(
    colors: [Color(0xFF000000), Color(0xFF2A2A2A)],
  );
  
  static const LinearGradient gradientDarkGray = LinearGradient(
    colors: [Color(0xFF4A4A4A), Color(0xFF6A6A6A)],
  );
  
  static const LinearGradient gradientMediumGray = LinearGradient(
    colors: [Color(0xFF6A6A6A), Color(0xFF8A8A8A)],
  );
  
  static const LinearGradient gradientLightGray = LinearGradient(
    colors: [Color(0xFF8A8A8A), Color(0xFFAAAAAA)],
  );
  
  // ============================================================================
  // SPACING - 4pt Grid System
  // ============================================================================
  
  static const double space4 = 4.0;
  static const double space6 = 6.0;
  static const double space8 = 8.0;
  static const double space10 = 10.0;
  static const double space12 = 12.0;
  static const double space14 = 14.0;
  static const double space16 = 16.0;
  static const double space18 = 18.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space28 = 28.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;
  
  // ============================================================================
  // BORDER RADIUS
  // ============================================================================
  
  static const double radiusSmall = 10.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 14.0;
  static const double radiusXLarge = 16.0;
  static const double radiusCircle = 100.0;
  
  static const BorderRadius borderRadiusSmall = BorderRadius.all(Radius.circular(radiusSmall));
  static const BorderRadius borderRadiusMedium = BorderRadius.all(Radius.circular(radiusMedium));
  static const BorderRadius borderRadiusLarge = BorderRadius.all(Radius.circular(radiusLarge));
  static const BorderRadius borderRadiusXLarge = BorderRadius.all(Radius.circular(radiusXLarge));
  
  // ============================================================================
  // TYPOGRAPHY - Montserrat Font
  // ============================================================================
  
  static const String fontFamily = 'Montserrat';
  
  /// Display Styles - Large headings
  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    letterSpacing: -0.5,
    fontFamily: fontFamily,
    height: 1.2,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    letterSpacing: -0.5,
    fontFamily: fontFamily,
    height: 1.2,
  );
  
  static const TextStyle displaySmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    letterSpacing: -0.5,
    fontFamily: fontFamily,
    height: 1.2,
  );
  
  /// Headline Styles - Section titles
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    letterSpacing: -0.3,
    fontFamily: fontFamily,
    height: 1.3,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    letterSpacing: -0.3,
    fontFamily: fontFamily,
    height: 1.3,
  );
  
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    letterSpacing: -0.2,
    fontFamily: fontFamily,
    height: 1.3,
  );
  
  /// Title Styles - Card titles, labels
  static const TextStyle titleLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  /// Body Styles - Regular text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: textPrimary,
    fontFamily: fontFamily,
    height: 1.5,
  );
  
  static TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    fontFamily: fontFamily,
    height: 1.5,
  );
  
  static TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textTertiary,
    fontFamily: fontFamily,
    height: 1.5,
  );
  
  /// Label Styles - Small labels, captions
  static const TextStyle labelLarge = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  static TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: textSecondary,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  static TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: textSecondary,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  // ============================================================================
  // ICON SIZES
  // ============================================================================
  
  static const double iconSmall = 16.0;
  static const double iconMedium = 18.0;
  static const double iconRegular = 20.0;
  static const double iconLarge = 22.0;
  static const double iconXLarge = 24.0;
  static const double iconXXLarge = 28.0;
  
  // ============================================================================
  // SHADOWS
  // ============================================================================
  
  /// Minimal shadow for cards
  static List<BoxShadow> shadowCard = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.03),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];
  
  /// Medium shadow for elevated elements
  static List<BoxShadow> shadowElevated = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 12,
      offset: const Offset(0, 3),
    ),
  ];
  
  /// Strong shadow for modals
  static List<BoxShadow> shadowModal = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];
  
  // ============================================================================
  // CARD DECORATIONS
  // ============================================================================
  
  /// Standard card decoration
  static BoxDecoration card({
    Color? color,
    double? borderRadius,
  }) {
    return BoxDecoration(
      color: color ?? cardBackground,
      borderRadius: BorderRadius.circular(borderRadius ?? radiusMedium),
      border: Border.all(color: border, width: 1),
      boxShadow: shadowCard,
    );
  }
  
  /// Elevated card decoration
  static BoxDecoration cardElevated({
    Color? color,
    double? borderRadius,
  }) {
    return BoxDecoration(
      color: color ?? cardBackground,
      borderRadius: BorderRadius.circular(borderRadius ?? radiusMedium),
      border: Border.all(color: border, width: 1),
      boxShadow: shadowElevated,
    );
  }
  
  /// Input field decoration
  static BoxDecoration inputField({
    double? borderRadius,
  }) {
    return BoxDecoration(
      color: inputBackground,
      borderRadius: BorderRadius.circular(borderRadius ?? radiusMedium),
    );
  }
  
  // ============================================================================
  // BUTTON STYLES
  // ============================================================================
  
  /// Primary button style
  static ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
    backgroundColor: primary,
    foregroundColor: onPrimary,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: borderRadiusLarge,
    ),
    elevation: 0,
    textStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      fontFamily: fontFamily,
    ),
  );
  
  /// Secondary button style
  static ButtonStyle buttonSecondary = OutlinedButton.styleFrom(
    foregroundColor: primary,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: borderRadiusLarge,
    ),
    side: BorderSide(color: border, width: 1.5),
    textStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      fontFamily: fontFamily,
    ),
  );
  
  /// Text button style
  static ButtonStyle buttonText = TextButton.styleFrom(
    foregroundColor: primary,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: fontFamily,
    ),
  );
  
  // ============================================================================
  // ANIMATIONS
  // ============================================================================
  
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 200);
  static const Duration animationSlow = Duration(milliseconds: 300);
  
  static const Curve animationCurve = Curves.easeInOutCubic;
  
  // ============================================================================
  // LAYOUT CONSTANTS
  // ============================================================================
  
  /// Standard horizontal padding for screens
  static const double screenPaddingHorizontal = 20.0;
  
  /// Standard vertical padding for screens
  static const double screenPaddingVertical = 20.0;
  
  /// Standard padding for sections
  static const EdgeInsets sectionPadding = EdgeInsets.fromLTRB(20, 24, 20, 0);
  
  /// Standard padding for cards
  static const EdgeInsets cardPadding = EdgeInsets.all(12);
  
  /// Standard padding for list items
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 12);
  
  /// Standard spacing between sections
  static const double sectionSpacing = 24.0;
  
  /// Standard spacing between cards
  static const double cardSpacing = 10.0;
  
  // ============================================================================
  // COMPONENT SIZES
  // ============================================================================
  
  /// Avatar sizes
  static const double avatarSmall = 32.0;
  static const double avatarMedium = 40.0;
  static const double avatarRegular = 48.0;
  static const double avatarLarge = 56.0;
  static const double avatarXLarge = 64.0;
  
  /// Icon container sizes
  static const double iconContainerSmall = 32.0;
  static const double iconContainerMedium = 38.0;
  static const double iconContainerRegular = 42.0;
  static const double iconContainerLarge = 48.0;
  
  /// Button heights
  static const double buttonHeightSmall = 40.0;
  static const double buttonHeightMedium = 48.0;
  static const double buttonHeightLarge = 52.0;
  
  /// Input field heights
  static const double inputHeightSmall = 44.0;
  static const double inputHeightMedium = 48.0;
  static const double inputHeightLarge = 52.0;
  
  // ============================================================================
  // HELPER METHODS
  // ============================================================================
  
  /// Create a gradient icon container
  static Widget gradientIconContainer({
    required IconData icon,
    required LinearGradient gradient,
    double size = iconContainerMedium,
    double iconSize = iconMedium,
    double borderRadius = radiusSmall,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(
        icon,
        size: iconSize,
        color: onPrimary,
      ),
    );
  }
  
  /// Create a circular avatar with gradient
  static Widget gradientAvatar({
    required IconData icon,
    required LinearGradient gradient,
    double size = avatarRegular,
    double iconSize = iconLarge,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: gradient,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: iconSize,
        color: onPrimary,
      ),
    );
  }
}
