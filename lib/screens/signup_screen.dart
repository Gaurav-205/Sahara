import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../theme/app_colors.dart';
import '../services/sound_service.dart';
import '../utils/validators.dart';
import 'home_screen.dart';
import 'login_screen.dart';

/// Signup Screen - New user registration (Owner-Only)
/// 
/// This screen allows new pet owners to create an account on Sahara Pet Care.
/// Note: This app is exclusively for pet owners. Caregivers use a separate app.
/// 
/// Registration Fields:
/// 1. Full Name - User's display name
/// 2. Email - Account identifier and login credential
/// 3. Password - Secure password (minimum 6 characters)
/// 4. Confirm Password - Password verification
/// 
/// Design Principles:
/// - Clean, minimal form design with focus on usability
/// - Smooth entrance animations (fade + slide)
/// - Consistent theme colors (Navy primary, Orange accents)
/// - Responsive layout for all screen sizes
/// - 8px grid spacing system
/// - Professional error handling with sound feedback
/// - Comprehensive form validation
/// 
/// Features:
/// - Name validation (letters only, minimum 2 characters)
/// - Email validation with regex
/// - Password strength validation
/// - Password confirmation matching
/// - Loading states during registration
/// - Error messages with dismissible snackbars
/// - Sound feedback for user actions (click, success, error)
/// - Smooth navigation transitions
/// - Terms of service acknowledgment
/// - Login navigation for existing users
/// 
/// Theme Colors Used:
/// - Background: Surface (white)
/// - Logo fallback: Primary (Navy)
/// - Title text: Text Primary (dark slate)
/// - Subtitle text: Text Secondary (medium slate)
/// - Primary button: Secondary (Orange)
/// - Links: Primary (Navy)
/// - Terms text: Text Tertiary (light slate)
/// - Error: Error (rose red)
/// - AppBar back button: Text Primary
/// 
/// Animations:
/// - Entrance fade-in: 800ms with easeIn (0-60%)
/// - Entrance slide-up: 800ms with easeOutCubic (20-100%)
/// - Navigation transitions: 300-400ms fade
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with SingleTickerProviderStateMixin {
  // ============================================================================
  // STATE VARIABLES
  // ============================================================================
  
  /// Form key for validation
  final _formKey = GlobalKey<FormState>();
  
  /// Text editing controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
  // AUTHENTICATION HANDLERS
  // ============================================================================

  /// Handle user registration (owner-only)
  Future<void> _handleSignup() async {
    // Play click sound feedback
    _soundService.playClick();
    
    // Dismiss keyboard
    FocusScope.of(context).unfocus();
    
    // Validate form
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      try {
        final success = await authProvider.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          name: _nameController.text.trim(),
          userType: 'owner', // Always owner - this is pet owner app
        );

        if (!mounted) return;

        if (success) {
          // Play success sound and navigate to home
          await _soundService.playSuccess();
          
          if (!mounted) return;
          
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => 
                  const HomeScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 400),
            ),
          );
        } else {
          // Play error sound and show error message
          _soundService.playError();
          if (!mounted) return;
          _showErrorSnackBar(authProvider.errorMessage ?? 'Signup failed. Please try again.');
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

  /// Show error message in snackbar
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
                      'Create Account',
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
                    
                    // Subtitle
                    Text(
                      'Join Sahara and find the best care for your pet',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.textSecondary,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 24 : 32),
                    
                    // Name field
                    CustomTextField(
                      controller: _nameController,
                      labelText: 'Full Name',
                      hintText: 'Enter your full name',
                      prefixIcon: Icons.person_outline_rounded,
                      validator: Validators.validateName,
                    ),
                    const SizedBox(height: 20),
                    
                    // Email field
                    CustomTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.validateEmail,
                    ),
                    const SizedBox(height: 20),
                    
                    // Password field
                    CustomTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      hintText: 'Create a password',
                      prefixIcon: Icons.lock_outline_rounded,
                      obscureText: true,
                      validator: Validators.validateSignupPassword,
                    ),
                    const SizedBox(height: 20),
                    
                    // Confirm password field
                    CustomTextField(
                      controller: _confirmPasswordController,
                      labelText: 'Confirm Password',
                      hintText: 'Re-enter your password',
                      prefixIcon: Icons.lock_outline_rounded,
                      obscureText: true,
                      validator: (value) => Validators.validatePasswordConfirmation(
                        value,
                        _passwordController.text,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 24 : 32),
                    
                    // Create account button
                    CustomButton(
                      text: 'Create Account',
                      onPressed: _handleSignup,
                      isLoading: authProvider.isLoading,
                      icon: Icons.arrow_forward_rounded,
                    ),
                    const SizedBox(height: 16),
                    
                    // Terms and privacy text
                    Text(
                      'By creating an account, you agree to our Terms of Service and Privacy Policy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textTertiary,
                        fontFamily: 'Montserrat',
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 20 : 24),
                    
                    // Login link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _soundService.playTap();
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => 
                                    const LoginScreen(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return FadeTransition(opacity: animation, child: child);
                                },
                                transitionDuration: const Duration(milliseconds: 300),
                              ),
                            );
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
