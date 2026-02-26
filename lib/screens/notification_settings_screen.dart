import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _bookingNotifications = true;
  bool _messageNotifications = true;
  bool _paymentNotifications = true;
  bool _promotionalNotifications = false;
  bool _reminderNotifications = true;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _smsNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text(
          'Notification Settings',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notification Types',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                fontFamily: 'Montserrat',
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 14),
            _buildNotificationCard(
              icon: Icons.calendar_today_rounded,
              title: 'Booking Notifications',
              subtitle: 'Updates about your bookings',
              value: _bookingNotifications,
              onChanged: (value) => setState(() => _bookingNotifications = value),
              color: AppColors.primary,
            ),
            const SizedBox(height: 10),
            _buildNotificationCard(
              icon: Icons.chat_bubble_rounded,
              title: 'Message Notifications',
              subtitle: 'New messages from caregivers',
              value: _messageNotifications,
              onChanged: (value) => setState(() => _messageNotifications = value),
              color: AppColors.secondary,
            ),
            const SizedBox(height: 10),
            _buildNotificationCard(
              icon: Icons.payment_rounded,
              title: 'Payment Notifications',
              subtitle: 'Payment confirmations and receipts',
              value: _paymentNotifications,
              onChanged: (value) => setState(() => _paymentNotifications = value),
              color: AppColors.accent,
            ),
            const SizedBox(height: 10),
            _buildNotificationCard(
              icon: Icons.alarm_rounded,
              title: 'Reminder Notifications',
              subtitle: 'Upcoming booking reminders',
              value: _reminderNotifications,
              onChanged: (value) => setState(() => _reminderNotifications = value),
              color: AppColors.tertiary,
            ),
            const SizedBox(height: 10),
            _buildNotificationCard(
              icon: Icons.local_offer_rounded,
              title: 'Promotional Notifications',
              subtitle: 'Special offers and updates',
              value: _promotionalNotifications,
              onChanged: (value) => setState(() => _promotionalNotifications = value),
              color: AppColors.primary,
            ),
            const SizedBox(height: 28),
            const Text(
              'Delivery Methods',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                fontFamily: 'Montserrat',
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 14),
            _buildDeliveryCard(
              icon: Icons.notifications_rounded,
              title: 'Push Notifications',
              subtitle: 'Receive notifications on your device',
              value: _pushNotifications,
              onChanged: (value) => setState(() => _pushNotifications = value),
            ),
            const SizedBox(height: 10),
            _buildDeliveryCard(
              icon: Icons.email_rounded,
              title: 'Email Notifications',
              subtitle: 'Receive notifications via email',
              value: _emailNotifications,
              onChanged: (value) => setState(() => _emailNotifications = value),
            ),
            const SizedBox(height: 10),
            _buildDeliveryCard(
              icon: Icons.sms_rounded,
              title: 'SMS Notifications',
              subtitle: 'Receive notifications via text message',
              value: _smsNotifications,
              onChanged: (value) => setState(() => _smsNotifications = value),
            ),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded, color: AppColors.textPrimary, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'You can change these settings anytime. Some notifications are required for account security.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Color color,
  }) {
    return Container(
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
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.textPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
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
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.textPrimary,
          ),
        ],
      ),
    );
  }
}
