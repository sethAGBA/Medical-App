import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ReviewCard extends StatelessWidget {
  final String user;
  final String comment;
  final double rating;

  const ReviewCard({
    super.key,
    required this.user,
    required this.comment,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, size: 24, color: AppColors.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    user.isEmpty ? 'Anonyme' : user,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              comment.isEmpty ? 'Aucun commentaire' : comment,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < rating.floor() ? Icons.star : Icons.star_border,
                  color: index < rating.floor() ? Colors.amber : Colors.grey,
                  size: 16,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}