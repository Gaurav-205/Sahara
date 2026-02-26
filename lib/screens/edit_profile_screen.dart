import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../providers/auth_provider.dart';
import '../services/sound_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../theme/app_colors.dart';

/// Edit Profile Screen
/// 
/// Allows users to edit their profile information:
/// - Profile photo selection from gallery
/// - Full name editing
/// - Email editing
/// - Phone number editing
/// - Form validation for all fields
/// - Save changes with loading state
/// 
/// Features:
/// - Image picker for profile photo
/// - Form validation with error messages
/// - Loading state during save
/// - Success/error feedback with snackbars
/// - Sound feedback on interactions
/// 
/// Design Principles:
/// - Solid colors only (Navy, Orange, Sky Blue, Light Blue)
/// - 8px grid spacing system
/// - Montserrat font family
/// - Clean form layout
/// - Professional editing interface
/// - Clear visual hierarchy
/// 
/// Theme Colors:
/// - Background: AppColors.surface (white)
/// - Avatar: AppColors.primary with transparency
/// - Camera button: AppColors.primary (navy)
/// - Success snackbar: AppColors.success (green)
/// - Error snackbar: AppColors.error (red)
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // ============================================================================
  // STATE VARIABLES
  // ============================================================================

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  final SoundService _soundService = SoundService();
  bool _isLoading = false;
  String? _selectedImagePath;

  // ============================================================================
  // LIFECYCLE METHODS
  // ============================================================================

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).currentUser;
    _nameController.text = user?.name ?? '';
    _emailController.text = user?.email ?? '';
    _phoneController.text = user?.phone ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // ============================================================================
  // PROFILE ACTIONS
  // ============================================================================

  /// Saves the profile changes
  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _soundService.playClick();
      
      setState(() {
        _isLoading = true;
      });

      try {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final currentUser = authProvider.currentUser;
        
        if (currentUser == null) {
          throw Exception('No user logged in');
        }

        // Prepare update data
        final updateData = {
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'phone': _phoneController.text.trim(),
          'updatedAt': DateTime.now().toIso8601String(),
        };

        // Update in Firestore
        await authProvider.updateUserProfile(updateData);

        if (!mounted) return;

        setState(() {
          _isLoading = false;
        });

        _soundService.playSuccess();
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );

        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;

        setState(() {
          _isLoading = false;
        });

        _soundService.playError();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile: $e'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } else {
      _soundService.playError();
    }
  }

  /// Picks an image from the gallery
  Future<void> _pickImage() async {
    _soundService.playTap();
    
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
      );

      if (image != null) {
        setState(() {
          _selectedImagePath = image.path;
        });

        if (!mounted) return;

        _soundService.playSuccess();
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image selected! Save to update profile.'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      _soundService.playError();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  // ============================================================================
  // BUILD METHOD
  // ============================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _soundService.playTap();
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildProfilePhoto(),
              const SizedBox(height: 32),
              _buildNameField(),
              const SizedBox(height: 16),
              _buildEmailField(),
              const SizedBox(height: 16),
              _buildPhoneField(),
              const SizedBox(height: 32),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================================
  // UI BUILDERS - PROFILE PHOTO
  // ============================================================================

  /// Builds the profile photo with camera button
  Widget _buildProfilePhoto() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          backgroundImage: _selectedImagePath != null 
              ? FileImage(File(_selectedImagePath!)) as ImageProvider
              : null,
          child: _selectedImagePath == null
              ? const Icon(
                  Icons.person,
                  size: 60,
                  color: AppColors.primary,
                )
              : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
              onPressed: _pickImage,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================================
  // UI BUILDERS - FORM FIELDS
  // ============================================================================

  /// Builds the name input field
  Widget _buildNameField() {
    return CustomTextField(
      controller: _nameController,
      labelText: 'Full Name',
      prefixIcon: Icons.person_outline,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
    );
  }

  /// Builds the email input field
  Widget _buildEmailField() {
    return CustomTextField(
      controller: _emailController,
      labelText: 'Email',
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        // Email regex pattern
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  /// Builds the phone input field
  Widget _buildPhoneField() {
    return CustomTextField(
      controller: _phoneController,
      labelText: 'Phone Number',
      prefixIcon: Icons.phone_outlined,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          // Phone number regex (10-15 digits, optional + prefix)
          final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,15}$');
          if (!phoneRegex.hasMatch(value)) {
            return 'Please enter a valid phone number';
          }
        }
        return null;
      },
    );
  }

  // ============================================================================
  // UI BUILDERS - SAVE BUTTON
  // ============================================================================

  /// Builds the save changes button
  Widget _buildSaveButton() {
    return CustomButton(
      text: 'Save Changes',
      isLoading: _isLoading,
      onPressed: _saveProfile,
    );
  }
}
