import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../theme/app_colors.dart';
import '../services/sound_service.dart';
import 'signup_screen.dart';
import 'home_screen.dart';
import 'forgot_password_screen.dart';

/// Login Screen - User authentication entry point
/// 
/// This screen allows users to sign in to their Sahara Pet Care account using:
/// 1. Email and password authentication
/// 2. Google Sign-In (OAuth)
/// 3. Apple Sign-In (placeholder for future implementation)
/// 
/// Design Principles:
/// - Clean, minimal form design with focus on usability
/// - Smooth entrance animations (fade + slide)
/// - Consistent theme colors (Navy primary, Orange accents)
/// - Responsive layout for all screen sizes
/// - 8px grid spacing system
/// - Professional error handling with sound feedback
/// - Accessible form validation
/// 
/// Features:
/// - Email/password validation
/// - Loading states during authentication
/// - Error messages with dismissible snackbars
/// - Sound feedback for user actions (click, success, error)
/// - Smooth navigation transitions
/// - Social login options
/// - Forgot password link
/// - Sign up navigation
/// 
/// Theme Colors Used:
/// - Background: Surface (white)
/// - Logo fallback: Primary (Navy)
/// - Title text: Text Primary (dark slate)
/// - Subtitle text: Text Secondary (medium slate)
/// - Primary button: Secondary (Orange)
/// - Links: Primary (Navy)
/// - Borders: Border (light gray)
/// - Error: Error (rose red)
/// 
/// Animations:
/// - Entrance fade-in: 800ms with easeIn (0-60%)
/// - Entrance slide-up: 800ms with easeOutCubic (20-100%)
/// - Navigation transitions: 300-400ms fade
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  // ============================================================================
  // STATE VARIABLES
  // ============================================================================
  
  /// Form key for validation
  final _formKey = GlobalKey<FormState>();
  
  /// Text editing controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
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
    _passwordController.dispose();
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

  /// Handle email/password login
  Future<void> _handleLogin() async {
    // Play click sound feedback
    _soundService.playClick();
    
    // Dismiss keyboard
    FocusScope.of(context).unfocus();
    
    // Validate form
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      try {
        final success = await authProvider.signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text,
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
          _showErrorSnackBar(authProvider.errorMessage ?? 'Login failed. Please try again.');
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

  /// Handle Google Sign-In
  Future<void> _handleGoogleSignIn() async {
    // Play click sound feedback
    _soundService.playClick();
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    try {
      final success = await authProvider.signInWithGoogle();

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
        if (authProvider.errorMessage != null && authProvider.errorMessage!.isNotEmpty) {
          _soundService.playError();
          if (!mounted) return;
          _showErrorSnackBar(authProvider.errorMessage!);
        }
      }
    } catch (e) {
      if (mounted) {
        _soundService.playError();
        _showErrorSnackBar('Google Sign-In failed. Please try again.');
      }
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.08,  // 8% horizontal padding
            vertical: isSmallScreen ? 24 : 32,
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
                    SizedBox(height: isSmallScreen ? 16 : 24),
                    
                    // Logo and app name
                    _buildLogo(isSmallScreen),
                    SizedBox(height: isSmallScreen ? 24 : 32),
                    
                    // Welcome title
                    Text(
                      'Welcome Back!',
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
                      'Sign in to continue to Sahara',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.textSecondary,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    
                    // Password field
                    CustomTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: Icons.lock_outline_rounded,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    
                    // Forgot password link
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          _soundService.playTap();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                        ),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 20 : 24),
                    
                    // Sign in button
                    CustomButton(
                      text: 'Sign In',
                      onPressed: _handleLogin,
                      isLoading: authProvider.isLoading,
                      icon: Icons.arrow_forward_rounded,
                    ),
                    SizedBox(height: isSmallScreen ? 20 : 24),
                    
                    // OR divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.border, thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              color: AppColors.textTertiary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: AppColors.border, thickness: 1)),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 20 : 24),
                    
                    // Social login buttons
                    Row(
                      children: [
                        Expanded(
                          child: _buildSocialButton(
                            icon: Icons.g_mobiledata_rounded,
                            label: 'Google',
                            onTap: _handleGoogleSignIn,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildSocialButton(
                            icon: Icons.apple_rounded,
                            label: 'Apple',
                            onTap: () {
                              // TODO: Implement Apple Sign-In
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 24 : 32),
                    
                    // Sign up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _soundService.playTap();
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => 
                                    const SignupScreen(),
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
                            'Sign Up',
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

  /// Build logo and app name
  Widget _buildLogo(bool isSmallScreen) {
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

  /// Build social login button (Google/Apple)
  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: AppColors.textPrimary),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
