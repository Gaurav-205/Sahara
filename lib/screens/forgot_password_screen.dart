import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../theme/app_colors.dart';
import '../services/sound_service.dart';
import '../utils/validators.dart';

/// Forgot Password Screen - Password reset via email
/// 
/// This screen allows users to reset their password by receiving a password
/// reset link via email. Uses Firebase Authentication's password reset feature.
/// 
/// Flow:
/// 1. User enters their registered email address
/// 2. System validates email format
/// 3. Firebase sends password reset email
/// 4. User receives email with reset link
/// 5. User clicks link and sets new password (handled by Firebase)
/// 6. Success message shown and user returns to login
/// 
/// Design Principles:
/// - Clean, minimal form design with focus on usability
/// - Smooth entrance animations (fade + slide)
/// - Consistent theme colors (Navy primary, Orange accents)
/// - Responsive layout for all screen sizes
/// - 8px grid spacing system
/// - Professional error and success handling
/// - Sound feedback for user actions
/// 
/// Features:
/// - Email validation with regex
/// - Loading states during password reset request
/// - Success messages with green snackbar
/// - Error messages with red snackbar
/// - Sound feedback (click, success, error, tap)
/// - Smooth navigation transitions
/// - Auto-navigation back to login after success
/// - Back to login link
/// 
/// Backend Integration:
/// - Uses AuthProvider.resetPassword()
/// - Connects to AuthService.resetPassword()
/// - Firebase Auth sendPasswordResetEmail()
/// - Proper error handling for Firebase exceptions
/// 
/// Theme Colors Used:
/// - Background: Surface (white)
/// - Logo fallback: Primary (Navy)
/// - Title text: Text Primary (dark slate)
/// - Subtitle text: Text Secondary (medium slate)
/// - Primary button: Secondary (Orange)
/// - Links: Primary (Navy)
/// - Success: Success (emerald green)
/// - Error: Error (rose red)
/// - AppBar back button: Text Primary
/// 
/// Animations:
/// - Entrance fade-in: 800ms with easeIn (0-60%)
/// - Entrance slide-up: 800ms with easeOutCubic (20-100%)
/// - Navigation transitions: Instant pop after 1.5s delay
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with SingleTickerProviderStateMixin {
  // ============================================================================
  // STATE VARIABLES
  // ============================================================================
  
  /// Form key for validation
  final _formKey = GlobalKey<FormState>();
  
  /// Email text editing controller
  final _emailController = TextEditingController();
  
  /// Sound service for audio feedback
  final _soundService = SoundService();
  
  /// Animation controller for entrance animation
  late AnimationController _animationController;
  
  /// Animations for smooth entrance
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // ============================================================================
  // LIFECYCLE METHODS
  // ============================================================================

  @override
  void initState() {
    super.initState();
    _setupStatusBar();
    _initAnimations();
    _startAnimation();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // ============================================================================
  // SETUP METHODS
  // ============================================================================

  /// Configure status bar appearance
  void _setupStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  /// Initialize entrance animations
  void _initAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Fade animation (0-60% of duration)
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));
    
    // Slide animation (20-100% of duration)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
    ));
  }

  /// Start entrance animation
  void _startAnimation() {
    _animationController.forward();
  }

  // ============================================================================
  // PASSWORD RESET HANDLER
  // ============================================================================

  /// Handle password reset request
  /// Sends password reset email via Firebase Authentication
  Future<void> _handleResetPassword() async {
    // Play click sound feedback
    _soundService.playClick();
    
    // Dismiss keyboard
    FocusScope.of(context).unfocus();
    
    // Validate form
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      try {
        final success = await authProvider.resetPassword(
          _emailController.text.trim(),
        );

        if (!mounted) return;

        if (success) {
          // Play success sound and show success message
          await _soundService.playSuccess();
          _showSuccessSnackBar('Password reset email sent! Check your inbox.');
          
          // Navigate back to login after showing success message
          Future.delayed(const Duration(milliseconds: 1500), () {
            if (mounted) Navigator.pop(context);
          });
        } else {
          // Play error sound and show error message
          _soundService.playError();
          _showErrorSnackBar(authProvider.errorMessage ?? 'Failed to send reset email. Please try again.');
        }
      } catch (e) {
        if (mounted) {
          _soundService.playError();
          _showErrorSnackBar('An unexpected error occurred. Please check your connection and try again.');
        }
      }
    } else {
      // Play error sound for validation failure
      _soundService.playError();
    }
  }

  // ============================================================================
  // UI HELPER METHODS
  // ============================================================================

  /// Show success message in green snackbar
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontFamily: 'Montserrat'),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  /// Show error message in red snackbar
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontFamily: 'Montserrat'),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  // ============================================================================
  // BUILD METHOD
  // ============================================================================

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
          onPressed: () {
            _soundService.playTap();
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.08,  // 8% horizontal padding
            vertical: isSmallScreen ? 16 : 24,
          ),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: isSmallScreen ? 8 : 16),
                    
                    // Logo and app name
                    _buildBranding(isSmallScreen),
                    SizedBox(height: isSmallScreen ? 24 : 32),
                    
                    // Title
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 28 : 32,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                        fontFamily: 'Montserrat',
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Subtitle with instructions
                    Text(
                      'Enter your email address and we\'ll send you a link to reset your password.',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.textSecondary,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 32 : 40),
                    
                    // Email field
                    CustomTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.validateEmail,
                    ),
                    SizedBox(height: isSmallScreen ? 28 : 32),
                    
                    // Send reset link button
                    CustomButton(
                      text: 'Send Reset Link',
                      onPressed: _handleResetPassword,
                      isLoading: authProvider.isLoading,
                      icon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 24),
                    
                    // Back to login link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Remember your password? ',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _soundService.playTap();
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================================
  // UI BUILDER METHODS
  // ============================================================================

  /// Build logo and app name branding
  Widget _buildBranding(bool isSmallScreen) {
    final logoSize = isSmallScreen ? 85.0 : 95.0;
    
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo image
          SizedBox(
            width: logoSize,
            height: logoSize,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to icon if image fails to load
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.pets_rounded,
                      size: logoSize * 0.6,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
          
          // App name with negative offset for tight spacing
          Transform.translate(
            offset: const Offset(-8, 0),
            child: Text(
              'Sahara',
              style: TextStyle(
                fontSize: isSmallScreen ? 28 : 32,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                letterSpacing: -0.5,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
