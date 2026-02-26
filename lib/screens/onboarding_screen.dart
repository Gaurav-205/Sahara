import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart';
import '../theme/app_colors.dart';

/// Onboarding Screen - Introduces key features to new users
/// 
/// This screen presents three key features of the Sahara Pet Care app:
/// 1. Verified Caregivers - Trust and safety
/// 2. Real-Time Tracking - Peace of mind
/// 3. Stay Updated - Communication and transparency
/// 
/// Design Principles:
/// - Clean, minimal design with focus on content
/// - Smooth page transitions with fade/slide animations
/// - Consistent theme colors (Navy, Orange, Sky Blue)
/// - Responsive layout for all screen sizes
/// - 8px grid spacing system
/// - Professional, modern aesthetic
/// 
/// Navigation:
/// - Skip button: Jump directly to login
/// - Next button: Progress through pages
/// - Get Started button: Complete onboarding (last page)
/// 
/// Theme Colors Used:
/// - Background: Surface (white)
/// - Icons: Primary (Navy), Secondary (Orange), Accent (Sky Blue)
/// - Text: Primary and Secondary text colors
/// - Button: Secondary (Orange) for CTA
/// - Indicator: Secondary (Orange) for active, Border for inactive
/// 
/// Animations:
/// - Page transition: 400ms with easeInOutCubic
/// - Content fade-in: 600ms with easeIn
/// - Content slide-up: 700ms with easeOutCubic
/// - Indicator animation: 300ms with easeInOut
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  // ============================================================================
  // STATE VARIABLES
  // ============================================================================
  
  /// Page controller for managing page transitions
  final PageController _pageController = PageController();
  
  /// Current page index (0-2)
  int _currentPage = 0;
  
  /// Animation controllers for smooth transitions
  late AnimationController _fadeController;
  late AnimationController _slideController;
  
  /// Animations for content appearance
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  /// Onboarding pages data
  final List<OnboardingData> _pages = [
    OnboardingData(
      icon: Icons.verified_user_rounded,
      title: 'Verified Caregivers',
      description: 'Connect with trusted and verified pet care professionals in your area',
    ),
    OnboardingData(
      icon: Icons.location_on_rounded,
      title: 'Real-Time Tracking',
      description: 'Monitor your pet\'s walks and activities with live GPS tracking',
    ),
    OnboardingData(
      icon: Icons.notifications_active_rounded,
      title: 'Stay Updated',
      description: 'Get instant updates and photos during your pet\'s care sessions',
    ),
  ];

  // ============================================================================
  // LIFECYCLE METHODS
  // ============================================================================

  @override
  void initState() {
    super.initState();
    _setupStatusBar();
    _initAnimations();
    _startInitialAnimation();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
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

  /// Initialize animation controllers and animations
  void _initAnimations() {
    // Fade animation controller (600ms)
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    // Slide animation controller (700ms)
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    
    // Fade animation (0 → 1)
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));
    
    // Slide animation (20% down → 0)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
  }

  /// Start initial page animation
  void _startInitialAnimation() {
    _fadeController.forward();
    _slideController.forward();
  }

  // ============================================================================
  // EVENT HANDLERS
  // ============================================================================

  /// Handle page change event
  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    
    // Restart animations for new page
    _fadeController.reset();
    _slideController.reset();
    _fadeController.forward();
    _slideController.forward();
  }

  /// Navigate to login screen
  void _skipToLogin() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => 
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  /// Navigate to next page or login
  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _skipToLogin();
    }
  }

  // ============================================================================
  // BUILD METHOD
  // ============================================================================

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;
    
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button (top-right)
            _buildSkipButton(),
            
            // Onboarding pages with swipe navigation
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index], isSmallScreen);
                },
              ),
            ),
            
            // Page indicator dots
            _buildIndicator(),
            SizedBox(height: isSmallScreen ? 24 : 32),
            
            // Next/Get Started button
            _buildButton(isSmallScreen),
            SizedBox(height: isSmallScreen ? 32 : 48),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // UI BUILDER METHODS
  // ============================================================================

  /// Build skip button (top-right corner)
  Widget _buildSkipButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16),
      child: Align(
        alignment: Alignment.topRight,
        child: TextButton(
          onPressed: _skipToLogin,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            'Skip',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
    );
  }

  /// Build individual onboarding page with icon, title, and description
  Widget _buildPage(OnboardingData data, bool isSmallScreen) {
    final size = MediaQuery.of(context).size;
    
    // Responsive icon size (35% of screen width, clamped between 140-180px)
    final iconSize = (size.width * 0.35).clamp(140.0, 180.0);
    
    // Determine icon color based on current page
    final iconColor = _currentPage == 0 
        ? AppColors.primary      // Navy for page 1
        : _currentPage == 1 
            ? AppColors.secondary // Orange for page 2
            : AppColors.accent;   // Sky Blue for page 3
    
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.08, // 8% horizontal padding
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated icon with circular background
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: iconColor.withValues(alpha: 0.25),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  data.icon,
                  size: iconSize * 0.45, // Icon is 45% of container size
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          SizedBox(height: isSmallScreen ? 40 : 56),
          
          // Animated title
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Text(
                data.title,
                style: TextStyle(
                  fontSize: isSmallScreen ? 26 : 30,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                  fontFamily: 'Montserrat',
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          
          SizedBox(height: isSmallScreen ? 16 : 20),
          
          // Animated description
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  data.description,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 15 : 16,
                    color: AppColors.textSecondary,
                    height: 1.6,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build page indicator dots
  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _pages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 32 : 8,  // Active: 32px, Inactive: 8px
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? AppColors.secondary  // Orange for active page
                : AppColors.border,    // Light gray for inactive pages
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  /// Build Next/Get Started button
  Widget _buildButton(bool isSmallScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: SizedBox(
        width: double.infinity,
        height: isSmallScreen ? 52 : 56,
        child: ElevatedButton(
          onPressed: _nextPage,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,  // Orange background
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            shadowColor: AppColors.secondary.withValues(alpha: 0.3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _currentPage < _pages.length - 1 ? 'Next' : 'Get Started',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                _currentPage < _pages.length - 1 
                    ? Icons.arrow_forward_rounded 
                    : Icons.check_rounded,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// DATA MODEL
// ============================================================================

/// Data model for onboarding page content
class OnboardingData {
  /// Icon to display in circular container
  final IconData icon;
  
  /// Main title text
  final String title;
  
  /// Description text explaining the feature
  final String description;

  OnboardingData({
    required this.icon,
    required this.title,
    required this.description,
  });
}
