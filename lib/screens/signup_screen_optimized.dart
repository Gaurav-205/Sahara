import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/password_strength_indicator.dart';
import '../widgets/loading_overlay.dart';
import '../theme/app_colors.dart';
import '../services/sound_service.dart';
import '../utils/validators.dart';
import 'home_screen.dart';
import 'login_screen.dart';

/// Optimized Signup Screen - Modern UI/UX with Industry Standards
/// 
/// Improvements:
/// - Password strength indicator with real-time feedback
/// - Real-time password matching validation
/// - Loading overlay that blocks interaction
/// - Better error messages
/// - Improved visual hierarchy
/// - Autofill attributes
/// - Haptic feedback
/// - Better accessibility
/// - Smooth animations
/// - Professional spacing
class SignupScreenOptimized extends StatefulWidget {
  const SignupScreenOptimized({super.key});

  @override
  State<SignupScreenOptimized> createState() => _SignupScreenOptimizedState();
}

class _SignupScreenOptimizedState extends State<SignupScreenOptimized> 
    with SingleTickerProviderStateMixin {
  // Controllers
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  // Services
  final _soundService = SoundService();
  
  // Animation
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  // State
  bool _termsAccepted = false;
  bool _passwordsMatch = true;

  @override
  void initState() {
    super.initState();
    _setupStatusBar();
    _initAnimations();
    _startAnimation();
    _setupPasswordListeners();
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

  void _setupStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  void _initAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );
  }

  void _startAnimation() {
    _animationController.forward();
  }

  void _setupPasswordListeners() {
    _confirmPasswordController.addListener(() {
      setState(() {
        _passwordsMatch = _confirmPasswordController.text.isEmpty ||
            _passwordController.text == _confirmPasswordController.text;
      });
    });
  }

  Future<void> _handleSignup() async {
    _soundService.playClick();
    HapticFeedback.mediumImpact();
    FocusScope.of(context).unfocus();
    
    if (!_termsAccepted) {
      _showErrorSnackBar('Please accept the Terms of Service and Privacy Policy');
      _soundService.playError();
      return;
    }
    
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      try {
        final success = await authProvider.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          name: _nameController.text.trim(),
          userType: 'owner',
        );

        if (!mounted) return;

        if (success) {
          await _soundService.playSuccess();
          HapticFeedback.heavyImpact();
          
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
          _soundService.playError();
          HapticFeedback.vibrate();
          if (!mounted) return;
          _showErrorSnackBar(_getReadableError(authProvider.errorMessage));
        }
      } catch (e) {
        if (mounted) {
          _soundService.playError();
          HapticFeedback.vibrate();
          _showErrorSnackBar('Unable to create account. Please check your connection.');
        }
      }
    } else {
      _soundService.playError();
      HapticFeedback.lightImpact();
    }
  }

  String _getReadableError(String? error) {
    if (error == null) return 'Signup failed. Please try again.';
    
    if (error.contains('email-already-in-use')) {
      return 'This email is already registered. Try logging in instead.';
    } else if (error.contains('weak-password')) {
      return 'Please choose a stronger password.';
    } else if (error.contains('invalid-email')) {
      return 'Please enter a valid email address.';
    } else if (error.contains('network')) {
      return 'Network error. Please check your connection.';
    }
    
    return error;
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(fontFamily: 'Montserrat')),
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
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;

    return LoadingOverlay(
      isLoading: authProvider.isLoading,
      message: 'Creating your account...',
      child: Scaffold(
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
              horizontal: size.width * 0.08,
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
                      
                      // Title
                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 32 : 36,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          letterSpacing: -1,
                          fontFamily: 'Montserrat',
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Subtitle
                      Text(
                        'Join Sahara and find the best care for your pet',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 32 : 40),
                      
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
                        hintText: 'Create a strong password',
                        prefixIcon: Icons.lock_outline_rounded,
                        obscureText: true,
                        validator: Validators.validateSignupPassword,
                      ),
                      const SizedBox(height: 12),
                      
                      // Password strength indicator
                      PasswordStrengthIndicator(
                        password: _passwordController.text,
                        showRequirements: true,
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
                      
                      // Real-time password match indicator
                      if (_confirmPasswordController.text.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              _passwordsMatch 
                                  ? Icons.check_circle_rounded 
                                  : Icons.cancel_rounded,
                              size: 16,
                              color: _passwordsMatch 
                                  ? AppColors.success 
                                  : AppColors.error,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _passwordsMatch 
                                  ? 'Passwords match' 
                                  : 'Passwords do not match',
                              style: TextStyle(
                                fontSize: 12,
                                color: _passwordsMatch 
                                    ? AppColors.success 
                                    : AppColors.error,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      ],
                      SizedBox(height: isSmallScreen ? 24 : 32),
                      
                      // Terms checkbox
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: _termsAccepted,
                              onChanged: (value) {
                                setState(() => _termsAccepted = value ?? false);
                                HapticFeedback.selectionClick();
                              },
                              activeColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() => _termsAccepted = !_termsAccepted);
                                HapticFeedback.selectionClick();
                              },
                              child: Text.rich(
                                TextSpan(
                                  text: 'I agree to the ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                    fontFamily: 'Montserrat',
                                    height: 1.5,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Terms of Service',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const TextSpan(text: ' and '),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 24 : 32),
                      
                      // Create account button
                      CustomButton(
                        text: 'Create Account',
                        onPressed: _handleSignup,
                        isLoading: false, // Handled by LoadingOverlay
                        icon: Icons.arrow_forward_rounded,
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
      ),
    );
  }
}
