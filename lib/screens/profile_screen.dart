import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/user_model.dart';
import '../services/sound_service.dart';
import 'login_screen.dart';
import 'edit_profile_screen.dart';
import 'my_pets_screen.dart';
import 'notification_settings_screen.dart';
import 'help_support_screen.dart';
import 'privacy_policy_screen.dart';
import 'admin_seed_screen.dart';
import '../theme/app_colors.dart';

/// Profile Screen
/// 
/// Displays user profile information and navigation to various settings:
/// - Profile header with avatar, name, email, and user type badge
/// - Menu items for different sections:
///   - Edit Profile
///   - My Pets
///   - Payment Methods
///   - Notifications
///   - Help & Support
///   - Privacy Policy
///   - Logout
/// 
/// Features:
/// - User information display
/// - Navigation to profile-related screens
/// - Logout functionality with confirmation
/// - Clean menu-based interface
/// 
/// Design Principles:
/// - Solid colors only (Navy, Orange, Sky Blue, Light Blue)
/// - 8px grid spacing system
/// - Montserrat font family
/// - Clean card-based menu layout
/// - Professional profile interface
/// - Clear visual hierarchy
/// 
/// Theme Colors:
/// - Background: AppColors.surface (white)
/// - Avatar: AppColors.primary (navy)
/// - Menu cards: White with AppColors.border
/// - Icons: AppColors.primary (navy)
/// - User type badge: AppColors.background
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // ============================================================================
  // BUILD METHOD
  // ============================================================================

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    if (user == null) {
      return Scaffold(
        backgroundColor: AppColors.surface,
        body: const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(user),
              _buildMenuSection(context),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================================
  // UI BUILDERS - HEADER
  // ============================================================================

  /// Builds the profile header with avatar, name, email, and user type
  Widget _buildHeader(UserModel user) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Profile Avatar
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 42,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          // Name
          Text(
            user.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              fontFamily: 'Montserrat',
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 4),
          // Email
          Text(
            user.email,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 12),
          // User Type Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              user.userType == 'caregiver' ? 'Caregiver' : 'Pet Owner',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // UI BUILDERS - MENU SECTION
  // ============================================================================

  /// Builds the menu section with navigation items
  Widget _buildMenuSection(BuildContext context) {
    final soundService = SoundService();
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildMenuItem(
            context: context,
            soundService: soundService,
            icon: Icons.person_outline_rounded,
            title: 'Edit Profile',
            subtitle: 'Update your information',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              );
            },
          ),
          const SizedBox(height: 10),
          _buildMenuItem(
            context: context,
            soundService: soundService,
            icon: Icons.pets_rounded,
            title: 'My Pets',
            subtitle: 'Manage your pets',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyPetsScreen()),
              );
            },
          ),
          const SizedBox(height: 10),
          _buildMenuItem(
            context: context,
            soundService: soundService,
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: 'Manage notifications',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationSettingsScreen()),
              );
            },
          ),
          const SizedBox(height: 10),
          _buildMenuItem(
            context: context,
            soundService: soundService,
            icon: Icons.help_outline_rounded,
            title: 'Help & Support',
            subtitle: 'Get help and support',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
              );
            },
          ),
          const SizedBox(height: 10),
          _buildMenuItem(
            context: context,
            soundService: soundService,
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            subtitle: 'Read our privacy policy',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
              );
            },
          ),
          const SizedBox(height: 10),
          _buildMenuItem(
            context: context,
            soundService: soundService,
            icon: Icons.settings_suggest_rounded,
            title: '🔧 Seed Database',
            subtitle: 'Add sample caregivers & packages',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AdminSeedScreen()),
              );
            },
          ),
          const SizedBox(height: 10),
          _buildMenuItem(
            context: context,
            soundService: soundService,
            icon: Icons.logout_rounded,
            title: 'Logout',
            subtitle: 'Sign out of your account',
            onTap: () async {
              final authProvider = Provider.of<AuthProvider>(context, listen: false);
              await authProvider.signOut();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // UI BUILDERS - MENU ITEM
  // ============================================================================

  /// Builds a single menu item card
  Widget _buildMenuItem({
    required BuildContext context,
    required SoundService soundService,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () {
        soundService.playTap();
        onTap();
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textTertiary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
