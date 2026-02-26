import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<NotificationItem> _notifications = [
    NotificationItem(
      id: '1',
      title: 'Booking Confirmed',
      message: 'Your booking with Sarah Johnson has been confirmed for tomorrow at 10:00 AM',
      time: DateTime.now().subtract(const Duration(hours: 2)),
      type: NotificationType.booking,
      isRead: false,
    ),
    NotificationItem(
      id: '2',
      title: 'New Message',
      message: 'Mike Davis sent you a message',
      time: DateTime.now().subtract(const Duration(hours: 5)),
      type: NotificationType.message,
      isRead: false,
    ),
    NotificationItem(
      id: '3',
      title: 'Booking Completed',
      message: 'Your booking with Emma Wilson has been completed. Please leave a review!',
      time: DateTime.now().subtract(const Duration(days: 1)),
      type: NotificationType.booking,
      isRead: true,
    ),
    NotificationItem(
      id: '4',
      title: 'Payment Successful',
      message: 'Payment of ₹1,000 was successful',
      time: DateTime.now().subtract(const Duration(days: 2)),
      type: NotificationType.payment,
      isRead: true,
    ),
  ];

  void _markAsRead(String id) {
    setState(() {
      final notification = _notifications.firstWhere((n) => n.id == id);
      notification.isRead = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification.isRead = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications.where((n) => !n.isRead).length;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text(
                'Mark all read',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: AppColors.textPrimary,
                ),
              ),
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildNotificationCard(_notifications[index]),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
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
              Icons.notifications_off_outlined,
              size: 52,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No notifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'You\'re all caught up!',
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

  Widget _buildNotificationCard(NotificationItem notification) {
    return InkWell(
      onTap: () => _markAsRead(notification.id),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: notification.isRead ? Colors.white : Colors.grey[50],
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: _getColorForType(notification.type),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                _getIconForType(notification.type),
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: notification.isRead ? FontWeight.w600 : FontWeight.w700,
                            color: AppColors.textPrimary,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: AppColors.textPrimary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.message,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      fontFamily: 'Montserrat',
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatTime(notification.time),
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                      fontFamily: 'Montserrat',
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

  IconData _getIconForType(NotificationType type) {
    switch (type) {
      case NotificationType.booking:
        return Icons.calendar_today_rounded;
      case NotificationType.message:
        return Icons.chat_bubble_rounded;
      case NotificationType.payment:
        return Icons.payment_rounded;
      case NotificationType.reminder:
        return Icons.alarm_rounded;
    }
  }

  Color _getColorForType(NotificationType type) {
    switch (type) {
      case NotificationType.booking:
        return AppColors.primary;
      case NotificationType.message:
        return AppColors.secondary;
      case NotificationType.payment:
        return AppColors.accent;
      case NotificationType.reminder:
        return AppColors.tertiary;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final DateTime time;
  final NotificationType type;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = false,
  });
}

enum NotificationType {
  booking,
  message,
  payment,
  reminder,
}
