import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../services/sound_service.dart';
import 'package:intl/intl.dart';

/// Messages Screen
/// 
/// Displays conversations between pet owners and caregivers:
/// - List of message threads with last message preview
/// - Search functionality to filter conversations
/// - Online status indicators
/// - Unread message badges
/// - Empty state when no messages exist
/// 
/// Features:
/// - Search bar to filter messages
/// - Message cards with avatar, name, last message, timestamp
/// - Online status indicator (green dot)
/// - Unread count badges
/// - Read/unread message indicators
/// - Tap to open chat (navigation placeholder)
/// 
/// Design Principles:
/// - Solid colors only (Navy, Orange, Sky Blue, Light Blue)
/// - 8px grid spacing system
/// - Montserrat font family
/// - Clean card-based layout
/// - Professional messaging interface
/// - Clear visual hierarchy
/// 
/// Theme Colors:
/// - Background: AppColors.surface (white)
/// - Cards: White with AppColors.border
/// - Avatar: AppColors.primary (navy)
/// - Online indicator: AppColors.success (green)
/// - Unread badge: AppColors.primary (navy)
/// - Read indicator: AppColors.info (blue)
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  // ============================================================================
  // STATE VARIABLES
  // ============================================================================

  final TextEditingController _searchController = TextEditingController();
  final SoundService _soundService = SoundService();
  
  // ============================================================================
  // LIFECYCLE METHODS
  // ============================================================================

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================================
  // BUILD METHOD
  // ============================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(
              child: _buildMessagesList(),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // UI BUILDERS - HEADER
  // ============================================================================

  /// Builds the screen header
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Chat with your caregivers',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.textSecondary,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // UI BUILDERS - SEARCH BAR
  // ============================================================================

  /// Builds the search bar for filtering messages
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            color: AppColors.textPrimary,
          ),
          decoration: const InputDecoration(
            hintText: 'Search messages...',
            hintStyle: TextStyle(
              color: AppColors.textTertiary,
              fontFamily: 'Montserrat',
            ),
            prefixIcon: Icon(Icons.search_rounded, color: AppColors.textTertiary),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ),
    );
  }

  // ============================================================================
  // UI BUILDERS - MESSAGES LIST
  // ============================================================================

  /// Builds the list of message threads
  Widget _buildMessagesList() {
    // Mock data for demonstration
    final messages = _getMockMessages();

    if (messages.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildMessageCard(messages[index]),
        );
      },
    );
  }

  // ============================================================================
  // UI BUILDERS - MESSAGE CARD
  // ============================================================================

  /// Builds a single message card
  Widget _buildMessageCard(MessageData message) {
    final timeFormat = DateFormat('hh:mm a');

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _soundService.playTap();
          // Navigate to chat screen
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Avatar
              Stack(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  if (message.isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              
              // Message content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            message.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                              fontFamily: 'Montserrat',
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          timeFormat.format(message.timestamp),
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textTertiary,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        if (message.isRead)
                          const Icon(
                            Icons.done_all_rounded,
                            size: 14,
                            color: AppColors.info,
                          )
                        else
                          const Icon(
                            Icons.done_rounded,
                            size: 14,
                            color: AppColors.textTertiary,
                          ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            message.lastMessage,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: message.unreadCount > 0 
                                  ? FontWeight.w600 
                                  : FontWeight.w400,
                              color: message.unreadCount > 0
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                              fontFamily: 'Montserrat',
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Unread badge
              if (message.unreadCount > 0) ...[
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    message.unreadCount.toString(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================================
  // UI BUILDERS - EMPTY STATE
  // ============================================================================

  /// Builds the empty state when no messages exist
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chat_bubble_outline_rounded,
              size: 64,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No messages yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start a conversation with a caregiver',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // MOCK DATA
  // ============================================================================

  /// Returns mock message data for demonstration
  List<MessageData> _getMockMessages() {
    return [
      MessageData(
        name: 'Priya Sharma',
        lastMessage: 'I\'ll be there at 3 PM today!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        unreadCount: 2,
        isOnline: true,
        isRead: false,
      ),
      MessageData(
        name: 'Rahul Verma',
        lastMessage: 'Thanks for booking! Looking forward to meeting your pet.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        unreadCount: 0,
        isOnline: false,
        isRead: true,
      ),
      MessageData(
        name: 'Anjali Patel',
        lastMessage: 'Your dog had a great walk today! 🐕',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        unreadCount: 0,
        isOnline: true,
        isRead: true,
      ),
      MessageData(
        name: 'Vikram Singh',
        lastMessage: 'Can we reschedule to tomorrow?',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        unreadCount: 1,
        isOnline: false,
        isRead: false,
      ),
    ];
  }
}

// ============================================================================
// MESSAGE DATA MODEL
// ============================================================================

/// Model class for message thread data
class MessageData {
  final String name;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final bool isOnline;
  final bool isRead;

  MessageData({
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    this.unreadCount = 0,
    this.isOnline = false,
    this.isRead = false,
  });
}
