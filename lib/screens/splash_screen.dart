import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'onboarding_screen.dart';
import '../theme/app_colors.dart';

/// Splash Screen - First screen users see when launching the app
/// 
/// Features:
/// - Animated logo with scale and fade effects
/// - Brand name with slide animation
/// - Progress indicator showing loading state
/// - Smooth transition to onboarding
/// 
/// Design Principles:
/// - Clean, minimal design focusing on brand identity
/// - Smooth animations for professional feel
/// - Proper spacing following 8px grid system
/// - Theme colors strictly adhered
/// - Responsive to different screen sizes

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  // Animation Controllers
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _progressController;
  
  // Logo Animations
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  
  // Text Animations
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;
  
  // Progress Animation
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _setupStatusBar();
    _initAnimations();
    _startAnimationSequence();
    _scheduleNavigation();
  }

  /// Configure status bar appearance
  void _setupStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  /// Initialize all animation controllers and animations
  void _initAnimations() {
    // Logo animation controller (1.2s)
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    // Text animation controller (800ms)
    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Progress animation controller (2s)
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    // Logo scale animation: 0.7 → 1.0 with easeOutCubic curve
    _logoScaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutCubic,
    ));
    
    // Logo fade animation: 0.0 → 1.0 in first half
    _logoFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));
    
    // Text fade animation: 0.0 → 1.0
    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    ));
    
    // Text slide animation: from bottom (0.3) to center (0.0)
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutCubic,
    ));
    
    // Progress animation: 0.0 → 1.0 with smooth easing
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));
  }

  /// Start animation sequence with proper timing
  void _startAnimationSequence() {
    // Start logo animation immediately
    _logoController.forward();
    
    // Start text animation after 400ms
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _textController.forward();
    });
    
    // Start progress animation after 600ms
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _progressController.forward();
    });
  }

  /// Schedule navigation to next screen after 3 seconds
  void _scheduleNavigation() {
    Timer(const Duration(milliseconds: 3000), () {
      if (!mounted) return;
      
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => 
              const OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;
    
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.08, // 8% horizontal padding
            vertical: size.height * 0.05,  // 5% vertical padding
          ),
          child: Column(
            children: [
              // Top spacer - 15% of screen height
              SizedBox(height: size.height * 0.15),
              
              // Logo and text section - centered and expanded
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildAnimatedLogo(isSmallScreen),
                      const SizedBox(height: 0), // No space between logo and text
                      _buildAnimatedText(isSmallScreen),
                    ],
                  ),
                ),
              ),
              
              // Bottom section - progress indicator and version
              _buildBottomSection(),
              SizedBox(height: size.height * 0.03), // 3% bottom padding
            ],
          ),
        ),
      ),
    );
  }

  /// Build animated logo with scale and fade effects
  Widget _buildAnimatedLogo(bool isSmallScreen) {
    final size = MediaQuery.of(context).size;
    // Logo size: 35% of screen width, clamped between 150-220px
    final logoSize = (size.width * 0.35).clamp(150.0, 220.0);
    
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        return Opacity(
          opacity: _logoFadeAnimation.value,
          child: Transform.scale(
            scale: _logoScaleAnimation.value,
            child: SizedBox(
              width: logoSize,
              height: logoSize,
              child: _buildLogoContent(logoSize),
            ),
          ),
        );
      },
    );
  }

  /// Build logo content with fallback
  Widget _buildLogoContent(double size) {
    return Image.asset(
      'assets/images/logo.png',
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Fallback: Primary color container with pet icon
        return Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(size * 0.15), // 15% of size
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            Icons.pets_rounded,
            size: size * 0.5, // 50% of container size
            color: Colors.white,
          ),
        );
      },
    );
  }

  /// Build animated text (app name and tagline)
  Widget _buildAnimatedText(bool isSmallScreen) {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return SlideTransition(
          position: _textSlideAnimation,
          child: Opacity(
            opacity: _textFadeAnimation.value,
            child: Column(
              children: [
                // App name - Primary color, bold
                Text(
                  'Sahara',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 40 : 48,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    letterSpacing: -1.2,
                    fontFamily: 'Montserrat',
                    height: 1.1,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 8 : 12),
                
                // Tagline - Secondary text color
                Text(
                  'Your Pet\'s Support & Care',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 15,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.3,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Build bottom section with progress indicator and version
  Widget _buildBottomSection() {
    return Column(
      children: [
        // Animated progress indicator
        AnimatedBuilder(
          animation: _progressController,
          builder: (context, child) {
            return Column(
              children: [
                // Progress bar container
                SizedBox(
                  width: 200, // Fixed width for consistency
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: _progressAnimation.value,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.secondary, // Vibrant orange
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.secondary.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24), // 24px spacing
              ],
            );
          },
        ),
        
        // Version information
        Text(
          'Version 1.0.0',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textTertiary,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}

