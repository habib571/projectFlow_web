import 'package:flutter/material.dart';
import 'package:projectflow_web/domain/models/notification_model.dart';
import 'package:projectflow_web/domain/models/notification_type.dart';
import 'package:projectflow_web/presentation/sharedwidgets/image_placeholder.dart';
import 'package:projectflow_web/presentation/theme/colors.dart';
import 'package:projectflow_web/presentation/theme/styles.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notification.read ? Colors.white : AppColors.primary300.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: notification.read ? Colors.grey.shade200 : AppColors.primary300.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvatar(),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMessage(),
                  const SizedBox(height: 4),
                  Text(
                    _formatRelativeTime(notification.sentAt),
                    style: sataoshiRegular.copyWith(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (!notification.read)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primary500,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    switch (notification.title) {
      case "New Member Joined" :
      case "New Task Assigned" :
        // User avatar
        if (notification.actorImage != null && notification.actorImage!.isNotEmpty) {
          return CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(notification.actorImage!),
          );
        }
        return ImagePlaceHolderWeb(
          radius: 24,
          fullName: notification.actorName ?? "U",
        );

      case "New Meeting Scheduled":
        // Calendar icon
        return Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(
            Icons.calendar_today_outlined,
            color: AppColors.primary500,
            size: 22,
          ),
        );

      case "pROJECT UPDATED":
        // Project icon
        return Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(
            Icons.folder_outlined,
            color: AppColors.primary500,
            size: 22,
          ),
        );
        default:
        return Container();
    }
  }

  Widget _buildMessage() {
    switch (notification.title) {
      case "New Member Joined" :
        return RichText(
          text: TextSpan(
            style: sataoshiRegular.copyWith(
              fontSize: 14,
              color: AppColors.primaryTxt,
              height: 1.4,
            ),
            children: [
              TextSpan(
                text: notification.actorName ?? "Someone",
                style: sataoshiBold.copyWith(
                  fontSize: 14,
                  color: AppColors.primaryTxt,
                ),
              ),
              const TextSpan(text: " joined the "),
              TextSpan(
                text: notification.projectName ?? "project",
                style: sataoshiBold.copyWith(
                  fontSize: 14,
                  color: AppColors.primaryTxt,
                ),
              ),
              const TextSpan(text: " project."),
            ],
          ),
        );

      case "New Task Assigned":
        return RichText(
          text: TextSpan(
            style: sataoshiRegular.copyWith(
              fontSize: 14,
              color: AppColors.primaryTxt,
              height: 1.4,
            ),
            children: [
              TextSpan(
                text: notification.actorName ?? "Someone",
                style: sataoshiBold.copyWith(
                  fontSize: 14,
                  color: AppColors.primaryTxt,
                ),
              ),
              const TextSpan(text: ' assigned you a new task: "'),
              TextSpan(
                text: notification.taskName ?? "Task",
                style: sataoshiMedium.copyWith(
                  fontSize: 14,
                  color: AppColors.primary500,
                ),
              ),
              const TextSpan(text: '" in the '),
              TextSpan(
                text: notification.projectName ?? "project",
                style: sataoshiBold.copyWith(
                  fontSize: 14,
                  color: AppColors.primaryTxt,
                ),
              ),
              const TextSpan(text: " project."),
            ],
          ),
        );

       case "New Meeting Scheduled":
        return RichText(
          text: TextSpan(
            style: sataoshiRegular.copyWith(
              fontSize: 14,
              color: AppColors.primaryTxt,
              height: 1.4,
            ),
            children: [
              const TextSpan(text: "Meeting Reminder: "),
              TextSpan(
                text: notification.meetingName ?? "Meeting",
                style: sataoshiBold.copyWith(
                  fontSize: 14,
                  color: AppColors.primaryTxt,
                ),
              ),
              TextSpan(
                text: " ${notification.meetingDate != null ? 'scheduled for ${notification.meetingDate}' : 'starts soon'}.",
              ),
            ],
          ),
        );

      case "PROJECT_UPDATED":
        // "Project <project name> was updated."
        return RichText(
          text: TextSpan(
            style: sataoshiRegular.copyWith(
              fontSize: 14,
              color: AppColors.primaryTxt,
              height: 1.4,
            ),
            children: [
              const TextSpan(text: "Project "),
              TextSpan(
                text: notification.projectName ?? "project",
                style: sataoshiBold.copyWith(
                  fontSize: 14,
                  color: AppColors.primaryTxt,
                ),
              ),
              const TextSpan(text: " was updated."),
            ],
          ),
        );
        default:
        return Container();
    }
  }

  String _formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d ago";
    } else {
      return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    }
  }
}
