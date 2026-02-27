import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../models/review_model.dart';
import '../providers/auth_provider.dart';
import '../services/firestore_service.dart';
import '../services/chat_service.dart';
import '../services/sound_service.dart';
import '../widgets/custom_button.dart';
import '../theme/app_colors.dart';
import 'chat_screen.dart';

/// Caregiver Detail Screen
/// 
/// Displays comprehensive information about a selected caregiver including:
/// - Profile header with photo, name, location, and availability status
/// - Quick info cards (experience, completed bookings, schedule)
/// - About section with bio
/// - Services offered with icons
/// - Specialties and certifications
/// - Availability schedule
/// - Customer reviews with ratings
/// - Action buttons (message, book now)
/// - Booking dialog for service selection
/// 
/// Design Principles:
/// - Solid colors only (Navy, Orange, Sky Blue, Light Blue)
/// - 8px grid spacing system
/// - Montserrat font family
/// - Responsive layout with CustomScrollView
/// - Professional information hierarchy
/// - Interactive booking flow
/// 
/// Theme Colors:
/// - Background: AppColors.surface (white)
/// - AppBar: AppColors.primary (navy)
/// - Accent elements: AppColors.secondary (orange)
/// - Info cards: AppColors.accent (sky blue)
/// - Success states: AppColors.success (green)
class CaregiverDetailScreen extends StatefulWidget {
  final UserModel caregiver;

  const CaregiverDetailScreen({super.key, required this.caregiver});

  @override
  State<CaregiverDetailScreen> createState() => _CaregiverDetailScreenState();
}

class _CaregiverDetailScreenState extends State<CaregiverDetailScreen> {
  // ============================================================================
  // STATE VARIABLES
  // ============================================================================

  final FirestoreService _firestoreService = FirestoreService();
  final SoundService _soundService = SoundService();
  final ChatService _chatService = ChatService();
  List<ReviewModel> _reviews = [];
  bool _isLoadingReviews = true;

  // ============================================================================
  // LIFECYCLE METHODS
  // ============================================================================

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  // ============================================================================
  // DATA LOADING
  // ============================================================================

  /// Loads reviews for the caregiver from Firestore
  Future<void> _loadReviews() async {
    try {
      final reviews = await _firestoreService.getCaregiverReviews(widget.caregiver.uid);
      if (mounted) {
        setState(() {
          _reviews = reviews;
          _isLoadingReviews = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingReviews = false;
        });
      }
    }
  }

  // ============================================================================
  // ACTION HANDLERS
  // ============================================================================

  /// Handles favorite button press
  void _handleFavorite() {
    _soundService.playTap();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Added to favorites!'),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Handles share button press
  void _handleShare() {
    _soundService.playTap();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Share profile'),
        backgroundColor: AppColors.info,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Handles message button press
  Future<void> _handleMessage() async {
    _soundService.playClick();
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUser = authProvider.currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login to send messages'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    try {
      // Show loading
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Opening chat...'),
          backgroundColor: AppColors.info,
          duration: Duration(seconds: 1),
        ),
      );

      // Create or get existing chat
      final chatId = await _chatService.createChat(
        userId1: currentUser.uid,
        userId2: widget.caregiver.uid,
        user1Name: currentUser.name,
        user2Name: widget.caregiver.name,
      );

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(
              chatId: chatId,
              currentUserId: currentUser.uid,
              otherUserId: widget.caregiver.uid,
              otherUserName: widget.caregiver.name,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to open chat: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  // ============================================================================
  // BUILD METHOD
  // ============================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildQuickInfo(),
                  const SizedBox(height: 24),
                  _buildAboutSection(),
                  const SizedBox(height: 24),
                  _buildServicesSection(),
                  const SizedBox(height: 24),
                  _buildSpecialtiesSection(),
                  const SizedBox(height: 24),
                  _buildCertificationsSection(),
                  const SizedBox(height: 24),
                  _buildAvailabilitySection(),
                  const SizedBox(height: 24),
                  _buildReviewsSection(),
                  const SizedBox(height: 24),
                  _buildActionButtons(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // UI BUILDERS - APP BAR
  // ============================================================================

  /// Builds the collapsible app bar with profile photo
  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: AppColors.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          _soundService.playTap();
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.white),
          onPressed: _handleFavorite,
        ),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: _handleShare,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: AppColors.primary, // Solid color, no gradient
          child: Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.surface,
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: AppColors.primary,
                  ),
                ),
                if (widget.caregiver.isVerified == true)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================================
  // UI BUILDERS - HEADER SECTION
  // ============================================================================

  /// Builds the header with name, location, rating, and price
  Widget _buildHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.caregiver.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      if (widget.caregiver.isVerified == true) ...[
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.verified,
                          color: AppColors.success,
                          size: 24,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: AppColors.textTertiary),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          widget.caregiver.location ?? 'Location not specified',
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: widget.caregiver.isAvailable == true
                    ? AppColors.success.withValues(alpha: 0.1)
                    : AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.caregiver.isAvailable == true ? 'Available' : 'Busy',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                  color: widget.caregiver.isAvailable == true
                      ? AppColors.success
                      : AppColors.error,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.star, color: AppColors.warning, size: 20),
            const SizedBox(width: 4),
            Text(
              widget.caregiver.rating?.toStringAsFixed(1) ?? '0.0',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '(${widget.caregiver.completedBookings ?? 0} reviews)',
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================================
  // UI BUILDERS - QUICK INFO CARDS
  // ============================================================================

  /// Builds the quick info cards (experience, completed, schedule)
  Widget _buildQuickInfo() {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            Icons.work_outline,
            '${widget.caregiver.yearsOfExperience ?? 0} Years',
            'Experience',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            Icons.check_circle_outline,
            '${widget.caregiver.completedBookings ?? 0}',
            'Completed',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInfoCard(
            Icons.schedule,
            'Flexible',
            'Schedule',
          ),
        ),
      ],
    );
  }

  /// Builds a single info card
  Widget _buildInfoCard(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.accent, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Montserrat',
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // UI BUILDERS - ABOUT SECTION
  // ============================================================================

  /// Builds the about section with bio
  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.caregiver.bio ?? 'No bio available',
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Montserrat',
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  // ============================================================================
  // UI BUILDERS - SERVICES SECTION
  // ============================================================================

  /// Builds the services offered section
  Widget _buildServicesSection() {
    if (widget.caregiver.services == null || widget.caregiver.services!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Services Offered',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.caregiver.services!.map((service) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getServiceIcon(service),
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    service,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ============================================================================
  // UI BUILDERS - SPECIALTIES SECTION
  // ============================================================================

  /// Builds the specialties section
  Widget _buildSpecialtiesSection() {
    if (widget.caregiver.specialties == null || widget.caregiver.specialties!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Specialties',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.caregiver.specialties!.map((specialty) {
            return Chip(
              label: Text(specialty),
              backgroundColor: AppColors.success.withValues(alpha: 0.1),
              labelStyle: const TextStyle(
                color: AppColors.success,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
                fontSize: 12,
              ),
              side: BorderSide.none,
            );
          }).toList(),
        ),
      ],
    );
  }

  // ============================================================================
  // UI BUILDERS - CERTIFICATIONS SECTION
  // ============================================================================

  /// Builds the certifications section
  Widget _buildCertificationsSection() {
    if (widget.caregiver.certifications == null || widget.caregiver.certifications!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Certifications',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ...widget.caregiver.certifications!.map((cert) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.workspace_premium,
                    color: AppColors.warning,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    cert,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // ============================================================================
  // UI BUILDERS - AVAILABILITY SECTION
  // ============================================================================

  /// Builds the availability schedule section
  Widget _buildAvailabilitySection() {
    if (widget.caregiver.availability == null || widget.caregiver.availability!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Availability',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: Column(
            children: widget.caregiver.availability!.entries.map((entry) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.border,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      entry.value,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // ============================================================================
  // UI BUILDERS - REVIEWS SECTION
  // ============================================================================

  /// Builds the reviews section with customer feedback
  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Reviews',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: AppColors.textPrimary,
              ),
            ),
            if (_reviews.isNotEmpty)
              TextButton(
                onPressed: () {
                  _soundService.playTap();
                  // Show all reviews
                },
                child: const Text(
                  'See All',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: AppColors.primary,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (_isLoadingReviews)
          const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          )
        else if (_reviews.isEmpty)
          const Text(
            'No reviews yet',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
              color: AppColors.textSecondary,
            ),
          )
        else
          ..._reviews.take(3).map((review) => _buildReviewCard(review)),
      ],
    );
  }

  /// Builds a single review card
  Widget _buildReviewCard(ReviewModel review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: Text(
                  review.ownerName[0].toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.ownerName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      DateFormat('MMM dd, yyyy').format(review.createdAt),
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: AppColors.warning, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    review.rating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review.comment,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // UI BUILDERS - ACTION BUTTONS
  // ============================================================================

  /// Builds the action buttons (message, book now)
  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'Message',
            backgroundColor: AppColors.surface,
            textColor: AppColors.primary,
            onPressed: _handleMessage,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: CustomButton(
            text: 'Book Now',
            onPressed: widget.caregiver.isAvailable == true
                ? () => _showBookingDialog(context)
                : null,
          ),
        ),
      ],
    );
  }

  // ============================================================================
  // BOOKING DIALOG
  // ============================================================================

  /// Shows the booking dialog for service selection
  void _showBookingDialog(BuildContext context) {
    _soundService.playClick();
    
    String? selectedService;
    DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
    TimeOfDay selectedTime = const TimeOfDay(hour: 9, minute: 0);
    final notesController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Book Service',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Select Service',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: selectedService,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.primary, width: 2),
                          ),
                          hintText: 'Choose a service',
                          hintStyle: const TextStyle(
                            fontFamily: 'Montserrat',
                            color: AppColors.textTertiary,
                          ),
                        ),
                        items: widget.caregiver.services?.map((service) {
                          return DropdownMenuItem(
                            value: service,
                            child: Text(
                              service,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          );
                        }).toList() ?? [],
                        onChanged: (value) {
                          setModalState(() {
                            selectedService = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Select Date',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 90)),
                          );
                          if (date != null) {
                            setModalState(() {
                              selectedDate = date;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 20, color: AppColors.primary),
                              const SizedBox(width: 12),
                              Text(
                                DateFormat('MMM dd, yyyy').format(selectedDate),
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Select Time',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: selectedTime,
                          );
                          if (time != null) {
                            setModalState(() {
                              selectedTime = time;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time, size: 20, color: AppColors.primary),
                              const SizedBox(width: 12),
                              Text(
                                selectedTime.format(context),
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Additional Notes (Optional)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: notesController,
                        maxLines: 3,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.primary, width: 2),
                          ),
                          hintText: 'Any special requirements or instructions...',
                          hintStyle: const TextStyle(
                            fontFamily: 'Montserrat',
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        text: 'Confirm Booking',
                        onPressed: selectedService != null
                            ? () {
                                _soundService.playSuccess();
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Booking request sent for $selectedService on ${DateFormat('MMM dd').format(selectedDate)}!',
                                    ),
                                    backgroundColor: AppColors.success,
                                  ),
                                );
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      notesController.dispose();
    });
  }

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  /// Returns the appropriate icon for a service
  IconData _getServiceIcon(String service) {
    switch (service.toLowerCase()) {
      case 'dog walking':
        return Icons.directions_walk;
      case 'pet sitting':
        return Icons.home;
      case 'grooming':
        return Icons.content_cut;
      case 'training':
        return Icons.school;
      case 'vet visit':
      case 'medication administration':
        return Icons.local_hospital;
      case 'pet transportation':
        return Icons.directions_car;
      case 'overnight care':
        return Icons.nightlight;
      case 'bathing':
        return Icons.shower;
      case 'nail trimming':
        return Icons.cut;
      default:
        return Icons.pets;
    }
  }
}
