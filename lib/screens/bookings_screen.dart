import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/firestore_service.dart';
import '../models/booking_model.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userId = authProvider.currentUser?.uid ?? '';

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildBookingsList(userId, 'upcoming'),
                  _buildBookingsList(userId, 'completed'),
                  _buildBookingsList(userId, 'cancelled'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Bookings',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                    fontFamily: 'Montserrat',
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Track your pet care appointments',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.textPrimary,
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          fontFamily: 'Montserrat',
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          fontFamily: 'Montserrat',
        ),
        tabs: const [
          Tab(text: 'Upcoming'),
          Tab(text: 'Completed'),
          Tab(text: 'Cancelled'),
        ],
      ),
    );
  }

  Widget _buildBookingsList(String userId, String status) {
    return StreamBuilder<List<BookingModel>>(
      stream: _firestoreService.getUserBookings(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.textPrimary,
              strokeWidth: 2,
            ),
          );
        }

        if (snapshot.hasError) {
          return _buildErrorState();
        }

        final allBookings = snapshot.data ?? [];
        final filteredBookings = allBookings.where((booking) {
          if (status == 'upcoming') {
            return booking.status == 'pending' || booking.status == 'confirmed';
          } else if (status == 'completed') {
            return booking.status == 'completed';
          } else {
            return booking.status == 'cancelled';
          }
        }).toList();

        if (filteredBookings.isEmpty) {
          return _buildEmptyState(status);
        }

        return RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          color: AppColors.textPrimary,
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: filteredBookings.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildBookingCard(filteredBookings[index]),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildBookingCard(BookingModel booking) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');

    Color statusColor;
    IconData statusIcon;
    
    switch (booking.status) {
      case 'confirmed':
        statusColor = const Color(0xFF4CAF50);
        statusIcon = Icons.check_circle_rounded;
        break;
      case 'completed':
        statusColor = const Color(0xFF2196F3);
        statusIcon = Icons.done_all_rounded;
        break;
      case 'cancelled':
        statusColor = const Color(0xFFE53935);
        statusIcon = Icons.cancel_rounded;
        break;
      default:
        statusColor = const Color(0xFFFF9800);
        statusIcon = Icons.schedule_rounded;
    }

    return InkWell(
      onTap: () {
        // Navigate to booking details
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.textPrimary, Color(0xFF2A2A2A)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.pets_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.serviceType,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        booking.packageName,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 14, color: statusColor),
                      const SizedBox(width: 4),
                      Text(
                        booking.status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: statusColor,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            
            // Date and Time
            Row(
              children: [
                Expanded(
                  child: _buildInfoRow(
                    Icons.calendar_today_rounded,
                    'Date',
                    dateFormat.format(booking.scheduledDate),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInfoRow(
                    Icons.access_time_rounded,
                    'Time',
                    timeFormat.format(booking.scheduledDate),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            
            // Price
            _buildInfoRow(
              Icons.payments_rounded,
              'Price',
              '₹${booking.price.toStringAsFixed(0)}',
            ),
            
            // Notes if available
            if (booking.notes != null && booking.notes!.isNotEmpty) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.note_rounded,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        booking.notes!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[500]),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[500],
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 1),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyState(String status) {
    String message;
    IconData icon;
    
    switch (status) {
      case 'upcoming':
        message = 'No upcoming bookings';
        icon = Icons.event_busy_rounded;
        break;
      case 'completed':
        message = 'No completed bookings yet';
        icon = Icons.done_all_rounded;
        break;
      default:
        message = 'No cancelled bookings';
        icon = Icons.cancel_rounded;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 52,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Book a service to get started',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 52,
            color: Color(0xFFE53935),
          ),
          const SizedBox(height: 16),
          const Text(
            'Failed to load bookings',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              setState(() {});
            },
            child: const Text(
              'Try Again',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
