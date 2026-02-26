import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'caregiver_detail_screen.dart';
import '../theme/app_colors.dart';

class SearchResultsScreen extends StatelessWidget {
  final String query;
  final List<UserModel> results;

  const SearchResultsScreen({
    super.key,
    required this.query,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text(
          'Search: "$query"',
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: results.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: results.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildCaregiverCard(context, results[index]),
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
              Icons.search_off_rounded,
              size: 52,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No results found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try searching with different keywords',
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

  Widget _buildCaregiverCard(BuildContext context, UserModel caregiver) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CaregiverDetailScreen(caregiver: caregiver),
          ),
        );
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
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.person_rounded, size: 24, color: Colors.white),
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
                          caregiver.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      if (caregiver.isVerified == true)
                        const Icon(
                          Icons.verified_rounded,
                          size: 16,
                          color: AppColors.textPrimary,
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, size: 13, color: AppColors.textPrimary),
                      const SizedBox(width: 4),
                      Text(
                        '${caregiver.rating?.toStringAsFixed(1) ?? '0.0'} • ${caregiver.completedBookings ?? 0} bookings',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                  if (caregiver.location != null) ...[
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 12, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          caregiver.location!,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[500],
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${caregiver.hourlyRate ?? 350}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Text(
                  'per hour',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[500],
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
