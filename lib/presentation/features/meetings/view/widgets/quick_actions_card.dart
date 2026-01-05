import 'package:flutter/material.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

import '../../../../theme/colors.dart';

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _actionButton(
            textColor: AppColors.primary500,
            color: AppColors.primary100,
            icon: Icons.flash_on,
            label: "Start Instant Meeting",
            onTap: () {
              // TODO
            },
          ),
          const SizedBox(height: 12),
          _actionButton(
            textColor: AppColors.primaryTxt ,
            color: AppColors.secondaryGrey.withOpacity(0.3) ,
            icon: Icons.calendar_today,
            label: "Schedule a Meeting",
            onTap: () {
              // TODO
            },
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required  Color color ,
    required Color textColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 14,
        ),
        decoration: BoxDecoration(
          color: color ,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: textColor, size: 20),
            const SizedBox(width: 12),
            Text(
              label,
              style: sataoshiBold.copyWith(color: textColor)
            ),
          ],
        ),
      ),
    );
  }
}
