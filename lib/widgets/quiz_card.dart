import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/typography.dart';
import '../utils/spacing.dart';
import 'custom_card.dart';

class QuizCard extends StatelessWidget {
  final String title;
  final String description;
  final String reward;
  final int questionCount;
  final List<Color> gradientColors;
  final VoidCallback onTap;
  
  const QuizCard({
    super.key,
    required this.title,
    required this.description,
    required this.reward,
    required this.questionCount,
    required this.gradientColors,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), // CORREGIDO
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md), // CORREGIDO
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white.withAlpha(204), // CORREGIDO (en lugar de withOpacity)
                    size: 16,
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                description,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Color(0xE6FFFFFF), // CORREGIDO (en lugar de withOpacity)
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  _buildInfoChip(
                    '$questionCount preguntas',
                    Icons.question_mark_rounded,
                  ),
                  Spacer(),
                  _buildRewardChip(reward),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildInfoChip(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Color(0x26FFFFFF), // CORREGIDO (0x26 = 15% opacity)
        borderRadius: BorderRadius.circular(0), // CORREGIDO
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: Colors.white,
          ),
          SizedBox(width: 4),
          Text(
            text,
            style: AppTextStyles.labelSmall.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRewardChip(String reward) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.success.withAlpha(51), // CORREGIDO (0x33 = 20% opacity)
        borderRadius: BorderRadius.circular(0), // CORREGIDO
        border: Border.all(
          color: AppColors.success.withAlpha(77), // CORREGIDO (0x4D = 30% opacity)
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.bolt_rounded,
            size: 12,
            color: AppColors.success,
          ),
          SizedBox(width: 4),
          Text(
            reward,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}