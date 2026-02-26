import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text(
          'Help & Support',
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildContactCard(
              icon: Icons.email_outlined,
              title: 'Email Us',
              subtitle: 'support@sahara.com',
              gradient: const LinearGradient(
                colors: [AppColors.textPrimary, Color(0xFF2A2A2A)],
              ),
              onTap: () => _launchEmail('support@sahara.com'),
            ),
            const SizedBox(height: 10),
            _buildContactCard(
              icon: Icons.phone_outlined,
              title: 'Call Us',
              subtitle: '+91 98765 43210',
              gradient: const LinearGradient(
                colors: [Color(0xFF4A4A4A), Color(0xFF6A6A6A)],
              ),
              onTap: () => _launchPhone('+919876543210'),
            ),
            const SizedBox(height: 10),
            _buildContactCard(
              icon: Icons.chat_bubble_outline_rounded,
              title: 'Live Chat',
              subtitle: 'Chat with our support team',
              gradient: const LinearGradient(
                colors: [Color(0xFF6A6A6A), Color(0xFF8A8A8A)],
              ),
              onTap: () => _showLiveChat(context),
            ),
            const SizedBox(height: 28),
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                fontFamily: 'Montserrat',
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 14),
            _buildFAQSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required LinearGradient gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
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
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                gradient: gradient,
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
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection(BuildContext context) {
    final faqs = [
      FAQItem(
        question: 'How do I book a caregiver?',
        answer: 'Browse caregivers on the home screen, select one, choose a service and time, then confirm your booking.',
      ),
      FAQItem(
        question: 'How do I cancel a booking?',
        answer: 'Go to Bookings tab, select the booking you want to cancel, and tap the Cancel button. Cancellations made 24 hours before the booking are fully refunded.',
      ),
      FAQItem(
        question: 'How do payments work?',
        answer: 'Add a payment method in your profile. Payments are processed after the service is completed. You\'ll receive a receipt via email.',
      ),
      FAQItem(
        question: 'Are caregivers verified?',
        answer: 'Yes! All caregivers go through background checks and verification. Look for the verified badge on their profiles.',
      ),
      FAQItem(
        question: 'What if I need to reschedule?',
        answer: 'Contact your caregiver through the Messages tab to discuss rescheduling. You can also cancel and create a new booking.',
      ),
      FAQItem(
        question: 'How do I leave a review?',
        answer: 'After a booking is completed, you\'ll receive a notification to leave a review. You can also review from the booking details page.',
      ),
    ];

    return Column(
      children: faqs.map((faq) => _buildFAQItem(context, faq)).toList(),
    );
  }

  Widget _buildFAQItem(BuildContext context, FAQItem faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            faq.question,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              fontFamily: 'Montserrat',
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                faq.answer,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  fontFamily: 'Montserrat',
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Sahara Support Request',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _showLiveChat(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Live Chat',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
        ),
        content: const Text(
          'Live chat feature coming soon! For immediate assistance, please email or call us.',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}
